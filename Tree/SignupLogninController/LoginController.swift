//
//  LoginController.swift
//  Tree
//
//  Created by Jae Ki Lee on 5/27/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    var mainTabBarController = MainTabBarController()
    
    //MARK: - UIViews
    let loginBackgroundImageView: UIImageView = {
        let backgroundImage = UIImage(named: "LoginBackground@2x")
        let loginBackgroundView = UIImageView(image: backgroundImage)
        
        return loginBackgroundView
    }()
    
    let userNameTextField: UITextField = {
       let userNameTexField = UITextField()
        let userNameBackgroundImage = UIImage(named: "UserNameTextField@2x")
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        userNameTexField.leftView = paddingView
        userNameTexField.leftViewMode = .always
        
        userNameTexField.background = userNameBackgroundImage
        
        return userNameTexField
    }()
    
    let loginButton: UIButton = {
        let loginButton = UIButton()
        let doTreeButtoBackgroundImage = UIImage(named: "LoginButton@2x")
        loginButton.setBackgroundImage(doTreeButtoBackgroundImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return loginButton
    }()
    
    @objc func loginButtonTapped() {
        self.mainTabBarController.isAppFirstOpen = false
        
        UIApplication.shared.keyWindow?.rootViewController = self.mainTabBarController
        
        self.dismiss(animated: true, completion: nil)
    }
    
    let goToSignupButton: UIButton = {
        let goToSignupButton = UIButton()
        let goToSignupButtonImage = UIImage(named: "HaveAccount")
        goToSignupButton.setBackgroundImage(goToSignupButtonImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        goToSignupButton.addTarget(self, action: #selector(goToSignupButtonTapped), for: .touchUpInside)
        return goToSignupButton
    }()
    
    @objc func goToSignupButtonTapped() {
        let signupController = SignupController()
        signupController.mainTabBarController = self.mainTabBarController
        self.navigationController?.pushViewController(signupController, animated: true)
    }
    
    //MARK: - KeyboardDismiss
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - SetUIViews
    func setViews() {
        self.userNameTextField.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        self.userNameTextField.heightAnchor.constraint(equalToConstant: view.frame.width / 10).isActive = true
        self.loginButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        self.loginButton.heightAnchor.constraint(equalToConstant: view.frame.width / 10).isActive = true
        let userNameDoTeeStackview = UIStackView(arrangedSubviews: [userNameTextField, loginButton])
        userNameDoTeeStackview.axis = .vertical
        userNameDoTeeStackview.spacing = view.frame.height/30
        
        self.view.addSubview(loginBackgroundImageView)
        self.view.addSubview(userNameDoTeeStackview)
        userNameDoTeeStackview.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(goToSignupButton)
        
        //loginBackground
        loginBackgroundImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        //login and doTree StackView
        userNameDoTeeStackview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userNameDoTeeStackview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //signup
        goToSignupButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 44)
        goToSignupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
}
