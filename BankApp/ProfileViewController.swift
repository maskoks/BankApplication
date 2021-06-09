//
//  ProfileViewController.swift
//  BankApp
//
//  Created by Жеребцов Данил on 06.06.2021.
//

import UIKit
import RealmSwift

class ProfileViewController: UITableViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var phoneBalanceLabel: UILabel!
    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var depositeLabel: UILabel!
    @IBOutlet weak var debtLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setProfileLabel()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
    }
    
    func setProfileLabel() {
        let predcate = NSPredicate(format: "name = %@", "John")
        let dataPerson = realm.objects(UserProfile.self).filter(predcate).first
        
        
        nameLabel.text = dataPerson?.name
        surnameLabel.text = dataPerson?.surname
        phoneNumberLabel.text = dataPerson?.phoneNumber
        phoneBalanceLabel.text = String(dataPerson!.phoneBalance)
        cashLabel.text = String(dataPerson!.cash)
        depositeLabel.text = String(dataPerson!.deposite)
        debtLabel.text = String(dataPerson!.debtToABank)
        
        
    }

}
