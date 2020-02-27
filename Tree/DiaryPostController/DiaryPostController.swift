//
//  DiaryPostController.swift
//  Tree
//
//  Created by Jae Ki Lee on 6/3/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit
import ImagePicker

class DiaryPostController: UIViewController {
    
    var diaryPage: DiaryPage?
    var diaryImages = [DiaryPageImage]()
    var isEdit: Bool = false
    
    let cellId = "cellId"
    let diaryImageCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
    let diaryCollecionViewCelllayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    let imagePickerController: ImagePickerController = {
        let config = Configuration()
        config.doneButtonTitle = "Finish"
        config.noImagesTitle = "Sorry there are no images"
        config.recordLocation = false
        let imagePickerController = ImagePickerController(configuration: config)
        imagePickerController.imageLimit = 10
        return imagePickerController
    }()
    
    //MARK: - NavigationBar
    func navigationBar() {
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
        let userProfileImage = ConvertingDataAndImage().convertingFromUrlToImage(uniqueId: Diary.shared.getUserProfileImageUrl())
        profileImageview.image = userProfileImage
        profileImageview.layer.cornerRadius = 35/2
        profileImageview.layer.masksToBounds = true
        
        return profileImageview
    }()
    
    let diaryTitleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Please type title"
        textField.font = UIFont.systemFont(ofSize: 18)
        return textField
    }()
    
    let diaryContentTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.text = "Please type text here"
        textView.textColor = UIColor.lightGray
        textView.font = UIFont.systemFont(ofSize: 18)
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
    
    let selectedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        return imageView
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.imagePickerController.delegate = self
        self.diaryContentTextView.delegate = self
        
        setViews()
        navigationBar()
        setCollectionView()
        
        if isEdit {
            if let diaryPage = self.diaryPage {
                self.diaryTitleTextField.text = diaryPage.getTitle()
                self.diaryContentTextView.text = diaryPage.getText()
                if let diaryImages = diaryPage.getDiaryPageImages(), diaryImages.count != 0 {
                    self.diaryImages = diaryImages
                    self.diaryImageCollectionView.reloadData()
                    self.selectedImageView.image = self.diaryImages[0].getImage()
                }
            }
        }
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 0.5
        self.diaryImageCollectionView.addGestureRecognizer(longPressGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
    }
    
    @objc func handleLongPress(longPressGesture: UILongPressGestureRecognizer) {
        let cellLocation = longPressGesture.location(in: self.diaryImageCollectionView)
        let indexPath = self.diaryImageCollectionView.indexPathForItem(at: cellLocation)
        if longPressGesture.state == UIGestureRecognizer.State.began {
            self.handleImageCellPress(indexPath: indexPath)
        }
    }
    
    private func handleImageCellPress(indexPath: IndexPath?) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.diaryImages.remove(at: indexPath!.row)
            self.diaryImageCollectionView.reloadData()
        }
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func setCollectionView() {
        self.diaryCollecionViewCelllayout.scrollDirection = .horizontal
        self.diaryImageCollectionView.setCollectionViewLayout(diaryCollecionViewCelllayout, animated: true)
        self.diaryImageCollectionView.backgroundColor = .white
        self.diaryImageCollectionView.delegate = self
        self.diaryImageCollectionView.dataSource = self
        self.diaryImageCollectionView.register(DiaryPostImageCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        view.endEditing(true)
        return true
    }
    
    private func setViews() {
        //PostContainerView
        let safeLayoutArea = self.view.safeAreaLayoutGuide
        let postContainerViewHeight = safeLayoutArea.layoutFrame.height * 0.4
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
            diaryTitleTextField.anchor(top: nil, left: profileImageView.rightAnchor, bottom: nil, right: postView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
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
        self.view.addSubview(selectedImageView)
        self.view.addSubview(diaryImageCollectionView)
        let cellHeight = (view.frame.width - 3) / 4
        
        contentContainerSeperatorView.anchor(top: postContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 5)
        selectedImageView.anchor(top: contentContainerSeperatorView.bottomAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        diaryImageCollectionView.anchor(top: selectedImageView.bottomAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: cellHeight)
        
    }

    private func postDiaryPage() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        let diaryTitle = self.diaryTitleTextField.text ?? ""
        var diaryText = ""
        
        if self.diaryContentTextView.text != "Please type text here" || self.diaryTitleTextField.text != "" {
            diaryText = self.diaryContentTextView.text
        }
        let todayDateString = dateFormatter.string(from: Date())
        
        let diaryPage = DiaryPage(title: diaryTitle, date: todayDateString, text: diaryText, images: self.diaryImages)
        
        DiaryPageDAO().insertDiaryPage(diaryPage: diaryPage)
    }
    
    private func updateDiaryPage() {
        let diaryTitle = self.diaryTitleTextField.text ?? ""
        let diaryText = self.diaryContentTextView.text ?? ""
        let diaryDate = self.diaryPage?.getDate()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateString = dateFormatter.string(from: diaryDate!)
        
        let diaryPage = DiaryPage(title: diaryTitle, date: dateString, text: diaryText, images: self.diaryImages)
        DiaryPageDAO().updateDiaryPage(diaryPage: diaryPage)
    }
    
}

extension DiaryPostController: ImagePickerDelegate, UITextViewDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        images.forEach { (image) in
            let diaryImage = DiaryPageImage(image: image, createdDate: Date())
            self.diaryImages.append(diaryImage)
        }
        self.diaryImageCollectionView.reloadData()
        self.selectedImageView.image = self.diaryImages[0].getImage()
        self.imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        self.imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Please type text here"
            textView.textColor = UIColor.lightGray
        }
    }
}

extension DiaryPostController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 3) / 4
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DiaryPostImageCollectionViewCell
        cell.backgroundColor = .white
        cell.photoImageView.image = self.diaryImages[indexPath.row].getImage()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = self.diaryImages[indexPath.row]
        self.selectedImageView.image = selectedImage.getImage()
    }
}
