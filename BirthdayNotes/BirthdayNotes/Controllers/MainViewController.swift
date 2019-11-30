//
//  MainViewController.swift
//  BirthdayNotes
//
//  Created by Ильдар Нигметзянов on 23.11.2019.
//  Copyright © 2019 SberBank. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var persons = [Person]()
    let layout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        if let savedPersons = defaults.object(forKey: "persons") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                persons = try jsonDecoder.decode([Person].self,from: savedPersons)
            } catch {
                print("Failed to load persons")
            }
        }
        
        let gradientCollectionView = GradientView()
        gradientCollectionView.colors = [.yellow,.green]
        
        
        layout.itemSize = CGSize(width: 150, height: 150)
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPerson))
    }
    
    @objc func addPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker,animated: true)
    }
    
    var gradientView: GradientView {
        return collectionView.backgroundView as! GradientView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = persons[indexPath.item]
        
        let ac = UIAlertController(title: "Rename or delete cell", message: nil, preferredStyle: .alert)
        ac.addTextField { (text) in
            text.text = person.name
        }
        
        ac.addAction(UIAlertAction(title: "Ok", style: .default){[weak self,weak ac] _ in
            guard let newName = ac?.textFields?[0].text else {
                return
            }
            person.name = newName
            
            self?.collectionView.reloadData()
            self?.save()
        })
        
        ac.addAction(UIAlertAction(title: "Delete", style: .destructive){[weak self] _ in
            self?.persons.remove(at: indexPath.item)
            self?.collectionView.reloadData()
            self?.save()
        })
        
        
        present(ac,animated: true)
    }

}

//MARK: CollectionView DataSource and Delegate
extension MainViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return persons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        let person = persons[indexPath.item]
        cell.label.text = person.name
        cell.image.image = UIImage(named: person.image)
        return cell
    }
}

//MARK: ImagePicker ControllerDelegate, NavigationControllerDelegate
extension MainViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.9) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Family", image: imagePath.path)
        persons.append(person)
        collectionView.reloadData()
        save()
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

//MARK: Encode function
extension MainViewController {
    func save() {
        let jsonEncoder = JSONEncoder()
        if let saveData = try? jsonEncoder.encode(persons){
            let defaults = UserDefaults.standard
            defaults.set(saveData,forKey: "persons")
        } else {
            print("Failed to save persons")
        }
    }
    
}
