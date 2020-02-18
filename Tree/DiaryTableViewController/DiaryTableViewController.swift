//
//  TreeDiaryPage.swift
//  Tree
//
//  Created by Jae Ki Lee on 5/27/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class DiaryTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let diaryTableView = UITableView()
    let diaryTableCellId = "diaryCellId"

    let diary = Diary.shared
    
    //MARK: - NavigationBar
    func navigationBar() {
        
        let navigationBar = self.navigationController?.navigationBar
        let userNavigationItem = UIBarButtonItem(image: UIImage(named: "NavigationProfileIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(userNavigationItemTapped))
        guard let userName = User.shared.getName() else {return}
        
        navigationBar?.topItem?.title = "\(userName)"
        navigationBar?.setBackgroundImage(UIImage(named: "NavigationBackGround"), for: .default)
        navigationBar?.topItem?.leftBarButtonItem = userNavigationItem
        navigationBar?.titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.white]
    self.navigationController?.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        
    }
    
    @objc func userNavigationItemTapped() {
        //1.UIAlertController 객체의 ActionSheet style 로 생성합니다.
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        //2.cancel, logout, User Information Edit 에 대한 객체들을 생성한다.
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (action) in
            let loginNavController = UINavigationController(rootViewController: LoginController())
            self.present(loginNavController, animated: true, completion: nil)
        }
        
        let userEditAction = UIAlertAction(title: "Edit User Information", style: .default) { (action) in
            let signUpController = SignupController()
            signUpController.editMode = true
            self.present(signUpController, animated: true, completion: nil)
        }
        //3.UIAlertController 에 생성한 UIAction 객체를 넣는다.
        alertController.addAction(userEditAction)
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
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
        let diaryPostController = DiaryPostController()
        self.navigationController?.pushViewController(DiaryPostController(), animated: true)
    }
    
    private func setBodyViews() {
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
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setTableView()
        
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        loadDiaryPage()
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateFeed), name: NSNotification.Name(rawValue: "UpdateFeed"), object: nil)
//    }
    
    //MARK: - Set View
    private func setView() {
        view.backgroundColor = .white
        navigationBar()
        setBodyViews()
    }
    
    private func setTableView() {
        self.diaryTableView.delegate = self
        self.diaryTableView.dataSource = self
        self.diaryTableView.estimatedRowHeight = self.view.safeAreaLayoutGuide.layoutFrame.height * 1.7/3
        
        diaryTableView.register(DiaryTableViewCell.self, forCellReuseIdentifier: diaryTableCellId)
    }
    
    //MARK: - Set Data
   private func loadDiaryPage() {
        self.diary.pages = DiaryPageDAO().fetchDiaryPage() ?? [DiaryPage]()
        self.diary.pages = self.diary.pages.sorted(by: { $0.getDate().compare($1.getDate()) == .orderedDescending
    })
    
    }
    
    
    
    /*
     함수명: handleUpdateFeed
     기능: diaryTableView 의 데이터를 재로드 한다.
     작성일자: 2019.07.15
     수정일자:
     */
    @objc func handleUpdateFeed() {
        self.diaryTableView.reloadData()
    }
    
    //MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.diary.getPages().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = diaryTableView.dequeueReusableCell(withIdentifier: diaryTableCellId, for: indexPath) as? DiaryTableViewCell else {fatalError()}
        
        cell.diaryTableViewCellDelegate = self
        cell.diarypage = self.diary.getPages()[indexPath.item]
        
        return cell
    }
    
}

extension DiaryTableViewController: DiaryTableViewCellDelegate {
    
    func didTapEditButton(diaryPage: DiaryPage) {
        //1.UIAlertController 객체의 ActionSheet style 로 생성합니다.
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        //2.cancel, logout, User Information Edit 에 대한 객체들을 생성한다.
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
        
        let deletePostAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            //1.DiaryPageDAO 객체를 가져온다.
            //2.DiaryPageDAO 객체의 deleteDiaryPage() 함수를 호출하여 원하는 diaryPage 를 지운다.
            DiaryPageDAO().deleteDiaryPage(diaryPageDate: diaryPage.getDate())
            //3.TableView 를 갱신한다.
            self.loadDiaryPage()
            self.diaryTableView.reloadData()
        }
        
        let editPostAction = UIAlertAction(title: "Edit Post", style: .default) { (action) in
            let signUpController = SignupController()
            signUpController.editMode = true
            self.present(signUpController, animated: true, completion: nil)
        }
        
        //3.UIAlertController 에 생성한 UIAction 객체를 넣는다.
        alertController.addAction(editPostAction)
        alertController.addAction(deletePostAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
