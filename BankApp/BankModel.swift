//
//  BankModel.swift
//  BankApp
//
//  Created by Жеребцов Данил on 02.06.2021.
//

import Foundation
import UIKit
import RealmSwift



class BankModel {
    var errorMessage: String?
    
    var invalidData = false
    var invalidOperation = false
    var insufficientFunds = false
    
    enum Actions: Int {
        case topUpPhoneBalace
        case getCash
        case topUpDeposite
        case myProfile
        case credit
    }
    
    enum AutoError: Error {
        case invalidData
        case invalidOperation
        case insufficientFunds
    }
    
    func resetErrors() {
        invalidData = false
        invalidOperation = false
        insufficientFunds = false
        
        errorMessage = nil
    }
    
    func checkError() throws {
        do {
            if invalidData {
                throw AutoError.invalidData
            }
            
            if invalidOperation {
                throw AutoError.invalidOperation
            }
            
            if insufficientFunds {
                throw AutoError.insufficientFunds
            }
        } catch AutoError.invalidData {
            errorMessage = "Введите сумму"
        } catch AutoError.invalidOperation {
            errorMessage = "Операция недоступна"
        } catch AutoError.insufficientFunds {
            errorMessage = "Недостаточно средств"
        }
    }
    
    
    func addOperation(selectedOperation: String, addedSum: Double) {
        let realm = try! Realm()
        
        let someOperation = Operation()
        someOperation.sum = addedSum
        someOperation.operation = selectedOperation
        someOperation.timeAndDate = Date()
        
        try! realm.write {
            realm.add(someOperation)
        }
    }
    
   
}



