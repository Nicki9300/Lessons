//
//  HeaderTableViewCell.swift
//  SomeTable
//
//  Created by Коля Мамчур on 03.03.2021.
//

import UIKit

protocol HeaderTableViewCellProtocol {
  
}

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetContent()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetContent()
    }
     
    private func resetContent() {
      
    }
    
    private func setupView() {
        
    }
    
}

extension HeaderTableViewCell: HeaderTableViewCellProtocol {
    
}
