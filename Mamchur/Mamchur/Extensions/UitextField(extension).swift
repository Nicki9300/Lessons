//
//  UITextField(extension).swift
//  Mamchur
//
<<<<<<< Updated upstream
//  Created by Коля Мамчур on 04.03.2021.
=======
//  Created by Kolya Mamchur on 04.03.2021.
>>>>>>> Stashed changes
//

import UIKit

class CustomTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width / 2 + 30, bottom: 0, right: 0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: padding)
    }
}
