//
//  LoginAndSignUpTests.swift
//  TreeUnitTests
//
//  Created by Jae Ki Lee on 05/02/2020.
//  Copyright © 2020 Jae Ki Lee. All rights reserved.
//

import XCTest
@testable import Tree

class Diary {
    private var userName: String = ""
    private var userProfileImageUrl: String = ""
    var isOpenedDiary: Bool = false
    
    init() {
        
    }
    
    init(userName: String, userProfileImage: String) {
        self.userName = userName
        self.userProfileImageUrl = userProfileImage
    }
    
    func getUserName() -> String {
        return self.userName
    }
    
    func setUserName(userName: String) -> String {
        self.userName = userName
        return self.userName
    }
    
    func getUserProfileImageUrl() -> String {
        return self.userProfileImageUrl
    }
    
    func setUserProfilImageUrl(userProfileImageUrl: String) -> String {
        self.userProfileImageUrl = userProfileImageUrl
        return self.userProfileImageUrl
    }
    
    func login(userName: String) -> Bool {
        //대소문자 관계없이 로그인 되도록 한다.
        let lowercaseUserName = self.userName.lowercased()
        let uppercaseUserName = self.userName.uppercased()
        
        if userName == lowercaseUserName || userName == uppercaseUserName {
            self.isOpenedDiary = true
        } else {
            self.isOpenedDiary = false
        }
        
        return isOpenedDiary
    }
}

class LoginAndSignUpTests: XCTestCase {
    
    let diary = Diary()
    let userDAO = UserDAO()
    //    let diaryDAO = DiaryDAO()
    //    let userDAO = UserDAO
    
    override func setUp() {
        
    }
    
    func testSignupAndLogin() {
        //given 환경, 유저가 회원가입 할 때 이름만 넣습니다.
        //when 실행, 유저가 회원가입 할 때 유저의 Diary 가 만들어 집니다.
        //1.유저가 회원가입한다.
        self.diary.setUserName(userName: "jae")
        self.diary.setUserProfilImageUrl(userProfileImageUrl: "I0001")
        
        //then 결과값 확인
        XCTAssertEqual(diary.getUserName(), "jae")
        XCTAssertEqual(diary.getUserProfileImageUrl(), "I0001")
        
        //2.유저가 회원가입 한 후 회원가입한 data 를 DB 에 넣는다.
        addTeardownBlock {
            self.putSignUpDataOnDB()
        }
        
        //3.회원가입한 정보로 유저가 로그인 한다.
        addTeardownBlock {
            self.loginTest()
        }
        
    }
    
    func putSignUpDataOnDB() {
        //1.Diary userId, userProfileImage 를 TreeDB 의 user_name, user_profileImage 에 넣는다.
        let userName = self.diary.getUserName()
        let userProfileImage = self.diary.getUserProfileImageUrl()
        
        self.userDAO.insertData(userName: userName, userProfileImage: userProfileImage)
        
    }
    
    func loginTest() {
        //given
        //when, 대소문자 구분없이 통과시킨다.
        let userTypeText1 = "jae" // true
        let userTypeText2 = "JA" // false
        let userTypeText3 = "JAE" // true
        let userTypeText4 = "Jae" // false
        
        //then
        XCTAssertTrue(self.diary.login(userName: userTypeText1))
        XCTAssertFalse(self.diary.login(userName: userTypeText2))
        XCTAssertTrue(self.diary.login(userName: userTypeText3))
        XCTAssertFalse(self.diary.login(userName: userTypeText4))
        
    }
    
    
}
