//
//  ItemInfoViewController.swift
//  MealPicApp_AR
//
//  Created by Zhongheng Li on 9/26/17.
//  Copyright © 2017 MealPicApp. All rights reserved.
//

import UIKit
import QuartzCore


//UICollectionViewDelegate,UICollectionViewDataSource,
class ItemInfoViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
   
    
    // Declare instance variables here
        //var messageArray : [Message] = [Message]()
    
    //HardCode
    let messageArray = ["excessive caffeine consumption affects fetal sleep & movement","reduces risk of osteoporosis in postmenopausal women","excellent for weight gain", "strengthens bones & cartilage", "helps prevent arthritis, cancer & heart diseases"]
    
    
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//    
//            return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {


         return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = benefitsTableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
      
        cell.messageBody.text = messageArray[indexPath.row] //.messageBody
        cell.senderUsername.text = messageArray[indexPath.row] //.sender
        cell.avatarImageView.image = UIImage(named: "CheckLogo_Small")
        
        
        return cell
    }
    

    @IBOutlet weak var benefitsTableView: UITableView!
    
    @IBOutlet weak var badgesCollectionView: UICollectionView!
    
    @IBOutlet weak var detailsView: UIView!
    
    @IBAction func BackToAR(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        benefitsTableView.delegate = self
        benefitsTableView.dataSource = self
        benefitsTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        
//        badgesCollectionView.delegate = self
//        badgesCollectionView.dataSource = self
//

        detailsView.layer.cornerRadius = 20
        detailsView.layer.masksToBounds = true
        

        
        // Do any additional setup after loading the view.
    }


}
