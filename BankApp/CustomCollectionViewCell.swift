//
//  CustomCollectionViewCell.swift
//  BankApp
//
//  Created by Жеребцов Данил on 01.06.2021.
//

import UIKit


struct ItemCell {
    var balance: String
    var text: String
}

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeCell(cell: self)
    }
    
    func customizeCell(cell: UICollectionViewCell) {
        let layer = cell.layer
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.borderColor = UIColor(named: "MainColor")?.cgColor
    }

}
