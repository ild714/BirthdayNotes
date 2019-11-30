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
    
    init(name: String,image: String){
        self.name = name
        self.image = image
    }
}
