//
//  ButtonTableViewCell.swift
//  Mamchur
//
//  Created by Kolya Mamchur on 01.03.2021.
//

import UIKit

protocol ButtonTableViewCellProtocol {
    
}

class ButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var saveUpdatesButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        saveUpdatesButton.setTitle("Save Updates", for: .normal)
        saveUpdatesButton.layer.cornerRadius = saveUpdatesButton.layer.frame.height / 2
    }
    @IBAction func pressedSaveUpdates(_ sender: Any) {        
    }
}
