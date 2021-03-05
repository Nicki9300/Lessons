//
//  ProfileViewController.swift
//  Mamchur
//
//  Created by Коля Мамчур on 01.03.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
     // MARK: - IBOutlets
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var updateProfilePictureButton: UIButton!
    @IBOutlet weak var largeButton: UIButton!
    
<<<<<<< HEAD
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    private var timer: Timer?
    private var countTags = 0
    private var countTF = 1
    
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
        
=======
     //MARK: Properties
    private let arrayOfInfoLabel = ["First name", "Second name", "Mobile number", "email adress"]
    private let arrayOfPasswordLabel = ["new password", "change password"]
    private let arrayOfHeaderLabel = ["Your info", "Change Password"]
    private var timer: Timer?
    
     // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
>>>>>>> parent of cbcfdb8 (Switching TextField)
        updateProfilePictureButton.layer.cornerRadius = updateProfilePictureButton.layer.frame.height / 2
        updateProfilePictureButton.layer.borderWidth = 3
        updateProfilePictureButton.layer.borderColor = UIColor(named: "BorderButtonColor")?.cgColor
        
<<<<<<< HEAD
    }
    
    // MARK: - Actions
    @objc func longPress(gesture: UILongPressGestureRecognizer) {
=======
        profileTableView.dataSource = self
        profileTableView.delegate = self
>>>>>>> parent of cbcfdb8 (Switching TextField)
        
        profileTableView.register(CustomTextFieldTableViewCell.self)
        profileTableView.register(ButtonTableViewCell.self)
        
<<<<<<< HEAD
        if gesture.state == .ended {
            self.largeButton.setImage(UIImage(named: "windows"), for: .normal)
            timer?.invalidate()
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
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

=======
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(gesture:)))
        longPress.minimumPressDuration = 0
        largeButton.addGestureRecognizer(longPress)
>>>>>>> parent of cbcfdb8 (Switching TextField)

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
        
      
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return arrayOfInfoLabel.count
        }  else {
            return arrayOfHeaderLabel.count + 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
<<<<<<< HEAD
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
=======
        if indexPath.section == arrayOfHeaderLabel.count - 1 && indexPath.row == arrayOfPasswordLabel.count {
            let cell = tableView.create(ButtonTableViewCell.self, indexPath)
            return cell
        } else {
            let cell = tableView.create(CustomTextFieldTableViewCell.self, indexPath)
           
            if indexPath.section == 0 {
                cell.filllabel(infoLabel: arrayOfInfoLabel[indexPath.row], isPassword: false)
            } else {
                cell.filllabel(infoLabel: arrayOfPasswordLabel[indexPath.row], isPassword: true)
             }
>>>>>>> parent of cbcfdb8 (Switching TextField)
            return cell
        }
    }

}

extension ProfileViewController: UITableViewDelegate {
    
<<<<<<< HEAD
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
=======
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayOfHeaderLabel.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: HeaderView = .fromNib()
        header.fillHeaderLabel(headerLabel: arrayOfHeaderLabel[section])
>>>>>>> parent of cbcfdb8 (Switching TextField)
        
        return header
        
    }
}
