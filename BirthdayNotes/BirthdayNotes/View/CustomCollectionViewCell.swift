//
//  CustomCollectionViewCell.swift
//  BirthdayNotes
//
//  Created by Ильдар Нигметзянов on 30.11.2019.
//  Copyright © 2019 SberBank. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    public static var identifier = "Cell"
    
    public var label = UILabel()
    public var image = UIImageView()
    
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
        
        
        image.translatesAutoresizingMaskIntoConstraints = false
        //image.contentMode = .scaleToFill
        contentView.addSubview(image)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 1),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1),
            image.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
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
        let red = CGFloat(Float.random(in: 0...255)/255)
        let green = CGFloat(Float.random(in: 0...255)/255)
        let blue = CGFloat(Float.random(in: 0...255)/255)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
