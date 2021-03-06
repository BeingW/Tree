//
//  ViewController.swift
//  Tree
//
//  Created by Jae Ki Lee on 5/22/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class SignupController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var editMode: Bool = false
    
    let imagePickerController: UIImagePickerController = {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true;
        return imagePickerController
    }()
    
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
    
    /*
     함수명: profileButtonTapped
     기능: 핸드폰의 사진 앱 안에서 사진을 선택해 가져온다.
     작성일자: 2019.07.05
     */
    @objc func profileButtonTapped() {
    //1.imagePickerController delegate 에 UIImagePickerControllerDelegate & UINavigationControllerDelegate 를 상속받고 있는 SignupController 를 넣어 활성화 시킨다.
        self.imagePickerController.delegate = self
    //2.imagePickerController 함수를 실행한다.
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    //3.사진앱으로 이동한다.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedPhoto: UIImage?
        //3.1.사진을 선택한다.
        selectedPhoto = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        //3.2.사진을 동그라미 버튼에 씌운다.
        self.profileButton.setImage(selectedPhoto?.withRenderingMode(.alwaysOriginal), for: .normal)
        //3.3.동그라미의 외각을 조정한다.
        self.profileButton.layer.cornerRadius = profileButton.frame.width/2
        self.profileButton.layer.masksToBounds = true;
        //3.4.화면을 dismiss 한다.
        self.dismiss(animated: true, completion: nil)
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
        let uiButton = UIButton(type: .system)
        let doTreeButtonImage = UIImage(named: "SignupButton")
        let attirbutedString = NSAttributedString(string: "Sign up", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.white])
        uiButton.setAttributedTitle(attirbutedString, for: .normal)
        uiButton.setBackgroundImage(doTreeButtonImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        uiButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return uiButton
    }()
    
    /*
     함수명: signUpButtonTapped
     기능: 회원가입한다.
     작성일자: 2019.07.05
     수정일자: 2019.07.15
     */
    @objc func signUpButtonTapped() {
        guard let userName = userNameTextField.text else {return}
        let userProfileImage = profileButton.imageView?.image
        let userDAO = UserDAO()
        let convertingImageAndUrl = ConvertingDataAndImage()
        
        if !editMode {
            var loginIsSucceed: Bool = false;
            let alertController = UIAlertController(title: "Please check signup information", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(alertAction)
            
            //모든 유저정보가 입력됐을 때.
            if userName != "" && userProfileImage != nil {
                guard let userProfilePicture = userProfileImage else {return}
                guard let profileImageUrl = convertingImageAndUrl.convertingFromImageToUrl(image: userProfilePicture) else { return }
                //유저는 하나의 계정만 생성할수 있다.
                if userDAO.getUserTableData().userName == "" {
                    userDAO.insertUser(userName: userName, userProfileImage: profileImageUrl)
                    loginIsSucceed = true
                } else {
                    let oneIdAlertController = UIAlertController(title: "Tree has only one ID", message: "", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    oneIdAlertController.addAction(alertAction)
                    self.present(oneIdAlertController, animated: true, completion: nil)
                    loginIsSucceed = false
                }
                
            } else {
                //2.1.입력정보를 확인해 달라는 메시지를 띄운다.
                self.present(alertController, animated: true, completion: nil)
                //2.2.loginIsSucced 를 false 로 한다.
                loginIsSucceed = false
            }
            //3.loginIsSucceed 가 true 라면
            if loginIsSucceed == true {
                self.present(MainTabBarController(), animated: true, completion: nil)
                //데이터가 성공적으로 db 에 입력되었는지 확인한다.
                userDAO.selectQuery(tableName: "user", primaryKey: "user_id")
            }
        } else {
            let profileUrl = convertingImageAndUrl.convertingFromImageToUrl(image: userProfileImage!)
            userDAO.updateUser(userName: userName, userProfileImage: profileUrl!)
            let userInfo = userDAO.getUserTableData()
            Diary.shared.setUserName(userName: userInfo.userName)
            Diary.shared.setUserProfilImageUrl(userProfileImageUrl: userInfo.userProfileImage)
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
    
    /*
     함수명: goToLoginButtonTapped
     기능: 계정이 있다면, LoginController 로 되돌아간다.
     작성일자: 2019.07.05
     */
    @objc func goToLoginButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - setViews and setEditModeView
    func setViews() {
        self.view.addSubview(signupBackgroundImageView)
        self.view.addSubview(profileButton)
        self.view.addSubview(goToLoginButton)
        let signupStakView = UIStackView(arrangedSubviews: [userNameTextField, signupButton])
        signupStakView.axis = .vertical
        signupStakView.spacing = 30
        self.view.addSubview(signupStakView)
       
        signupBackgroundImageView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        profileButton.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 1).isActive = true
        profileButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: self.view.frame.height * (1/3), paddingLeft: 0, paddingBottom: self.view.frame.height * (2/3), paddingRight: 0, width: self.view.frame.width/3, height: self.view.frame.width/3)
        
        signupStakView.anchor(top: self.profileButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: view.frame.height/30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width/2, height: 110)
        signupStakView.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 0).isActive = true
    
        goToLoginButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 44)
        goToLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    func editModeView() {
        //1.1.User 객체의 data 를 UI 에 넣는다.
        let userImageString = Diary.shared.getUserProfileImageUrl()
        let convetingImage = ConvertingDataAndImage()
        guard let userProfileImage = convetingImage.convertingFromUrlToImage(uniqueId: userImageString) else {return}
        self.userNameTextField.text = Diary.shared.getUserName()
        self.profileButton.setImage(userProfileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.profileButton.layer.cornerRadius = 125/2
        self.profileButton.layer.masksToBounds = true;
        
        //1.2.SignupButton 의 text를 Save 바꾼다.
        let attirbutedString = NSAttributedString(string: "Save", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.white])
        self.signupButton.setAttributedTitle(attirbutedString, for: .normal)
        //1.3.goToLoginButton 을 숨긴다.
        self.goToLoginButton.isHidden = true
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    

    



}

