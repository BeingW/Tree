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
    
    func navigationBar() {
        
        let thisUINavigtionBar = self.navigationController?.navigationBar
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "NavigationBarProfileIcon@2x")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftNavigationBarItemTapped))
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "NavigationBarCameraIcon@2x")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rigthNavigationBarItemTapped))
        
        let titleItme = UINavigationItem(title: "Tree")
        
        
        thisUINavigtionBar?.setBackgroundImage(UIImage(named: "NavigationBar@2x"), for: .default)
        thisUINavigtionBar?.topItem?.title = "Tree"
        thisUINavigtionBar?.backItem?.leftBarButtonItem = leftBarButtonItem
        thisUINavigtionBar?.topItem?.rightBarButtonItem = rightBarButtonItem
        
        thisUINavigtionBar?.titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.white]
        
    }
    
    @objc func leftNavigationBarItemTapped() {
        print("left NavigationBar")
    }
    
    @objc func rigthNavigationBarItemTapped() {
        print("Right NavigationBar")
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
        
        self.navigationBar()
        
        print("user info \(user.getUserName()) \(user.getProfilePicture())")
    }
    
    @objc func buttonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
