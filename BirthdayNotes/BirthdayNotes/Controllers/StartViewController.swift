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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelExplonation = UILabel()
        
        labelExplonation.text = "Birthday notes"
        labelExplonation.textColor = .black
        labelExplonation.font = UIFont.boldSystemFont(ofSize: 30)
        labelExplonation.adjustsFontSizeToFitWidth = true
        labelExplonation.translatesAutoresizingMaskIntoConstraints = false
        
        buttonStart = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 150))
        buttonStart.translatesAutoresizingMaskIntoConstraints = false
        buttonStart.layer.cornerRadius = 10
        buttonStart.titleLabel?.font = .systemFont(ofSize: 25)
        buttonStart.backgroundColor = .white
        buttonStart.setTitleColor(.black, for: .normal)
        buttonStart.setTitle("Start!", for: .normal)
        buttonStart.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        view.addSubview(buttonStart)
        
        
        view.addSubview(labelExplonation)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([labelExplonation.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: 60),
            labelExplonation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStart.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStart.topAnchor.constraint(equalTo: labelExplonation.bottomAnchor, constant: 200)])
        
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
