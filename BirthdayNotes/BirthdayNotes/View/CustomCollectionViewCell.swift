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
    
    public let label = UILabel()
    public let image = UIImageView()
    
    override init (frame: CGRect){
        super.init(frame: frame)
        //self.alpha = 0
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        label.frame = contentView.frame
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        contentView.addSubview(label)
        
        contentView.addSubview(image)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            label.widthAnchor.constraint(equalToConstant: 20),
            image.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            image.widthAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
