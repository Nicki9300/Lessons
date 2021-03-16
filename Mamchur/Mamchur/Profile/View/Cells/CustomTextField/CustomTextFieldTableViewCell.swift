//
//  CustomTextFieldTableViewCell.swift
//  Mamchur
//
//  Created by Kolya Mamchur on 01.03.2021.
//

import UIKit

class CustomTextFieldTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var userInfoTextField: UITextField!
    
    private var countTextField = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userInfoTextField.delegate = self
        
        userInfoTextField.returnKeyType = .next
        userInfoTextField.autocorrectionType = .no
     }
    
    func fillLabel(infoLabel: String, isPassword: Bool) {
        
        self.userInfoLabel.text = infoLabel.uppercased()
        
        if isPassword{
            userInfoTextField.textContentType = .oneTimeCode
            
        } else {
            userInfoTextField.isSecureTextEntry = false
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
       
        
        if let nextField = textField.superview?.viewWithTag(countTextField + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            
            textField.resignFirstResponder()
        }
        countTextField += 1
        return false
        
        
    }
    
}
