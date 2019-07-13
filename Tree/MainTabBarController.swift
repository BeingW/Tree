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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isAppFirstOpen == true {
            DispatchQueue.main.async {
                let loginController = LoginController()
                let loginNavContrroller = UINavigationController(rootViewController: loginController)
                self.present(loginNavContrroller, animated: false, completion: nil)
            }
        } else {
            setTabViewControllers()
        }
        
    }
    
    func setTabViewControllers() {
        
        let diaryNavController = UINavigationController(rootViewController: DiaryTableViewController())
        
        viewControllers = [diaryNavController]
    }
    
    
}
