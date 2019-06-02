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
    var diaryTableViewController = DiaryTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabViewControllers()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if isAppFirstOpen == true {
            DispatchQueue.main.async {
                let loginController = LoginController()
                let loginNavContrroller = UINavigationController(rootViewController: loginController)
                loginController.mainTabBarController = self
                self.present(loginNavContrroller, animated: false, completion: nil)
            }
        }
    }
    
    func setTabViewControllers() {
        let diaryNavController = UINavigationController(rootViewController: self.diaryTableViewController)
        
        viewControllers = [diaryNavController]
    }
    
    
}
