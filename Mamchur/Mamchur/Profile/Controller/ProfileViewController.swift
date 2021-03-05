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
<<<<<<< Updated upstream
    
     //MARK: Properties
    private let arrayOfInfoLabel = ["First name", "Second name", "Mobile number", "email adress"]
    private let arrayOfPasswordLabel = ["new password", "change password"]
    private let arrayOfHeaderLabel = ["Your info", "Change Password"]
=======
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
>>>>>>> Stashed changes
    private var timer: Timer?
    
     // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateProfilePictureButton.layer.cornerRadius = updateProfilePictureButton.layer.frame.height / 2
        updateProfilePictureButton.layer.borderWidth = 3
        updateProfilePictureButton.layer.borderColor = UIColor(named: "BorderButtonColor")?.cgColor
        
        profileTableView.dataSource = self
        profileTableView.delegate = self
        
        profileTableView.register(CustomTextFieldTableViewCell.self)
        profileTableView.register(ButtonTableViewCell.self)
        
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(gesture:)))
        longPress.minimumPressDuration = 0
        largeButton.addGestureRecognizer(longPress)

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
            return cell
        }
    }

}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayOfHeaderLabel.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: HeaderView = .fromNib()
        header.fillHeaderLabel(headerLabel: arrayOfHeaderLabel[section])
        
        return header
        
    }
}
