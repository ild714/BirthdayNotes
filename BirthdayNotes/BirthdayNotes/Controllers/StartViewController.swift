//
//  StartViewController.swift
//  BirthdayNotes
//
//  Created by Ильдар Нигметзянов on 23.11.2019.
//  Copyright © 2019 SberBank. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    var labelExplonation: UILabel!
    var buttonStart: UIButton!
    var labelStart: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelExplonation = UILabel()
        
        labelExplonation.text = "Birthday notes"
        labelExplonation.textColor = .black
        labelExplonation.font = UIFont.boldSystemFont(ofSize: 30)
        labelExplonation.adjustsFontSizeToFitWidth = true
        labelExplonation.translatesAutoresizingMaskIntoConstraints = false
        
        labelStart = UILabel()
        labelStart.text = "Start!"
        labelStart.font = .systemFont(ofSize: 25)
        labelStart.adjustsFontSizeToFitWidth = true
        labelStart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelStart)
        
        
        buttonStart = UIButton(type: .custom)
        buttonStart.titleLabel?.numberOfLines = 2
        buttonStart.setImage(UIImage(named: "heart"),for: .normal)
        buttonStart.translatesAutoresizingMaskIntoConstraints = false
        buttonStart.titleLabel?.font = .systemFont(ofSize: 25)
        buttonStart.backgroundColor = .white
        buttonStart.setTitleColor(.black, for: .normal)
        buttonStart.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        view.addSubview(buttonStart)
        
        
        view.addSubview(labelExplonation)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([labelExplonation.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: 60),
            labelExplonation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelStart.topAnchor.constraint(equalTo: labelExplonation.bottomAnchor, constant: 180),
            labelStart.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStart.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStart.topAnchor.constraint(equalTo: labelStart.bottomAnchor, constant: 10)])
        
    }
    
    @objc func startButtonTapped() {
        let rootViewController = AppDelegate.shared.rootViewController
        UserDefaults.standard.set(true,forKey: "started")
        rootViewController.showMainViewController()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        buttonStart.animate()
    }
    
}

extension UIButton {
    func animate() {
        let tap = CASpringAnimation(keyPath: "transform.scale")
        
        tap.fromValue = 0.9
        tap.toValue = 1.0
        tap.repeatCount = HUGE
        tap.autoreverses = true
        tap.initialVelocity = 0.01
        tap.speed = 0.5
        
        layer.add(tap,forKey: nil)
    }
}
