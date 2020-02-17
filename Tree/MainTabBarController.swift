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
    var aaa = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableViewControllers()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if aaa {
//            aaa = true
//            if isAppFirstOpen == true {
//                DispatchQueue.main.async {
//                    let loginController = LoginController()
//                    let loginNavContrroller = UINavigationController(rootViewController: loginController)
//                    self.present(loginNavContrroller, animated: false, completion: nil)
//                }
//            } else {
//                setTableViewControllers()
//            }
//        }
        
    }
    
    func setTableViewControllers() {
        
        let diaryNavController = UINavigationController(rootViewController: DiaryTableViewController())
        
        viewControllers = [diaryNavController]
    }
    
    
}
