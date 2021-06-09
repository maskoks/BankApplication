//
//  CustomCell.swift
//  BankApp
//
//  Created by Жеребцов Данил on 01.06.2021.
//

import UIKit

protocol CustomCellDelegate {
    func actionButtonPressed(cell: CustomCell)
}


class CustomCell: UITableViewCell {

    @IBOutlet weak var actionButton: UIButton!
    var delegate: CustomCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeButton(button: actionButton)
        addShaddow(button: actionButton)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func actionPressed(_ sender: Any) {
        delegate?.actionButtonPressed(cell: self)
    }
    
    func customizeButton(button: UIButton) {
        let layer = button.layer
        
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        
        button.backgroundColor = UIColor(named: "MainColor")
    }
    
    func addShaddow(button: UIButton) {
        let layer = button.layer
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 2)
        layer.shadowRadius = 1.8
        layer.shadowOpacity = 0.3
    }
    

    
}
