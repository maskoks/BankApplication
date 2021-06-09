//
//  MyObject.swift
//  BankApp
//
//  Created by Жеребцов Данил on 01.06.2021.
//

import Foundation
import UIKit
import RealmSwift

class UserProfile: Object {
    @objc dynamic var name = "John"
    @objc dynamic var surname = "Smith"
    @objc dynamic var phoneNumber = "+79147089765"
    @objc dynamic var phoneBalance = 445.60
    @objc dynamic var cash = 2450.00
    @objc dynamic var deposite = 143756.83
    @objc dynamic var selectedOperationTitle: String?
    @objc dynamic var selectedOperationTag = -1
    @objc dynamic var possibleCredit = 200000.00
    @objc dynamic var debtToABank = 0.0
}


class Operation: Object {
    @objc dynamic var timeAndDate: Date? = nil
    @objc dynamic var operation: String? = nil
    @objc dynamic var sum = 0.0
}
