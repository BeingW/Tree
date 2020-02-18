//
//  DiaryPostController.swift
//  Tree
//
//  Created by Jae Ki Lee on 6/3/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class DiaryPostController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var diaryPage: DiaryPage?
    var isEdit: Bool = false
    
    let imagePickerController: UIImagePickerController = {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        
        return imagePickerController
    }()
    
    /*
     함수명: imagePickerController(UIImagePickerControllerDelegate)
     기능: 사진첩에 접근해 사진을 선택된 사진을 가져옵니다.
     작성일자: 2019.07.15
     수정일자:
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        self.diaryImageView.image = selectedImage

        picker.dismiss(animated: true, completion: nil)

    }
    
    //MARK: - NavigationBar
    func navigationBar() {
        
//        let thisNavigaionBar = self.navigationController?.navigationBar
        //guard let userName = self.diaryTableViewcontroller?.user?.getName() else {return}

        let rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(postButtonTapped))
        rightBarButtonItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        
        let editRightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
        editRightBarButtonItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)

        let leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        leftBarButtonItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)

        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        if !isEdit {
            self.navigationItem.rightBarButtonItem = rightBarButtonItem
        } else {
            self.navigationItem.rightBarButtonItem = editRightBarButtonItem
        }
        
    }
    
    @objc func cancelButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
     함수명: postButtonTapped
     기능: 유저가 입력한 다이어리를 작성하고 포스트합니다.
     작성일자: 2019.07.15
     수정일자:
     */
    
    @objc func postButtonTapped() {
        self.postDiaryPage()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func editButtonTapped() {
        self.updateDiaryPage()
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: - PostContainerView
    let navigationSeperatorView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .lightGray
        return uiView
    }()
    
    let postContainerView: UIView = {
        let postContainerView = UIView()
        return postContainerView
    }()
    
    let postView: UIView = {
        let postView = UIView()
        return postView
    }()
    
    let profileImageView: UIImageView = {
        let profileImageview = UIImageView()
        profileImageview.image = UIImage(named: "ProfileIcon")
        return profileImageview
    }()
    
    let diaryTitleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Please type title"
        return textField
    }()
    
    let diaryContentTextView: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    //MARK: - OptionButtons Part
    let plusButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "toolBoxButton"), for: .normal)
        return button
    }()
    
    let toolBoxView: UIView = {
        let uiView = UIView()
        return uiView
    }()
    
    let buttonContainerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ToolBoxView")
        return imageView
    }()
    
    let imageLibraryButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "Photo"), for: .normal)
        button.addTarget(self, action: #selector(imageLibrayButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func imageLibrayButtonTapped() {
//        self.present(imagePickerController, animated: true, completion: nil)
        
//        self.navigationController?.pushViewController(imagePickerController, animated: true)
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    let takePhotoButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "Camera"), for: .normal)
        return button
    }()
    
    let recordLibraryButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "Voice"), for: .normal)
        return button
    }()
    
    let takeLocationButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "Location"), for: .normal)
        return button
    }()
    
    //MARK: - ContentContainerView
    let contentContainerSeperatorView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .lightGray
        return uiView
    }()
    
    let contentContainerView: UIView = {
        let uiView = UIView()
        return uiView
    }()
    
    let diaryImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePickerController.delegate = self
        setViews()
        navigationBar()
    
        self.view.backgroundColor = .white
        
        if isEdit {
            if let diaryPage = self.diaryPage {
                self.diaryTitleTextField.text = diaryPage.getTitle()
                self.diaryContentTextView.text = diaryPage.getText()
                
                //일단 image 한장
                //            if let diaryPageImages = diaryPage.getDiaryPageImages() {
                //                let diaryPageImage = diaryPageImages[0].getImage()
                //                self.diaryImageView.image = diaryPageImage
                //            }
                
            }
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
    }
    
    func setViews() {
        
        //PostContainerView
        let safeLayoutArea = self.view.safeAreaLayoutGuide
        let postContainerViewHeight = (safeLayoutArea.layoutFrame.height * 0.7) / 2
        let buttonWidth = self.view.frame.width / 10
        let buttonContainerImageViewWidth = safeLayoutArea.layoutFrame.width * 2/3
        let buttonContainerImageViewHight = buttonWidth * 2
        
        self.view.addSubview(navigationSeperatorView)
        navigationSeperatorView.anchor(top: safeLayoutArea.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 5)
        
        self.view.addSubview(postContainerView)
        postContainerView.anchor(top: navigationSeperatorView.bottomAnchor, left: safeLayoutArea.leftAnchor, bottom: nil, right: safeLayoutArea.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: postContainerViewHeight)
        
        self.postContainerView.addSubview(postView)
        self.postContainerView.addSubview(plusButton)
        self.postContainerView.addSubview(toolBoxView)
        
        //PostView
        postView.anchor(top: postContainerView.topAnchor, left: postContainerView.leftAnchor, bottom: postContainerView.bottomAnchor, right: postContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
            //In PostView
            self.postView.addSubview(profileImageView)
            self.postView.addSubview(diaryTitleTextField)
            self.postView.addSubview(diaryContentTextView)
        
            profileImageView.anchor(top: postView.topAnchor, left: postView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 35, height: 35)
            diaryTitleTextField.anchor(top: nil, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            diaryTitleTextField.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 0).isActive = true
            diaryContentTextView.anchor(top: profileImageView.bottomAnchor, left: postView.leftAnchor, bottom: postView.bottomAnchor, right: postView.rightAnchor, paddingTop: 8, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
        
        //Plus Button
            plusButton.anchor(top: nil, left: nil, bottom: postContainerView.bottomAnchor, right: postContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 10, width: 35, height: 35)
        
        //Tool box
        toolBoxView.anchor(top: nil, left: nil, bottom: plusButton.centerYAnchor, right: plusButton.centerXAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -13, paddingRight: -14, width: buttonContainerImageViewWidth, height: buttonContainerImageViewHight)
        
        imageLibraryButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: buttonWidth, height: buttonWidth)
        let buttonStakView = UIStackView(arrangedSubviews: [imageLibraryButton, takePhotoButton, recordLibraryButton, takeLocationButton])
        buttonStakView.axis = .horizontal
        buttonStakView.distribution = .fillEqually
        buttonStakView.spacing = 10
        
            //In ToolBoxView
            self.toolBoxView.addSubview(buttonContainerImageView)
            self.toolBoxView.addSubview(buttonStakView)
            buttonContainerImageView.anchor(top: toolBoxView.topAnchor, left: toolBoxView.leftAnchor, bottom: toolBoxView.bottomAnchor, right: toolBoxView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
            buttonStakView.anchor(top: toolBoxView.topAnchor, left: toolBoxView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        //ContentContainerView
        self.view.addSubview(contentContainerSeperatorView)
        self.view.addSubview(contentContainerView)
        contentContainerView.addSubview(diaryImageView)
        
        contentContainerSeperatorView.anchor(top: postContainerView.bottomAnchor, left: safeLayoutArea.leftAnchor, bottom: nil, right: safeLayoutArea.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 5)
        contentContainerView.anchor(top: contentContainerSeperatorView.bottomAnchor, left: safeLayoutArea.leftAnchor, bottom: safeLayoutArea.bottomAnchor, right: safeLayoutArea.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        diaryImageView.anchor(top: contentContainerView.topAnchor, left: contentContainerView.leftAnchor, bottom: contentContainerView.bottomAnchor, right: contentContainerView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
        
    }

    private func postDiaryPage() {
        //1.diaryTitle, diaryText, 현재 날과 시간, diaryImage 를 읽어온다.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        //DiaryPage Data
        let diaryTitle = self.diaryTitleTextField.text ?? ""
        let diaryText = self.diaryContentTextView.text ?? ""
        let todayDateString = dateFormatter.string(from: Date())
        
        //DiaryPageImage Data
        var diaryPageImages = [DiaryPageImage]()
        
        if let diaryImage = self.diaryImageView.image {
            guard let imageUrl = ConvertingDataAndImage().convertingFromImageToUrl(image: diaryImage) else {return}
            
            let diaryPageImage = DiaryPageImage(url: imageUrl, createdDate: todayDateString)
            
            diaryPageImages.append(diaryPageImage)
        }
        //2.읽어온 데이터로 DiaryPage 를 만든다.
        let diaryPage = DiaryPage(title: diaryTitle, date: todayDateString, text: diaryText, images: diaryPageImages)
        
        //3.DiaryPageDAO 객체를 가져온다.
        //4.DiaryPageDAO 객체의 insertDiayPage(diarypage: DairyPage) 함수를 만든 DiaryPage 객체를 넣어 호출한다.
        DiaryPageDAO().insertDiaryPage(diaryPage: diaryPage)
        
    }
    
    private func updateDiaryPage() {
        //1.diaryTitle, diaryText, 현재 날과 시간, diaryImage 를 읽어온다.
        
        //DiaryPage Data
        let diaryTitle = self.diaryTitleTextField.text ?? ""
        let diaryText = self.diaryContentTextView.text ?? ""
        let diaryDate = self.diaryPage?.getDate()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateString = dateFormatter.string(from: diaryDate!)
        
        //DiaryPageImage Data
        var diaryPageImages = [DiaryPageImage]()
        
        if let diaryImage = self.diaryImageView.image {
            guard let imageUrl = ConvertingDataAndImage().convertingFromImageToUrl(image: diaryImage) else {return}
            
            let diaryPageImage = DiaryPageImage(url: imageUrl, createdDate: dateString)
            
            diaryPageImages.append(diaryPageImage)
        }
        
        //2.읽어온 데이터로 DiaryPage 를 만든다.
        let diaryPage = DiaryPage(title: diaryTitle, date: dateString, text: diaryText, images: diaryPageImages)
        
        //3.DiaryPageDAO 객체를 가져온다.
        //4.DiaryPageDAO 객체의 insertDiayPage(diarypage: DairyPage) 함수를 만든 DiaryPage 객체를 넣어 호출한다.
        DiaryPageDAO().updateDiaryPage(diaryPage: diaryPage)
    }
    
}
