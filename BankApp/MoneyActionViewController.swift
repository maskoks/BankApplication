//
//  MoneyActionViewController.swift
//  BankApp
//
//  Created by Жеребцов Данил on 01.06.2021.
//

import UIKit
import RealmSwift

class MoneyActionViewController: UIViewController, UITextFieldDelegate {
    
    let bank = BankModel()
    let realm = try! Realm()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var stackLabels: UIStackView!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        setLabels()
        roundCorners(label: titleLabel)
        roundCorners(label: stackLabels)
        payButton.layer.cornerRadius = payButton.frame.height/2

    }

    
    func setLabels() {
        var amount: Double?
        let predcate = NSPredicate(format: "name = %@", "John")
        let dataPerson = realm.objects(UserProfile.self).filter(predcate).first
        
        titleLabel.text = dataPerson?.selectedOperationTitle
            switch dataPerson?.selectedOperationTag {
            case BankModel.Actions.topUpPhoneBalace.rawValue:
                    amount = dataPerson?.deposite
                    messageLabel.text = "Доступные для пополнения средства"
                case BankModel.Actions.getCash.rawValue:
                    amount = dataPerson?.deposite
                    messageLabel.text = "Доступно для снятия"
                case BankModel.Actions.topUpDeposite.rawValue:
                    amount = dataPerson?.cash
                    messageLabel.text = "Доступно для пополнения"
                case BankModel.Actions.credit.rawValue:
                    amount = dataPerson?.possibleCredit
                    messageLabel.text = "Лимит одобренного кредита"
                default:
                    break
            }
        
        
        if amount == nil {
            bank.invalidOperation = true
            catchError()
        } else {
            amountLabel.text = String(amount!)
        }
    }
    
    func catchError() {
        try! bank.checkError()
        let alert = UIAlertController(title: bank.errorMessage, message: nil, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title:"OK", style: .cancel, handler: {_ in self.bank.resetErrors()})
        alert.addAction(okAlertAction)
        present(alert, animated: true, completion: nil)
    }
    
   
    

    @IBAction func payActionButton(_ sender: Any) {
        bank.errorMessage = nil
        let enteredAmount = textField.text
        let predcate = NSPredicate(format: "name = %@", "John")
        let dataPerson = realm.objects(UserProfile.self).filter(predcate).first
        
        if enteredAmount == "" {
            bank.invalidData = true
            catchError()
        } else if Double(enteredAmount!)! > Double(amountLabel.text!)! {
            bank.insufficientFunds = true
            catchError()
        } else {
            switch dataPerson?.selectedOperationTag {
            
                case BankModel.Actions.topUpPhoneBalace.rawValue:
                    try! realm.write {
                        dataPerson?.phoneBalance += Double(enteredAmount!)!
                        dataPerson?.deposite -= Double(enteredAmount!)!
                    }
                    
                case BankModel.Actions.getCash.rawValue:
                    try! realm.write {
                        dataPerson?.cash += Double(enteredAmount!)!
                        dataPerson?.deposite -= Double(enteredAmount!)!
                    }
                    
                case BankModel.Actions.topUpDeposite.rawValue:
                    try! realm.write {
                        dataPerson?.deposite += Double(enteredAmount!)!
                        dataPerson?.cash -= Double(enteredAmount!)!
                    }
                    
                case BankModel.Actions.credit.rawValue:
                    try! realm.write {
                        dataPerson?.deposite += Double(enteredAmount!)!
                        dataPerson?.debtToABank += Double(enteredAmount!)!
                        dataPerson?.possibleCredit -= Double(enteredAmount!)!
                    }
                    
                default:
                    break
            }
            bank.addOperation(selectedOperation: titleLabel.text!, addedSum: Double(textField.text!)!)
        }
        
        
        guard let accessVC = storyboard?.instantiateViewController(withIdentifier: "AccessViewController") else { return }
        navigationController?.pushViewController(accessVC, animated: true)
        accessVC.navigationItem.hidesBackButton = true
    }
    
    func roundCorners(label: UIView) {
        let layer = label.layer
        layer.masksToBounds = true
        layer.cornerRadius = 20
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let inputTexts = textField.text!.components(separatedBy: ".")
        let hasDot = inputTexts.count == 2
        let maxDigitsAfterDot = 2
        
        if textField.text!.count == 0 && string == "." {
            return false
        }
        
        if hasDot && (string == "." || (inputTexts[1].count == maxDigitsAfterDot && string != "")) {
            return false
        }
    
        return true
    }
 
    
}
