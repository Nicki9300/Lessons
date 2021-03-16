//
//  ViewController.swift
//  Mamchur
//
//  Created by Kolya Mamchur on 26.02.2021.
//

import UIKit

class WallViewController: UIViewController {

    enum EnumOfCells {
        
        case SimpleTableViewCell
        case WithGreenImageTableViewCell
        case LargeImageTableViewCell
    }
    
     // MARK: - IBOutlets
    @IBOutlet weak var userTableView: UITableView!
    
    
    @IBOutlet weak var leftViewForTopShadow: UIView!
    @IBOutlet weak var rightViewForTopShadow: UIView!
    
     //MARK: Properties
    private var arrayOfCells = [EnumOfCells]()
    
    var userData : [UserData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurateUserTableView()
        createModel()
        
        makeTopShadow()
        
        setupCellsOfArray()
        
        self.view.backgroundColor = UIColor(named: "MainBackgroundColor") ?? .white
    }
    
   private func configurateUserTableView() {
        
        userTableView.delegate = self
        userTableView.dataSource = self
        
        userTableView.register(SimpleTableViewCell.self)
        userTableView.register(WithGreenImageTableViewCell.self)
        userTableView.register(LargeImageTableViewCell.self)
    }
    

    
    private func getItemOfIndex(_ index: Int) -> EnumOfCells {
        
        return arrayOfCells[index]
    }
    
   private func setupCellsOfArray() {
    
        arrayOfCells.append(.SimpleTableViewCell)
        arrayOfCells.append(.WithGreenImageTableViewCell)
        arrayOfCells.append(.LargeImageTableViewCell)
        arrayOfCells.append(.SimpleTableViewCell)
    }
    
   private func createModel() {
        
        userData = [UserData(name: "TopAhtlete85",
                             time: "12:45 Uhr",
                             avatarImage: UIImage(named: "Avatar")!,
                             newsDescription: "Ice trainiere gerade. Feuer mich an!",
                             currentLike: 2,
                             textLabel: nil,
                             largeImage: UIImage(named: "largeImage")!),
                    UserData(name: "Some Name",
                             time: "10: 30 PM",
                             avatarImage: UIImage(named: "Avatar")!,
                             newsDescription: "is not compatible with expected argument type ",
                             currentLike: 4,
                             textLabel: "👍",
                             largeImage: UIImage(named: "largeImage")!),
                    UserData(name: "TopAhtlete85",
                             time: "9:12 AM",
                             avatarImage: UIImage(named: "Avatar")!,
                             newsDescription: "Will attempt to recover by breaking constraint Will attempt to recover by breaking constraint Will attempt to recover by breaking constraint Will attempt to recover by breaking constraint Will attempt to recover by breaking constraint Will attempt to recover by breaking constraint ",
                             currentLike: 10,
                             textLabel: "👍",
                             largeImage: UIImage(named: "largeImage")!),
                    UserData(name: "TopAhtlete5",
                             time: "5: 32 AM",
                             avatarImage: UIImage(named: "Avatar")!,
                             newsDescription: "Type of expression is ambiguous without more contextType of expression is ambiguous without more contextType of expression is ambiguous without more context",
                             currentLike: 42,
                             textLabel: "💪",
                             largeImage: UIImage(named: "largeImage")!)]
        
    }
    
   private func makeTopShadow() {
        
        self.view.layoutIfNeeded()
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: leftViewForTopShadow.bounds.width, height: leftViewForTopShadow.bounds.height)
        gradient.type = .axial
        let  leftColor = UIColor(named: "Shadow") ?? UIColor.white
        let  rightColor = UIColor(named: "MainBackgroundColor") ?? UIColor.black
        gradient.colors =  [rightColor.cgColor, leftColor.cgColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: -0.3, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        leftViewForTopShadow.alpha = 0.7
        leftViewForTopShadow.layer.insertSublayer(gradient, at: 0)
       
        
       
        let gradient1: CAGradientLayer = CAGradientLayer()
        gradient1.frame = CGRect(x: 0, y: 0, width: leftViewForTopShadow.bounds.width, height: leftViewForTopShadow.bounds.height)
        gradient1.type = .axial
        gradient1.colors =  [leftColor.cgColor, rightColor.cgColor]
        gradient1.locations = [0, 1]
        gradient1.startPoint = CGPoint(x: 0.3, y: 0.5)
        gradient1.endPoint = CGPoint(x: 1, y: 0.5)
        rightViewForTopShadow.alpha = 1
        rightViewForTopShadow.layer.insertSublayer(gradient1, at: 0)
    
        
    }
    

}

extension WallViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard userData.count == arrayOfCells.count else {return 0}
        return userData.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UIView()
        header.backgroundColor = .clear
        
        return header
        
    }
}

extension WallViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch getItemOfIndex(indexPath.section) {
        
        case .SimpleTableViewCell:
            let cell = tableView.create(SimpleTableViewCell.self, indexPath)
            cell.displayUserInterface(userData: userData[indexPath.section])
            return cell
            
        case .WithGreenImageTableViewCell:
            let cell = tableView.create(WithGreenImageTableViewCell.self, indexPath)
            cell.displayUserInterface(userData: userData[indexPath.section])
            return cell
            
        case .LargeImageTableViewCell:
            let cell = tableView.create(LargeImageTableViewCell.self, indexPath)
            cell.displayUserInterface(userData: userData[indexPath.section])
            return cell
            
        }
        
    }
    
}
