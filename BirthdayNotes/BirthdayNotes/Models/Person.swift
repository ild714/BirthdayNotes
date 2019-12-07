//
//  Person.swift
//  BirthdayNotes
//
//  Created by Ильдар Нигметзянов on 30.11.2019.
//  Copyright © 2019 SberBank. All rights reserved.
//

import UIKit

class Person: NSObject,Codable {
    var name: String
    var image: String
    var date: Date?
    
    init(name: String,image: String,date:Date?){
        self.name = name
        self.image = image
        self.date = date
    }
}
