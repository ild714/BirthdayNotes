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
    
    
    private func randomGradientColor() -> [UIColor]{
        return [UIColor.random(),UIColor.random()]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat(Float.random(in: 100...240)/255)
        let green = CGFloat(Float.random(in: 100...240)/255)
        let blue = CGFloat(Float.random(in: 100...240)/255)
        return UIColor(red: red, green: green, blue: blue, alpha: 0.5)
    }
}
