//
//  ViewController.swift
//  Tree
//
//  Created by Jae Ki Lee on 5/22/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class SignupController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    //MARK: - BackgroundView
    let backgroundView: UIView = {
        let backgroundView = UIView();
        
        let backgroundImage = UIImage(named: "SignupBackground@2x");
        let imageView = UIImageView(image: backgroundImage);
        
        backgroundView.addSubview(imageView);
        imageView.anchor(top: backgroundView.topAnchor, left: backgroundView.leftAnchor, bottom: backgroundView.bottomAnchor, right: backgroundView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        return backgroundView
    }()
    
    //MARK: - ProfileButton
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
    
    //MARK: - userNameTextField
    let userNameTextField: UITextField = {
        let textField = UITextField();
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.leftView = paddingView
        textField.leftViewMode = .always
 
        let image = UIImage(named: "UserNameTextField@2x")
        textField.background = image
        
        return textField;
    }()
    
    //MARK: - DoTreeButton
    let signupButton: UIButton = {
        let doTreeButton = UIButton(type: .system)
        let doTreeButtonImage = UIImage(named: "LoginButton@2x")
        doTreeButton.setBackgroundImage(doTreeButtonImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        doTreeButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        return doTreeButton
    }()
    
    @objc func signupButtonTapped() {
        
        var loginIsSucceed: Bool = false;
        guard let userName: String = userNameTextField.text else {return}
        guard let userProfilePicture: UIImage = profileButton.imageView?.image else {return}
        
        if userName != "" && userProfilePicture != nil {
            //profilePicture And userName are texted
            
            loginIsSucceed == true;
        } else {
            if userName != "" {
                //only userName is texted
            } else if userProfilePicture != nil {
                //only userProfilePicture is texted
            } else {
                //both of them are not texted
            }
            loginIsSucceed == false;
        }
        
        if loginIsSucceed == true {
            
        }
        
    }
    
    //MARK: - setViews
    func setViews() {
        self.view.addSubview(backgroundView);
        self.view.addSubview(profileButton);
        self.view.addSubview(userNameTextField);
        self.view.addSubview(signupButton);
       
        backgroundView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        profileButton.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 1).isActive = true;
        
        profileButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: self.view.frame.height * (1/3), paddingLeft: 0, paddingBottom: self.view.frame.height * (2/3), paddingRight: 0, width: self.view.frame.width/3, height: self.view.frame.width/3)
        
        userNameTextField.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 0).isActive = true
        userNameTextField.anchor(top: self.profileButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: view.frame.height/30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width/2, height: view.frame.width/10)
        signupButton.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 0).isActive = true;
        signupButton.anchor(top: self.userNameTextField.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: view.frame.height/30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width/2, height: view.frame.width/10)
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
    
    //MARK: - userDiary instance
    let userDiary: Diary = Diary(profilePicture: nil, userName: nil)
    
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

