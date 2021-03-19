//
//  LargeImageTableViewCell.swift
//  MamchurKolya
//
//  Created by Коля Мамчур on 22.02.2021.
//

import UIKit

protocol LargeImageTableViewCellProtocol {
    
}

class LargeImageTableViewCell: SimpleTableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var largeImage: UIImageView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        largeImage.layer.cornerRadius = 5
        largeImage.clipsToBounds = true
        
    }
    
    override func displayUserInterface(userData: UserData) {
        super.displayUserInterface(userData: userData)
        largeImage.image = userData.largeImage
    }
    
}

extension LargeImageTableViewCell: LargeImageTableViewCellProtocol {
    
    

    
}


