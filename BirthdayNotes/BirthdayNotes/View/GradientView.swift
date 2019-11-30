//
//  GradientView.swift
//  BirthdayNotes
//
//  Created by Ильдар Нигметзянов on 30.11.2019.
//  Copyright © 2019 SberBank. All rights reserved.
//

import UIKit

final class GradientView: UIView {

    var colors: [UIColor] = [] {
        didSet {
            update()
        }
    }
    
    override class var layerClass: AnyClass{
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as? CAGradientLayer ?? CAGradientLayer()
    }
    
    func update() {
        gradientLayer.colors = colors.compactMap{$0.cgColor}
    }
    

}
