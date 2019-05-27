//
//  TreeDiaryPage.swift
//  Tree
//
//  Created by Jae Ki Lee on 5/27/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class DiaryTableViewController: UIViewController {
    
    var isProgramFirstOpen: Bool = true
    
    let button: UIButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        button.setTitle("Tree", for: .normal)
        
        view.addSubview(button)
        button.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 500, height: 100)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
         if isProgramFirstOpen == true {
            DispatchQueue.main.async {
                let loginController = LoginController()
                
                let loginNavController = UINavigationController(rootViewController: loginController)
                loginNavController.setNavigationBarHidden(true, animated: false)
                
                self.present(loginNavController, animated: true, completion: nil)
            }
         }
        
        print(isProgramFirstOpen)
    }
    
    @objc func buttonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
