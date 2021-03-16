//
//  HeaderTableViewCell.swift
//  SomeTable
//
//  Created by Kolya Mamchur on 03.03.2021.
//

import UIKit

protocol HeaderTableViewCellProtocol {
  
}

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    
    }

    
}

extension HeaderTableViewCell: HeaderTableViewCellProtocol {
    
}
