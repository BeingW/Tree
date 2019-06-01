//
//  TestViewController.swift
//  Tree
//
//  Created by Jae Ki Lee on 6/1/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
    }
    
    //해당 viewController 메모리 할당 후에 view 가 로드되기 전 들어옴
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        print("Nottify viewController viewWill")
    }
    
    //해당 viewController 메모리 할당 후에 view 가 로드 된 후에 들어옴
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        print("Notify viewController viewDid")
    }
    
}
