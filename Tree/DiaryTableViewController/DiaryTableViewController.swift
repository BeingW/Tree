//
//  TreeDiaryPage.swift
//  Tree
//
//  Created by Jae Ki Lee on 5/27/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class DiaryTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var user: User? {
        didSet {
            self.diaryTableView.reloadData()
        }
    }
    
    let diaryPostController = DiaryPostController()
    
    let diaryTableView = UITableView()
    
    let diaryTableCellId = "diaryCellId"
    
    //MARK: - NavigationBar
    func navigationBar() {
        
        let thisUINavigtionBar = self.navigationController?.navigationBar
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "NavigationProfileIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rightNavigationBarItemTapped))
        guard let userName = self.user?.getName() else {return}
        
        thisUINavigtionBar?.topItem?.title = "\(userName)"
        thisUINavigtionBar?.setBackgroundImage(UIImage(named: "NavigationBackGround"), for: .default)
        thisUINavigtionBar?.topItem?.rightBarButtonItem = rightBarButtonItem
        thisUINavigtionBar?.titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.white]
        //self.navigationController?.navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        self.navigationController?.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        
    }
    
    @objc func rightNavigationBarItemTapped() {
        print("right NavigationBar")
    }
    
    //MARK: - RecordView
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
        recordLabel.textColor = .lightGray
        return recordLabel
    }()
    
    let recordContentImageView: UIImageView = {
        let recordContentImageView = UIImageView()
        recordContentImageView.image = UIImage(named: "PostTextField")
        return recordContentImageView
    }()
    
    let recordTumbnailImageView: UIImageView = {
        let recordTumbnailImageView = UIImageView()
        recordTumbnailImageView.image = UIImage(named: "ProfileIcon")
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
        recordButton.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        return recordButton
    }()

    @objc func recordButtonTapped() {
        self.diaryPostController.user = self.user
        self.diaryPostController.diaryTableViewcontroller = self
        self.navigationController?.pushViewController(diaryPostController, animated: true)
        //let diaryPostNavController = UINavigationController(rootViewController: diaryPostController)
        //self.navigationController?.present(diaryPostNavController, animated: true, completion: nil)
        
    }
    
    func setViews() {
        self.view.addSubview(recordTopSeperateView)
        self.view.addSubview(recordView)
            self.recordView.addSubview(recordLabel)
            self.recordView.addSubview(recordContentImageView)
                self.recordContentImageView.addSubview(recordTumbnailImageView)
        self.view.addSubview(recordBottomSeperateView)
        self.view.addSubview(recordButton)
        
        let safeLayoutArea = self.view.safeAreaLayoutGuide
        let seperateViewHeight = 5
        let recordViewHeight = view.frame.height / 4
        let labeHeigth = recordView.frame.height / 5
        let tumbNailImageViewLegnth = recordView.frame.width / 5
    
        recordTopSeperateView.anchor(top: safeLayoutArea.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 5)
        recordView.anchor(top: recordTopSeperateView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: safeLayoutArea.layoutFrame.height / 4)
        recordLabel.anchor(top: recordView.topAnchor, left: recordView.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        recordContentImageView.anchor(top: recordLabel.bottomAnchor, left: recordView.leftAnchor, bottom: recordView.bottomAnchor, right: recordView.rightAnchor, paddingTop: 15, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        recordTumbnailImageView.anchor(top: recordContentImageView.topAnchor, left: recordContentImageView.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: tumbNailImageViewLegnth, height: tumbNailImageViewLegnth)
        recordButton.anchor(top: recordView.topAnchor, left: recordView.leftAnchor, bottom: recordView.bottomAnchor, right: recordView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        recordBottomSeperateView.anchor(top: recordView.bottomAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: CGFloat(seperateViewHeight))
        
        self.view.addSubview(diaryTableView)
        diaryTableView.anchor(top: recordBottomSeperateView.bottomAnchor, left: self.view.leftAnchor, bottom: safeLayoutArea.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        //diaryTableView.rowHeight = self.view.frame.height / 2.2
        
        
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        navigationBar()
        setViews()
        
        self.diaryTableView.delegate = self
        self.diaryTableView.dataSource = self
        self.diaryTableView.estimatedRowHeight = safeArea.layoutFrame.height * 1.7/3
        
        diaryTableView.register(DiaryTableViewCell.self, forCellReuseIdentifier: diaryTableCellId)
        
        print("\(user?.getName())")
        
    }
    
    
    //MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        /*
        var numberOfRows: Int
        
        if self.user?.diary[0] == nil {
            numberOfRows = 0
        } else {
            numberOfRows = self.user?.diary.count ?? 0
        }
         */
        
        return self.user?.diary.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = diaryTableView.dequeueReusableCell(withIdentifier: diaryTableCellId, for: indexPath) as? DiaryTableViewCell else {fatalError()}
        
        if let user = self.user {
            cell.diarypage = user.diary[indexPath.item]
        }
        
        return cell
    }
    
    
    
}
