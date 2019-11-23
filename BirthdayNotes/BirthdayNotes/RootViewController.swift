//
//  RootViewController.swift
//  BirthdayNotes
//
//  Created by Ильдар Нигметзянов on 23.11.2019.
//  Copyright © 2019 SberBank. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    private var currentViewController: UIViewController
    
    init() {
        let alreadyStarted = UserDefaults.standard.bool(forKey: "started")
        if alreadyStarted {
            currentViewController = MainViewController()
        } else {
        currentViewController = StartViewController()
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        addChild(currentViewController)
        currentViewController.view.frame = view.bounds
        view.addSubview(currentViewController.view)
        currentViewController.didMove(toParent: self)
        
        view.backgroundColor = .white
    }
    
    func showMainViewController() {
        let mainViewController = MainViewController()
        addChild(mainViewController)
        mainViewController.view.frame = view.bounds
        view.addSubview(mainViewController.view)
        mainViewController.didMove(toParent: self)
        currentViewController.willMove(toParent: nil)
        currentViewController.view.removeFromSuperview()
        currentViewController.removeFromParent()
        currentViewController = mainViewController
    }
    
    
}
