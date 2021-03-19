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
    private var userFacebookEmail = ""
    private var credentials = Credentials(email: "", password: "")
    private var emailAndPassword = ""
    
    private let service = "www.MamchurLogin.com"
    private let userEmail = "userEmail"
    private let userPassword = "userPassword"
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        KeychainService.removePassword(service: service, account: userEmail)
//        KeychainService.removePassword(service: service, account: userPassword)
        checkSavedPasswordInLeychain()
       
        configurateFacebookButton()
        configurateAppleButton()
        loginFacebookButton.delegate = self
        
        if credentials.email != "" {
            userEmailTextField.delegate = self
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
    
    func checkSavedPasswordInLeychain() {
        guard let email = KeychainService.loadData(service: service, account: userEmail) else { return }
        guard let password =  KeychainService.loadData(service: service, account: userPassword) else { return }
        credentials.email = email
        credentials.password = password
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
                    self.userFacebookEmail = email      // user facebook email
                    print("user facebook email", self.userFacebookEmail)
                }
                
            }
            else if let error = error {
                print("error \(error)")
            }
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
                        self.userEmailTextField.text = self.credentials.email
                        self.userPasswordTextField.text = self.credentials.password
                        
                    } else {
                        let alertCotroller = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
                        alertCotroller.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alertCotroller, animated: true)
                    }
                }
            }
        } else {
            let alertCotroller = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
            alertCotroller.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertCotroller, animated: true)
        }
    }
    
    // MARK: - IBActions
    @IBAction func pressedButtonLogin(_ sender: Any) {
        if userEmailTextField.text?.count != 0  && userPasswordTextField.text?.count != 0 {
            if let password = userPasswordTextField?.text, let email = userEmailTextField?.text {

                KeychainService.removeData(service: service, account: userEmail)
                KeychainService.removeData(service: service, account: userPassword)
                
                KeychainService.saveData(service: service, for: userEmail, data: email)
                KeychainService.saveData(service: service, for: userPassword, data: password)
                
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
        guard let result = result else {return}
        if !result.isCancelled {
            fetchDataFacebookProfile()
            self.navigationController?.isNavigationBarHidden = true
            let secondViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginHelperViewController") as! LoginHelperViewController
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(secondViewController, animated: true)
                
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        userEmailTextField.isUserInteractionEnabled = true
        userEmailTextField.text = ""
    }
}

// MARK: TextField delegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {

        if credentials.email != "" && credentials.password != "" && userEmailTextField.text == "" {
            enableTouchID()
        }
    }
    
}
