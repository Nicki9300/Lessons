//
//  WithGreenImageTableViewCell.swift
//  MamchurKolya
//
//  Created by Коля Мамчур on 22.02.2021.
//

import UIKit

protocol WithGreenImageTableViewCellProtocol {
   
}

class WithGreenImageTableViewCell: SimpleTableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var greenLabel: UILabel!
    
     // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configurateGreenLabel()
        
    }
    
    override func displayUserInterface(userData: UserData) {
        super.displayUserInterface(userData: userData)
        greenLabel.text = userData.textLabel
    }
    
     // MARK: - UI
    private func configurateGreenLabel() {
        
        greenLabel.layer.cornerRadius = greenLabel.frame.height / 2
        greenLabel.layer.masksToBounds = true
        
    }

}

extension WithGreenImageTableViewCell: WithGreenImageTableViewCellProtocol {
  


    
    
}
