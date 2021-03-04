//
//  ProfileViewController.swift
//  Mamchur
//
//  Created by Коля Мамчур on 01.03.2021.
//

import UIKit
import NotificationCenter

class ProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var updateProfilePictureButton: UIButton!
    @IBOutlet weak var largeButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var countTags = 0
    private var countTF = 1

    
    //MARK: Properties
    private var timer: Timer?
   
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rounding()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(gesture:)))
        longPress.minimumPressDuration = 0
        largeButton.addGestureRecognizer(longPress)

        
        tableView.register(CustomTextFieldTableViewCell.self)
        tableView.register(ButtonTableViewCell.self)
        
        tableView.delegate = self
        tableView.dataSource = self
        
      
        
    }
    
    func rounding() {
        
        updateProfilePictureButton.layer.cornerRadius = updateProfilePictureButton.layer.frame.height / 2
        updateProfilePictureButton.layer.borderWidth = 3
        updateProfilePictureButton.layer.borderColor = UIColor(named: "BorderButtonColor")?.cgColor
        
    }
    

    
    // MARK: - Actions
    @objc func longPress(gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == .began {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (_) in
                self.largeButton.setImage(UIImage(named: "windows2"), for: .normal)
            }
        }
        
        if gesture.state == .ended {
            self.largeButton.setImage(UIImage(named: "windows"), for: .normal)
            timer?.invalidate()
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
//        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
//
//                self.view.frame.origin.y -= tableView.visibleCells[0].frame.height
//
//        }
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height - tableView.visibleCells[0].frame.height
                }
            }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        
    }
    
}


extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: HeaderTableViewCell = .fromNib()
        if section == 0 {
            header.headerLabel.text = "INFO LABEL"
        } else {
            header.headerLabel.text = "CHANGE PASSWORD"
            
        }
        return header
    }
    
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return EnumFirstSection.allCases.count
        } else {
            return EnumSecondSection.allCases.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.create(CustomTextFieldTableViewCell.self, indexPath)
   
        cell.infoTextField.delegate = self
        cell.infoTextField.tag = countTags
        countTags += 1
        
        if indexPath.section == 0 {
            guard let type = EnumFirstSection.init(rawValue: indexPath.row) else {
                return UITableViewCell()
            }
            switch  type {
            case .firstName:
                cell.fillLabel(infoLabel: "First Name", isPassword: false)
             case .secondName:
                cell.fillLabel(infoLabel: "second Name", isPassword: false)
            case .emailAdress:
                cell.fillLabel(infoLabel: "email Adress", isPassword: false)
            case .mobileNumber:
                cell.fillLabel(infoLabel: "mobile Number", isPassword: false)
            }
            return cell
        } else {
            guard let type = EnumSecondSection.init(rawValue: indexPath.row) else {
                return UITableViewCell()
            }
            
            switch type {
            case .newPassword:
                cell.fillLabel(infoLabel: "NEW password", isPassword: true)
            case .retypeNewPassword:
                cell.fillLabel(infoLabel: "RETYPE NEW password", isPassword: true)
            case .button:
                let cell = tableView.create(ButtonTableViewCell.self, indexPath)
                return cell
            }
            
            
     
            return cell
        }
    }
    
}


extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
      
        
        if let nextTextField = self.tableView.viewWithTag(textField.tag + 1) as? UITextField {

            nextTextField.becomeFirstResponder()
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
            
        } else {
            
            textField.resignFirstResponder()
        }
        
        
       
        countTF += 1
        return true
        
        
    }
    
}
