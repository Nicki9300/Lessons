//
//  UiView(extension).swift
//  Mamchur
//
//  Created by Kolya Mamchur on 26.02.2021.
//

import UIKit

extension UIView {
    
    func makeRoundedAndShadowed(view: UIView) {
        let shadowLayer = CAShapeLayer()
        
        view.layer.cornerRadius = 10
        shadowLayer.path = UIBezierPath(roundedRect: view.bounds,
                                        cornerRadius: view.layer.cornerRadius).cgPath
        shadowLayer.fillColor = view.backgroundColor?.cgColor
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        shadowLayer.shadowOpacity = 0.4
        shadowLayer.shadowRadius = 5.0
        view.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
}


extension UITextField {
   
    }
