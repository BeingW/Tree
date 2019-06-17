//
//  ViewController.swift
//  Tree
//
//  Created by Jae Ki Lee on 5/22/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class SignupController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var mainTabBarController = MainTabBarController()
    var user = User(profilePicture: nil, userName: "")
    
    //MARK: - UIViews
    let signupBackgroundImageView: UIImageView = {
        let backgroundImage = UIImage(named: "SignupBackground@2x");
        let backgroundImageView = UIImageView(image: backgroundImage);
        
        return backgroundImageView
    }()
    
    let profileButton: UIButton = {
        let profileButtonImage = UIImage(named: "ProfileImage@2x")
        let profileButton = UIButton(type: .system)
        profileButton.setBackgroundImage(profileButtonImage, for: .normal)
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        
        return profileButton
    }()
    
    @objc func profileButtonTapped() {
        self.imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    let userNameTextField: UITextField = {
        let textField = UITextField();
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.leftView = paddingView
        textField.leftViewMode = .always
 
        let image = UIImage(named: "UserNameTextField@2x")
        textField.background = image
        
        return textField;
    }()
    
    let signupButton: UIButton = {
        let doTreeButton = UIButton(type: .system)
        let doTreeButtonImage = UIImage(named: "SignupButton@2x")
        doTreeButton.setBackgroundImage(doTreeButtonImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        doTreeButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        return doTreeButton
    }()
    
    @objc func signupButtonTapped() {
        
        var loginIsSucceed: Bool = false;
        var alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let converting = ConvertingDataAndImage()
        
        guard let userName = userNameTextField.text else { return }
        
        //1.profileImage 와 userProfilePicture 가 입력 되었는지 확인한다.
        if userName != "" && profileButton.imageView?.image != nil {
            guard let userProfilePicture = profileButton.imageView?.image else {return}
            guard let profileImageId = converting.convertingFromImageToUniqueUrl(image: userProfilePicture) else { return }
            
            //입력이 되었다면
            //1.1. user class 객체를 만든다.
            self.user = User(profilePicture: profileImageId, userName: userName)
            //1.2. user 객체의 속성들을 db 에 저장한다.
            //1.3. user 객체와 db에 성공적으로 저장 되었다면 loginSucceed 를 true 한다. 반대의 경우 false
            loginIsSucceed = true
        } else if userName == "" && profileButton.imageView?.image != nil {
                //아이디를 입력해 달라는 팝업 메시지를 띄운다.
                let userNameAlertTitle = "Please type your name."
                alertController = UIAlertController(title: userNameAlertTitle, message: "", preferredStyle: .alert)
                alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            loginIsSucceed = false;
        } else if userName != "" && profileButton.imageView?.image == nil {
                //이미지를 입력해 달라는 팝업 메시지를 띄운다.
                let userProfileAlertTitle = "Please take in your image."
                alertController = UIAlertController(title: userProfileAlertTitle, message: "", preferredStyle: .alert)
                alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            loginIsSucceed = false;
        } else if userName == "" && profileButton.imageView?.image == nil {
                //아이디와 프로파일 이미지를 넣어달라는 팝업 메시지를 띄운다.
                let userNameAndProfileAlertTitle = "Please enter your name and image."
                alertController = UIAlertController(title: userNameAndProfileAlertTitle, message: "", preferredStyle: .alert)
                alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            loginIsSucceed = false;
        }
        
        if loginIsSucceed == true {
            self.mainTabBarController.isAppFirstOpen = false
            self.mainTabBarController.user = user
            
            UIApplication.shared.keyWindow?.rootViewController = self.mainTabBarController
            
            mainTabBarController.setTabViewControllers()
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    let goToLoginButton: UIButton = {
        let doTreeLoginButton = UIButton()
        let doTreeLoginButtonImage = UIImage(named: "AlreadyHaveAccount")
        
        doTreeLoginButton.setBackgroundImage(doTreeLoginButtonImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        doTreeLoginButton.addTarget(self, action: #selector(goToLoginButtonTapped), for: .touchUpInside)
        return doTreeLoginButton
    }()
    
    @objc func goToLoginButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - setViews
    func setViews() {
        self.view.addSubview(signupBackgroundImageView);
        self.view.addSubview(profileButton);
        self.view.addSubview(userNameTextField);
        self.view.addSubview(signupButton);
        self.view.addSubview(goToLoginButton);
       
        signupBackgroundImageView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        profileButton.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 1).isActive = true;
        profileButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: self.view.frame.height * (1/3), paddingLeft: 0, paddingBottom: self.view.frame.height * (2/3), paddingRight: 0, width: self.view.frame.width/3, height: self.view.frame.width/3)

      userNameTextField.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 0).isActive = true
          userNameTextField.anchor(top: self.profileButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: view.frame.height/30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width/2, height: view.frame.width/10)
        
        signupButton.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 0).isActive = true;
        signupButton.anchor(top: self.userNameTextField.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: view.frame.height/30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width/2, height: view.frame.width/10)
        
        goToLoginButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 44)
        goToLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    //MARK: - keyboardDismiss
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        
        print("userName \(userNameTextField.text)", " profileImage \(profileButton.imageView?.image)")
    }
    
    //MARK: - ImagePicker
    let imagePickerController: UIImagePickerController = {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true;
        return imagePickerController
    }()
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedPhoto: UIImage?
        
        selectedPhoto = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        self.profileButton.setImage(selectedPhoto?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        profileButton.layer.cornerRadius = profileButton.frame.width/2
        profileButton.layer.masksToBounds = true;
        
        self.dismiss(animated: true, completion: nil)
    }


}

