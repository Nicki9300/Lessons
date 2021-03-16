//
//  ParentTableViewCell.swift
//  MamchurKolya
//
//  Created by Kolya Mamchur on 22.02.2021.
//

import UIKit

protocol ParentTableViewCellProtocol {
    
    var likeHundler: (() -> ())? { get set }
    
}

class SimpleTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var currentLikeLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    //MARK: Properties
    private var pressedCurrentLike = true
    private var currentLike : Int?
    
    var likeHundler: (() -> ())?
 
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dropShadowAroundCells()
      
       }

     // MARK: - UI
    
    final private func dropShadowAroundCells() {
        
        self.contentView.layer.shadowPath = UIBezierPath(rect: self.contentView.bounds).cgPath
        self.contentView.layer.shadowPath = CGPath(roundedRect: CGRect(x: 0,
                                                                       y: 0,
                                                                       width: self.contentView.frame.width,
                                                                       height: self.contentView.frame.height),
                                                   cornerWidth: 5,
                                                   cornerHeight: 5,
                                                   transform: .none)
        
        self.contentView.layer.shadowRadius = 10
        self.contentView.layer.shadowOffset = .zero
        self.contentView.layer.shadowOpacity = 0.25
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        
    }
    
    private func setupView() {
        
        shadowForAvatarImage()
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = false
        
    }
    
    final private func shadowForAvatarImage() {
        
        avatarImage.layer.shadowOffset = CGSize (width: avatarImage.layer.bounds.width / 3,
                                                 height: avatarImage.layer.bounds.height / 3)
        avatarImage.layer.shadowRadius = 10
        avatarImage.layer.shadowOpacity = 0.18
        avatarImage.layer.masksToBounds = false
        
    }
    func displayUserInterface (userData: UserData) {
    
        self.avatarImage.image = userData.avatarImage
        self.nickNameLabel.text = userData.name
        self.timeLabel.text = userData.time
        self.newsDescriptionLabel.text = userData.newsDescription
        self.currentLike = userData.currentLike ?? 0
        self.currentLikeLabel.text = String(userData.currentLike ?? 0)
        
    }
        
    // MARK: - IBActions
    @IBAction func pressedLikeButton(_ sender: UIButton) {
        
        if (currentLike != nil) {
            currentLike = pressedCurrentLike ? currentLike! + 1 : currentLike! - 1
            pressedCurrentLike.toggle()
            likeHundler?()
            currentLikeLabel.text = String(currentLike!)
        }
    }
}

extension SimpleTableViewCell: ParentTableViewCellProtocol {
    
   
    
    
    
}

