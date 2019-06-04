//
//  DiaryPostController.swift
//  Tree
//
//  Created by Jae Ki Lee on 6/3/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class DiaryPostController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var user: User?
    
    var diaryTableViewcontroller: DiaryTableViewController?
    
    let imagePickerController: UIImagePickerController = {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        return imagePickerController
    }()
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        self.diaryImageView.image = selectedImage
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - NavigationBar
    func navigationBar() {
        let rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(postButtonTapped))
        
        self.navigationController?.navigationBar.topItem?.title = "Tree"
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func postButtonTapped() {
        
        let title = self.diaryTitleTextField.text
        let textContents = self.diaryContentTextView.text
        let imageUrl: String?
        
        if let imageContents = self.diaryImageView.image {
            imageUrl = ConvertingDataAndImage().convertingFromImageToUniqueUrl(image: imageContents)
        } else {
            imageUrl = ""
        }
        
        let imageStrings = [imageUrl]
        
        let diaryPage = DiaryPage(title: title, contents: textContents, images: imageStrings)
        
        self.user?.addNewPage(diaryPage: diaryPage)
        
        self.diaryTableViewcontroller?.user = self.user
        self.dismiss(animated: true, completion: nil)
        
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
        self.imagePickerController.delegate = self
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
        
        self.view.backgroundColor = .white
        
        setViews()
        
        navigationBar()
        
        print("\(user?.getUserName())")
        
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
        
        postView.anchor(top: postContainerView.topAnchor, left: postContainerView.leftAnchor, bottom: postContainerView.bottomAnchor, right: postContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        plusButton.anchor(top: nil, left: nil, bottom: postContainerView.bottomAnchor, right: postContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 10, width: 35, height: 35)
        toolBoxView.anchor(top: nil, left: nil, bottom: plusButton.centerYAnchor, right: plusButton.centerXAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -13, paddingRight: -14, width: buttonContainerImageViewWidth, height: buttonContainerImageViewHight)
        
        self.toolBoxView.addSubview(buttonContainerImageView)
        buttonContainerImageView.anchor(top: toolBoxView.topAnchor, left: toolBoxView.leftAnchor, bottom: toolBoxView.bottomAnchor, right: toolBoxView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        imageLibraryButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: buttonWidth, height: buttonWidth)
        let buttonStakView = UIStackView(arrangedSubviews: [imageLibraryButton, takePhotoButton, recordLibraryButton, takeLocationButton])
        buttonStakView.axis = .horizontal
        buttonStakView.distribution = .fillEqually
        buttonStakView.spacing = 10
        
        toolBoxView.addSubview(buttonStakView)
        buttonStakView.anchor(top: toolBoxView.topAnchor, left: toolBoxView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        self.postView.addSubview(profileImageView)
        self.postView.addSubview(diaryTitleTextField)
        self.postView.addSubview(diaryContentTextView)
        
        profileImageView.anchor(top: postView.topAnchor, left: postView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 35, height: 35)
        diaryTitleTextField.anchor(top: nil, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        diaryTitleTextField.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 0).isActive = true
        diaryContentTextView.anchor(top: profileImageView.bottomAnchor, left: postView.leftAnchor, bottom: postView.bottomAnchor, right: postView.rightAnchor, paddingTop: 8, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
        

        
        //ContentContainerView
        view.addSubview(contentContainerSeperatorView)
        view.addSubview(contentContainerView)
        contentContainerView.addSubview(diaryImageView)
        
        contentContainerSeperatorView.anchor(top: postContainerView.bottomAnchor, left: safeLayoutArea.leftAnchor, bottom: nil, right: safeLayoutArea.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 5)
        contentContainerView.anchor(top: contentContainerSeperatorView.bottomAnchor, left: safeLayoutArea.leftAnchor, bottom: safeLayoutArea.bottomAnchor, right: safeLayoutArea.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        diaryImageView.anchor(top: contentContainerView.topAnchor, left: contentContainerView.leftAnchor, bottom: contentContainerView.bottomAnchor, right: contentContainerView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)
        
    }

    
    
}
