//
//  InputAlertController.swift
//  BirthdayNotes
//
//  Created by Ильдар Нигметзянов on 04.12.2019.
//  Copyright © 2019 SberBank. All rights reserved.
//

import UIKit

protocol InputDelegate: class {
    /// update UI by provided text
    func updateInputUI(text: String) 
}

class InputAlertController: UIAlertController {
    

    //MARK:- Properties
    weak var delegate: InputDelegate?
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createTextField()
        let test = MainViewController()
        test?.delegate = self 
    }
    
    //MARK:- Methods
    private func createTextField() {
        self.addTextField { (text) in
            text.placeholder = "Enter name"
        }
    }
    
    
    private func createAlertActions() {
        let action = UIAlertAction(title: "Add", style: .default) { [weak self] (_) in
            if let textField = self?.textFields?.first {
                self?.delegate?.updateInputUI(text: textField.text!)
            }
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
        addAction(action)
        addAction(cancelAction)
    }
    
}

extension InputAlertController: AlertDelegate {
    func updateDate(ofMainViewController: Person) {
        let action = UIAlertAction(title: "Add", style: .default) { [weak self] (_) in
                   
            if let textField = self?.textFields?.first {
                       ofMainViewController.name = textField.text!
                    
                       //self?.delegate?.updateInputUI(text: textField.text!)
                   }
               }
        let cancelAction = UIAlertAction(title: "cancel", style: .default, handler: nil)
        self.addAction(action)
        self.addAction(cancelAction)
    }
}
