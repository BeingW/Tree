//
//  LoginController.swift
//  Tree
//
//  Created by Jae Ki Lee on 5/27/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    //MARK: - UIViews
    let loginBackgroundImageView: UIImageView = {
        let backgroundImage = UIImage(named: "LoginBackground@2x")
        let loginBackgroundView = UIImageView(image: backgroundImage)
        
        return loginBackgroundView
    }()
    
    let treeMainImageView: UIImageView = {
        let treeMainImage = UIImage(named: "TREE.png")!
        let treeMainImageView = UIImageView(image: treeMainImage)
        return treeMainImageView
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
        let doTreeButtoBackgroundImage = UIImage(named: "LoginButton")
        loginButton.setBackgroundImage(doTreeButtoBackgroundImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        let attirbutedString = NSAttributedString(string: "Login", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.white])
        loginButton.setAttributedTitle(attirbutedString, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return loginButton
    }()
    
    /*
     함수명: loginButtonTapped
     기능: 로그인 한다.
     작성일자: 2019.07.05
     */
    @objc func loginButtonTapped() {
        //1.userName 을 가져온다.
        guard let userName = self.userNameTextField.text else {return}
        //2.userPassword 을 가져온다.
        //3.가입한 user 객체를 가져온다.
        //4.가입한 user 정보를 가져온다.
        let signedUserName = Diary.shared.getUserName()
        //5.입력한 user 정보과 가입된 user 정보가 같다면
        if signedUserName == userName && signedUserName != "" {
            //5.1.MainTabBarController 로 이동한다.
            self.present(MainTabBarController(), animated: true, completion: nil)
        //6.다르다면, 입력정보를 확인해 달라는 메시지를 띄운다.
        } else {
            let alertController = UIAlertController(title: "Please check login information", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    let goToSignupButton: UIButton = {
        let goToSignupButton = UIButton()
        let goToSignupButtonImage = UIImage(named: "HaveAccount")
        goToSignupButton.setBackgroundImage(goToSignupButtonImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        goToSignupButton.addTarget(self, action: #selector(goToSignupButtonTapped), for: .touchUpInside)
        return goToSignupButton
    }()
    
    /*
     함수명: goToSignupButtonTapped
     기능: 계정이 없으면, SignupPage 로 이동한다.
     작성일자: 2019.07.05
     */
    @objc func goToSignupButtonTapped() {
        //1.SignupController 객체를 생성한다.
        let signupController = SignupController()
       
        //2.SignupController로 push 이동한다.
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
        let loginStackview = UIStackView(arrangedSubviews: [treeMainImageView, userNameTextField, loginButton])
        loginStackview.axis = .vertical
        loginStackview.spacing = view.frame.height/30
        //옆 패딩 54, loginText 거리 30 높이 124
        
        self.view.addSubview(loginBackgroundImageView)
        self.view.addSubview(loginStackview)
        loginStackview.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(goToSignupButton)
        
        //loginBackground
        loginBackgroundImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        //login StackView
        loginStackview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginStackview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
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
