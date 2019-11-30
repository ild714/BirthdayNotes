//
//  MainViewController.swift
//  BirthdayNotes
//
//  Created by Ильдар Нигметзянов on 23.11.2019.
//  Copyright © 2019 SberBank. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let names = ["test","test","test","test"]
    let layout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientCollectionView = GradientView()
        gradientCollectionView.colors = [.green,.yellow]
        
        
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: view.frame,collectionViewLayout: layout)
        collectionView.backgroundView = gradientCollectionView
        view.addSubview(collectionView)
        collectionView!.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    var gradientView: GradientView {
        return collectionView.backgroundView as! GradientView
    }

}

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        let name = names[indexPath.item]
        cell.label.text = name
        return cell
    }
    
    
}
