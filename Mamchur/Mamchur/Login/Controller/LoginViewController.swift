//
//  LoginViewController.swift
//  Mamchur
//
//  Created by Kolya Mamchur on 17.03.2021.
//

import UIKit
import AuthenticationServices
import FBSDKLoginKit
import LocalAuthentication

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var loginFacebookButton: FBLoginButton!
    @IBOutlet weak var loginAppleButton: ASAuthorizationAppleIDButton!
    @IBOutlet weak var viewLoginApple: UIView!
    
    //MARK: Properties
    private var userIdentifierApple = ""
    private var email = ""
    private var password = ""
    private let server = "www.MamchurLogin.com"
    private var credentials = Credentials(username: "", password: "")
    private var emailAndPassword = ""
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        decomposeEmailAndPassword()
        configurateFacebookButton()
        configurateAppleButton()

        if email != "" && password != "" {
            userEmailTextField.delegate = self
            enableTouchID()
        }
 
    }
    
    // MARK: - Actions
    func configurateFacebookButton() {
        
        if let token = AccessToken.current, !token.isExpired {
            self.navigationController?.isNavigationBarHidden = true
            let secondViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginHelperViewController") as! LoginHelperViewController
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(secondViewController, animated: true)
            }
            
        } else {
            loginFacebookButton.delegate = self
            loginFacebookButton.permissions = ["email"]
        }
    
    }
    
    func configurateAppleButton() {
        
        let appleLogInButton : ASAuthorizationAppleIDButton = {
            let button = ASAuthorizationAppleIDButton()
            button.addTarget(self, action: #selector(handleLogInWithAppleID), for: .touchUpInside)
            return button
        }()
        viewLoginApple.addSubview(appleLogInButton)
    }

    @objc func handleLogInWithAppleID() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    func fetchDataFacebookProfile() {
        
        guard let accessToken = FBSDKLoginKit.AccessToken.current else { return }
        let graphRequest = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                      parameters: ["fields": "email, name"],
                                                      tokenString: accessToken.tokenString,
                                                      version: nil,
                                                      httpMethod: .get)
        graphRequest.start { (connection, result, error) -> Void in
            if let resultDict = result as? [String:Any]{
                if let email = resultDict["email"] as? String  {
                    self.email = email
                    self.userEmailTextField.text = email
                    self.userEmailTextField.isUserInteractionEnabled = false
                }
                
            }
            else if let error = error {
                print("error \(error)")
            }
        }
    }
    
    func decomposeEmailAndPassword() {
        guard var newValue = KeychainService.loadPassword(service: server, account: server) else { return }
        if newValue.isEmpty {
            
        } else {
            self.email = String(newValue.split {$0 == " "}.first!)
            
            for _ in 0...email.count  {
                newValue.removeFirst()
            }
            self.password = newValue
            print(self.email)
            print(self.password)
        }
        
    }
    
    func enableTouchID() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self.userEmailTextField.text = self.email
                        self.userPasswordTextField.text = self.password
                        
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    // MARK: - IBActions
    @IBAction func pressedButtonLogin(_ sender: Any) {
        if userEmailTextField.text?.count != 0  && userPasswordTextField.text?.count != 0 {
            if let password = userPasswordTextField?.text, let email = userEmailTextField?.text {

                self.emailAndPassword =   email + " " + password
                KeychainService.removePassword(service: server, account: server)
                KeychainService.savePassword(service: server, account: server, data: emailAndPassword)
                decomposeEmailAndPassword()
                //                self.navigationController?.isNavigationBarHidden = true
                let secondViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginHelperViewController") as! LoginHelperViewController
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(secondViewController, animated: true)
                    
                }
            }
            
        }
    }
    
}

// MARK: APPLE Login
extension LoginViewController : ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            
            let defaults = UserDefaults.standard
            defaults.set(userIdentifier, forKey: "userIdentifier1")
            print("Autorization")
            break
        default:
            break
        }
        
        
        
    }
}
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}


// MARK: FACEBOOK login
extension LoginViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        fetchDataFacebookProfile()
        self.navigationController?.isNavigationBarHidden = true
        let secondViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginHelperViewController") as! LoginHelperViewController
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(secondViewController, animated: true)
            
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        userEmailTextField.isUserInteractionEnabled = true
        userEmailTextField.text = ""
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if email != "" && password != "" && userEmailTextField.text == "" {
            userEmailTextField.delegate = self
            enableTouchID()
        }
        
    }
    
}
