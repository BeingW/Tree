//
//  LoginController.swift
//  Tree
//
//  Created by Jae Ki Lee on 5/27/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    //MARK: - DiaryTableViewController Instance
    let diaryTableViewController = DiaryTableViewController()
    
    //MARK: - LoginBackgroundView
    let loginBackgroundImageView: UIImageView = {
        let backgroundImage = UIImage(named: "LoginBackground@2x")
        let loginBackgroundView = UIImageView(image: backgroundImage)
        
        return loginBackgroundView
    }()
    
    //MARK: - UserNameTextField
    let userNameTextField: UITextField = {
       let userNameTexField = UITextField()
        let userNameBackgroundImage = UIImage(named: "UserNameTextField@2x")
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        userNameTexField.leftView = paddingView
        userNameTexField.leftViewMode = .always
        
        userNameTexField.background = userNameBackgroundImage
        
        return userNameTexField
    }()
    
    //MARK: - DoTreeButtonView
    let doTreeButton: UIButton = {
        let doTreeButton = UIButton()
        let doTreeButtoBackgroundImage = UIImage(named: "LoginButton@2x")
        doTreeButton.setBackgroundImage(doTreeButtoBackgroundImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        doTreeButton.addTarget(self, action: #selector(doTreeButtonTapped), for: .touchUpInside)
        return doTreeButton
    }()
    
    @objc func doTreeButtonTapped() {
        self.present(diaryTableViewController, animated: true, completion: nil)
    }
    
    //MARK: - SignupTreeButtonView
    let signupTreeButton: UIButton = {
        let signupTreeButton = UIButton()
        let signupTreeButtonImage = UIImage(named: "HaveAccount")
        signupTreeButton.setBackgroundImage(signupTreeButtonImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        signupTreeButton.addTarget(self, action: #selector(signupTreeButtonTapped), for: .touchUpInside)
        return signupTreeButton
    }()
    
    @objc func signupTreeButtonTapped() {
        let signupController = SignupController()
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
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        
        diaryTableViewController.isProgramFirstOpen = false
    }
    
    //MARK: - SetUIViews
    func setViews() {
        self.userNameTextField.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        self.userNameTextField.heightAnchor.constraint(equalToConstant: view.frame.width / 10).isActive = true
        self.doTreeButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        self.doTreeButton.heightAnchor.constraint(equalToConstant: view.frame.width / 10).isActive = true
        let userNameDoTeeStackview = UIStackView(arrangedSubviews: [userNameTextField, doTreeButton])
        userNameDoTeeStackview.axis = .vertical
        userNameDoTeeStackview.spacing = view.frame.height/30
        
        self.view.addSubview(loginBackgroundImageView)
        self.view.addSubview(userNameDoTeeStackview)
        userNameDoTeeStackview.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(signupTreeButton)
        
        //loginBackground
        loginBackgroundImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        //login and doTree StackView
        userNameDoTeeStackview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userNameDoTeeStackview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //signup
        signupTreeButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 44)
        signupTreeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    }
    
    
    
}
