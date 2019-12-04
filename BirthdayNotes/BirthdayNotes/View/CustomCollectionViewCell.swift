//
//  CustomCollectionViewCell.swift
//  BirthdayNotes
//
//  Created by Ильдар Нигметзянов on 30.11.2019.
//  Copyright © 2019 SberBank. All rights reserved.
//

import UIKit
import UserNotifications

class CustomCollectionViewCell: UICollectionViewCell {
    public static var identifier = "Cell"
    
    public var label = UILabel()
    public var image = UIImageView()
    public var dateTextField = UITextField()
    public var datePicker: UIDatePicker?
    
    override init (frame: CGRect){
        super.init(frame: frame)
        //self.alpha = 0
        let gradientCollectionView = GradientView()
        gradientCollectionView.colors = randomGradientColor()
        gradientCollectionView.layer.cornerRadius = 15
        
        self.backgroundView = gradientCollectionView
        
        
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        dateTextField.text = "Put date"
        dateTextField.textAlignment = .center
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(self.dateChanged(datePicker:)), for: .valueChanged)
        
        
       // let tapGesture = UITapGestureRecognizer(target: gradientCollectionView, action: #selector(self.viewTapped(gestureRecognizers:)))
        
        dateTextField.inputView = datePicker
        //dateTextField.text =
        
        contentView.addSubview(dateTextField)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(image)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 1),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1),
            dateTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 2),
            dateTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            dateTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            image.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 1),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
            ])
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        self.endEditing(true)
    }

    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM/dd/yyyy"
        dateTextField.text = dateFormater.string(from: datePicker.date)
        
        let month : String
        dateFormater.dateFormat = "MM"
        month = dateFormater.string(from: datePicker.date)
        let day : String
        dateFormater.dateFormat = "dd"
        day = dateFormater.string(from: datePicker.date)
        print(Int(month))
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Burthday"
        content.body = "\(label.text!)"
        content.categoryIdentifier = "alarm"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.month = Int(month)!
        dateComponents.day = Int(day)!
        dateComponents.hour = 16
        dateComponents.minute = 50
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        self.endEditing(true)
    }
    
    private func randomGradientColor() -> [UIColor]{
        return [UIColor.random(),UIColor.random()]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat(Float.random(in: 0...255)/255)
        let green = CGFloat(Float.random(in: 0...255)/255)
        let blue = CGFloat(Float.random(in: 0...255)/255)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
