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
    
    private var countTF = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        infoTextField.delegate = self
        
        infoTextField.returnKeyType = .next
        infoTextField.autocorrectionType = .no
     }
    
    func fillLabel(infoLabel: String, isPassword: Bool) {
        
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
            if currentText.count > 30 {
                return false
            }
            return true
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        
        if let nextField = textField.superview?.viewWithTag(countTF + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            
            textField.resignFirstResponder()
        }
        countTF += 1
        return false
        
        
    }
    
}
