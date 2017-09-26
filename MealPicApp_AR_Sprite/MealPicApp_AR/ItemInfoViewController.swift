//
//  ItemInfoViewController.swift
//  MealPicApp_AR
//
//  Created by Zhongheng Li on 9/26/17.
//  Copyright © 2017 MealPicApp. All rights reserved.
//

import UIKit
import QuartzCore

class ItemInfoViewController: UIViewController {

    @IBOutlet weak var detailsView: UIView!
    
    @IBAction func BackToAR(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailsView.layer.cornerRadius = 20
        detailsView.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }


}
