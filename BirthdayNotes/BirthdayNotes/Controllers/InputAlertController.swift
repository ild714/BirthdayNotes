//
//  InputAlertController.swift
//  BirthdayNotes
//
//  Created by Ильдар Нигметзянов on 04.12.2019.
//  Copyright © 2019 SberBank. All rights reserved.
//

import UIKit
import UserNotifications

protocol InputDelegate: class {
    /// update UI by provided name and date
    func updateInputUI(name: String,index: Int,date: Date?)
    /// delete Cell
    func deleteCell(index: Int)
}

class InputAlertController: UIAlertController {
    
    //MARK:- Properties
    weak var delegate: InputDelegate?
    var name: String!
    var index: Int!
    var datePicker = UIDatePicker()
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createAlertActions()
        createTextField2()
        deleteAlert()
    }
    
    //MARK:- Methods
    private func createTextField2() {
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.dateChanged(datePicker:)), for: .valueChanged)
        
        self.addTextField { (textField2) in
            textField2.placeholder = "Change date"
            textField2.inputView = self.datePicker
        }
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM/dd/yyyy"
        self.textFields?[1].text = dateFormater.string(from: datePicker.date)
        
        let month : String
        dateFormater.dateFormat = "MM"
        month = dateFormater.string(from: datePicker.date)
        let day : String
        dateFormater.dateFormat = "dd"
        day = dateFormater.string(from: datePicker.date)
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Birthday"
        content.body = "\(name!)"
        content.categoryIdentifier = "alarm"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.month = Int(month)!
        dateComponents.day = Int(day)!
        dateComponents.hour = 14
        dateComponents.minute = 10
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    
    private func createAlertActions() {
        let action = UIAlertAction(title: "Change", style: .default) { [weak self] (_) in
            if let textField = self?.textFields?.first {
                self?.delegate?.updateInputUI(name: textField.text!,index: self?.index ?? 0,date: self?.datePicker.date)
            }
        }
        addAction(action)
    }
    
    private func deleteAlert() {
        self.addAction(UIAlertAction(title: "Delete", style: .destructive){ [weak self] (_) in
            self?.delegate?.deleteCell(index: self?.index ?? 0)
        })
    }
    
}

