//
//  StartViewController.swift
//  BirthdayNotes
//
//  Created by Ильдар Нигметзянов on 23.11.2019.
//  Copyright © 2019 SberBank. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    //MARK:- Properties
    var labelExplonation: UILabel!
    var buttonHeart: UIButton!
    var buttonStart: UIButton!
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        labelExplonation = UILabel()
        
        labelExplonation.text = "Birthday notes"
        labelExplonation.textColor = .black
        labelExplonation.font = UIFont.boldSystemFont(ofSize: 30)
        labelExplonation.adjustsFontSizeToFitWidth = true
        labelExplonation.translatesAutoresizingMaskIntoConstraints = false
        
        buttonStart = UIButton(type: .custom)
        buttonStart.layer.cornerRadius = 10
        buttonStart.setTitle("Start!", for: .normal)
        buttonStart.setTitleColor(.black, for: .normal)
        buttonStart.titleLabel?.font = .systemFont(ofSize: 27)
        //buttonStart.backgroundColor = .yellow
        buttonStart.titleLabel?.center = view.center
        buttonStart.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        buttonStart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStart)
        
        buttonHeart = UIButton(type: .custom)
        buttonHeart.titleLabel?.numberOfLines = 1
        
        buttonHeart.setImage(UIImage(named: "heart"),for: .normal)
        buttonHeart.translatesAutoresizingMaskIntoConstraints = false
        buttonHeart.titleLabel?.font = .systemFont(ofSize: 25)
        //buttonStart.backgroundColor = .white
        buttonHeart.setTitleColor(.black, for: .normal)
        buttonHeart.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        view.addSubview(buttonHeart)
        
        view.addSubview(labelExplonation)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([labelExplonation.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: 60),
            labelExplonation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStart.topAnchor.constraint(equalTo: labelExplonation.bottomAnchor, constant: 180),
            buttonStart.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonHeart.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonHeart.topAnchor.constraint(equalTo: buttonStart.bottomAnchor, constant: 10)])
        
    }
    
    //MARK:- Methods
    @objc func startButtonTapped() {
        let rootViewController = AppDelegate.shared.rootViewController
        UserDefaults.standard.set(true,forKey: "started")
        rootViewController.showMainViewController()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        buttonHeart.animate()
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
