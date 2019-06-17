//
//  CustomNavigationController.swift
//  Tree
//
//  Created by Jae Ki Lee on 5/27/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    func copyNavigationControllers(viewControllers: [UIViewController]) -> [UIViewController]?{
        
        self.navigationController?.viewControllers.removeAll()
        
        var i = 0;
        
        while i < viewControllers.count - 1 {
            self.navigationController?.viewControllers.append(viewControllers[i])
            i = i + 1;
        }
        
        return self.navigationController?.viewControllers
    }
}
