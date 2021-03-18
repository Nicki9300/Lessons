//
//  LoginHelperViewController.swift
//  Mamchur
//
//  Created by Kolya Mamchur on 18.03.2021.
//

import UIKit
import FBSDKLoginKit

class LoginHelperViewController: UIViewController {
    
    @IBOutlet weak var logOutFacebookButton: FBLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logOutFacebookButton.delegate = self
    }
    
}

extension LoginHelperViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        print(result)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        let firstViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(firstViewController, animated: true)

        }
    }
    
    
    
}
