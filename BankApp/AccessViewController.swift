//
//  AccessViewController.swift
//  BankApp
//
//  Created by Жеребцов Данил on 05.06.2021.
//

import UIKit
import RealmSwift

class AccessViewController: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var checkmarkImage: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIView.animate(withDuration: 2, delay: 0.2, options: .curveEaseInOut) {
            self.checkmarkImage.alpha = 1
        }
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        guard let homeVC = storyboard?.instantiateViewController(withIdentifier: "ViewController") else { return }
        homeVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(homeVC, animated: true)
        
        let predcate = NSPredicate(format: "name = %@", "John")
        let dataPerson = realm.objects(UserProfile.self).filter(predcate).first
        
        try! realm.write {
            dataPerson?.selectedOperationTitle = nil
            dataPerson?.selectedOperationTag = -1
        }
        
        homeVC.navigationItem.hidesBackButton = true
    }
    
}
