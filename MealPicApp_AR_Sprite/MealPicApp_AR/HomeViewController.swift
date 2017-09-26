//
//  HomeViewController.swift
//  MealPic_ARKit
//
//  Created by Zhongheng Li on 9/20/17.
//  Copyright © 2017 Zhongheng Li. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func scanButtonPress(_ sender: Any) {
        
        performSegue(withIdentifier: "goToScanView", sender: self)
    }
    
    
    
}

