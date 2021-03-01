//
//  HeaderView.swift
//  Mamchur
//
//  Created by Коля Мамчур on 01.03.2021.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet weak var headerLabel: UILabel!
    
    func fillHeaderLabel(headerLabel: String) {
        
        self.headerLabel.text = headerLabel.uppercased()
   
    }
}
