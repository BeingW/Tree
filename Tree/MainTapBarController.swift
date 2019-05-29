//
//  MainTapBarController.swift
//  Tree
//
//  Created by Jae Ki Lee on 5/29/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class MainTapBarController: UITabBarController, UITabBarControllerDelegate {
    
    let diaryViewcontroller = DiaryViewController()
    
    override func viewDidLoad() {
        self.delegate = self
        
        let diaryTableViewcontroller = DiaryTableViewController()
        self.viewControllers = [diaryViewcontroller, UIViewController()]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.first
        
        if index == diaryViewcontroller  {
            
            let diaryNavController = UINavigationController(rootViewController: diaryViewcontroller)
            
            present(diaryNavController, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
    
    
}
