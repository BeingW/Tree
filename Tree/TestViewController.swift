//
//  TestViewController.swift
//  Tree
//
//  Created by Jae Ki Lee on 6/1/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    //view 들이 메모리에 로드 된 후에 불려짐
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
    }
    
    //해당 viewController 메모리 할당 후에 그 다음으로
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        print("Nottify viewController viewWill")
    }
    
    //해당 viewController 메모리 할당 후에 viewWillAppear 다음
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        print("Notify viewController viewDid")
    }
    
}
