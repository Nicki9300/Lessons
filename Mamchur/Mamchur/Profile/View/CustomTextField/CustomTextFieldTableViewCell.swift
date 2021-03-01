//
//  CustomTextFieldTableViewCell.swift
//  Mamchur
//
//  Created by Коля Мамчур on 01.03.2021.
//

import UIKit


class CustomTextFieldTableViewCell: UITableViewCell {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        infoTextField.delegate = self
        infoTextField.returnKeyType = .next
        infoTextField.autocorrectionType = .no
        
        infoTextField.returnKeyType = .next
        
        
    }
    
    func filllabel(infoLabel: String, isPassword: Bool) {
        
        self.infoLabel.text = infoLabel.uppercased()
        
        if isPassword{
            infoTextField.textContentType = .oneTimeCode
            
        } else {
            infoTextField.isSecureTextEntry = false
        }
    }
    
    
}

extension CustomTextFieldTableViewCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let txt = textField.text {
            let currentText = txt + string
            if currentText.count > 15 {
                return false
            }
            return true
        }
        return true
    }
    
}
