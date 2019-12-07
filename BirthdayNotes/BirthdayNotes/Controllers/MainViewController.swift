//
//  MainViewController.swift
//  BirthdayNotes
//
//  Created by Ильдар Нигметзянов on 23.11.2019.
//  Copyright © 2019 SberBank. All rights reserved.
//

import UIKit
import UserNotifications


class MainViewController: UIViewController  {

    //MARK:- Properties
    var persons = [Person]()
    let layout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView!
    
    //MARK:- Lifecycle
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
        gradientCollectionView.colors = [.yellow,UIColor(displayP3Red: 10, green: 232, blue: 23, alpha: 1)]
        
        
        layout.itemSize = CGSize(width: 150, height: 200)
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Turn on notifications", style: .plain, target: self, action: #selector(registerLocal))
    }
    
    //MARK:- Methods
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) {(granted, error) in
            if granted {
                print("Notification turned on")
            } else {
                print("Notification turned off")
            }
        }
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
        let inputAlert = InputAlertController(title: "Change name or date", message: nil, preferredStyle:.alert)
        
        inputAlert.delegate = self
        inputAlert.addTextField { (textField1) in
            textField1.placeholder = "Change name"
        }
        
        inputAlert.name = persons[indexPath.row].name
        inputAlert.index = indexPath.row
        
        present(inputAlert,animated: true,completion: nil)
    }
}

//MARK:- CollectionView DataSource and Delegate
extension MainViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return persons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        let person = persons[indexPath.item]
        
        
        cell.label.text = person.name
        cell.image.image = UIImage(named: person.image)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM/dd/yyyy"
        cell.dateTextField.text = dateFormater.string(from: person.date ?? Date(timeIntervalSinceNow: 12))
        return cell
    }
}

//MARK:- ImagePicker ControllerDelegate, NavigationControllerDelegate
extension MainViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.9) {
            try? jpegData.write(to: imagePath)
        }
        
        
        let person = Person(name: "Family", image: imagePath.path,date: nil)
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

//MARK:- Save function
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

//MARK:- InputAlertController Delegate
extension MainViewController: InputDelegate {
    func updateInputUI(name: String,index: Int,date: Date?) {
        persons[index].name = name
        persons[index].date = date
        collectionView.reloadData()
        self.save()
    }
    
    func deleteCell(index: Int) {
        persons.remove(at: index)
        collectionView.reloadData()
        save()
    }
}





