//
//  MainTabBarController.swift
//  Tree
//
//  Created by Jae Ki Lee on 6/1/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableViewControllers()
        
    }
    
    func setTableViewControllers() {
        
        let diaryNavController = UINavigationController(rootViewController: DiaryTableViewController())
        
        viewControllers = [diaryNavController]
    }
    
    
}
