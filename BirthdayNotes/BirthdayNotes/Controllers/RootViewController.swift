//
//  RootViewController.swift
//  BirthdayNotes
//
//  Created by Ильдар Нигметзянов on 23.11.2019.
//  Copyright © 2019 SberBank. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    //MARK:- Properties
    private var currentViewController: UIViewController
    
    init() {
        let alreadyStarted = UserDefaults.standard.bool(forKey: "started")
        if alreadyStarted {
            let navigationController = UINavigationController(rootViewController: MainViewController())
            currentViewController = navigationController
        } else {
        currentViewController = StartViewController()
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
        addChild(currentViewController)
        currentViewController.view.frame = view.bounds
        view.addSubview(currentViewController.view)
        currentViewController.didMove(toParent: self)
        
        view.backgroundColor = .white
    }
    
    //MARK:- Methods
    func showMainViewController() {
        let mainViewController = MainViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        addChild(navigationController)
        navigationController.view.frame = view.bounds
        view.addSubview(navigationController.view)
        navigationController.didMove(toParent: self)
        currentViewController.willMove(toParent: nil)
        currentViewController.view.removeFromSuperview()
        currentViewController.removeFromParent()
        currentViewController = navigationController
    }
    
    
}
