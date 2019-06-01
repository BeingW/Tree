//
//  MainTabBarController.swift
//  Tree
//
//  Created by Jae Ki Lee on 6/1/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    var isAppFirstOpen = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let diaryTableViewcontroller = DiaryTableViewController()
        
        let diaryNavController = UINavigationController(rootViewController: diaryTableViewcontroller)
            
        viewControllers = [diaryNavController]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if isAppFirstOpen == true {
            DispatchQueue.main.async {
                let loginController = LoginController()
                let loginNavContrroller = UINavigationController(rootViewController: loginController)
                loginController.mainTabBarController = self
                self.present(loginNavContrroller, animated: true, completion: nil)
            }
        }
    }
    
    
}
