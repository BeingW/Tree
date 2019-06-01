//
//  TreeDiaryPage.swift
//  Tree
//
//  Created by Jae Ki Lee on 5/27/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class DiaryTableViewController: UIViewController {
    
    var user = User(profilePicture: nil, userName: "")
    
    let uinavigationItem: UINavigationItem = {
       let uinavigationItem = UINavigationItem(title: "Tree")
        uinavigationItem.largeTitleDisplayMode = .always
        return uinavigationItem
    }()
    
    func navigationBar() {
        let thisUINavigtionBar = self.navigationController?.navigationBar
        let thisUINavigationItem = self.navigationController?.navigationItem
        
        thisUINavigationItem?.title = "Tree"
        thisUINavigtionBar?.titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 35, weight: .bold)]
    }
    
    let recordTopSeperateView: UIView = {
        let recordTopSeperateView = UIView()
        recordTopSeperateView.backgroundColor = .lightGray
        return recordTopSeperateView
    }()
    
    let recordView: UIView = {
       let recordView = UIView()
        recordView.backgroundColor = .white
        return recordView
    }()
    
    let recordLabel: UILabel = {
        let recordLabel = UILabel()
        recordLabel.text = "Post about I am"
        recordLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return recordLabel
    }()
    
    let recordContentImageView: UIImageView = {
        let recordContentImageView = UIImageView()
        recordContentImageView.image = UIImage(named: "PostTextField@2x")
        return recordContentImageView
    }()
    
    let recordTumbnailImageView: UIImageView = {
        let recordTumbnailImageView = UIImageView()
        recordTumbnailImageView.image = UIImage(named: "ProfileIcon@2x")
        return recordTumbnailImageView
    }()
    
    let recordBottomSeperateView: UIView = {
        let recordBottomSeperateView = UIView()
        recordBottomSeperateView.backgroundColor = .lightGray
        return recordBottomSeperateView
    }()
    
    let recordButton: UIButton = {
        let recordButton = UIButton()
        recordButton.setTitle("", for: .normal)
        recordButton.addTarget(self, action: #selector(reocrdButtonTapped), for: .touchUpInside)
        return recordButton
    }()

    @objc func reocrdButtonTapped() {
        print("recordButtonTapped")
    }
    
    func setviews() {
        self.view.addSubview(recordTopSeperateView)
        self.view.addSubview(recordView)
            self.recordView.addSubview(recordLabel)
            self.recordView.addSubview(recordContentImageView)
                self.recordContentImageView.addSubview(recordTumbnailImageView)
        self.view.addSubview(recordBottomSeperateView)
        self.view.addSubview(recordButton)
        
        let recordViewHeight = view.frame.height / 4.3
        let recordViewWidth = view.frame.width
        let seperateViewHeight = recordViewHeight / 10
        
        recordTopSeperateView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: seperateViewHeight)
    }
    
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
        
        print("user info \(user.getUserName()) \(user.getProfilePicture())")
    }
    
    @objc func buttonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
