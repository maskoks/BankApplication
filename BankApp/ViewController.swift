//
//  ViewController.swift
//  BankApp
//
//  Created by Жеребцов Данил on 01.06.2021.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, CustomCellDelegate {
    
    let bank = BankModel()
    let realm = try! Realm()
    let user = UserProfile()
    
    let actionTitles = ["Пополнить баланс телефона", "Заказать наличные", "Пополнить баланс депозита", "Мой профиль", "Заявка на кредит"]
    
    var balances: [ItemCell] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUser()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        let predcate = NSPredicate(format: "name = %@", "John")
        let dataPerson = realm.objects(UserProfile.self).filter(predcate).first
        
        balances.append(ItemCell(balance: String(dataPerson!.deposite), text: "Баланс вашего депозита"))
        balances.append(ItemCell(balance: String(dataPerson!.phoneBalance), text: "Баланс вашего телефона"))
        balances.append(ItemCell(balance: String(dataPerson!.cash), text: "Сумма наличных в кошельке"))
        
        print(realm.configuration.fileURL!)
    }


    func createUser() {
        do{
            try realm.write{
                realm.add(user)
            }
        } catch {
            print("error")
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        cell.delegate = self
        
        let title = actionTitles[indexPath.row]
        cell.actionButton.setTitle(title, for: .normal)
        cell.actionButton.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCollectionViewCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        cell.balanceLabel.text = balances[indexPath.row].balance
        cell.textLabel.text = balances[indexPath.row].text
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return balances.count
    }
    
    func actionButtonPressed(cell: CustomCell) {
        print(cell.actionButton.tag)
        let predcate = NSPredicate(format: "name = %@", "John")
        let dataPerson = realm.objects(UserProfile.self).filter(predcate).first
        guard let moneyActionVC = storyboard?.instantiateViewController(withIdentifier: "MoneyActionViewController") else { return }
        guard let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") else { return }
        if cell.actionButton.tag == BankModel.Actions.myProfile.rawValue {
            navigationController?.pushViewController(profileVC, animated: true)
        } else {
            navigationController?.pushViewController(moneyActionVC, animated: true)
            try! realm.write {
                dataPerson?.selectedOperationTitle = cell.actionButton.title(for: .normal)
                dataPerson?.selectedOperationTag = cell.actionButton.tag
            }
        }
    }
}

