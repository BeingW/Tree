//
//  Diary.swift
//  Tree
//
//  Created by Jae Ki Lee on 06/02/2020.
//  Copyright © 2020 Jae Ki Lee. All rights reserved.
//

import Foundation

class Diary {
    private var userName: String = ""
    private var userProfileImageUrl: String = ""
    var isOpenedDiary: Bool = false
    var pages = [DiaryPage]()
    
    static var shared = Diary()
    
    init() {
        
    }
    
    init(userName: String, userProfileImage: String) {
        self.userName = userName
        self.userProfileImageUrl = userProfileImage
    }
    
    init(userName: String, userProfileImage: String, diaryPages: [DiaryPage]?) {
        self.userName = userName
        self.userProfileImageUrl = userProfileImage
        self.pages = diaryPages ?? [DiaryPage]()
    }
    
    func getUserName() -> String {
        return self.userName
    }
    
    func setUserName(userName: String) {
        self.userName = userName
    }
    
    func getUserProfileImageUrl() -> String {
        return self.userProfileImageUrl
    }
    
    func setUserProfilImageUrl(userProfileImageUrl: String) {
        self.userProfileImageUrl = userProfileImageUrl
    }
    
    func getPages() -> [DiaryPage] {
        return self.pages
    }
    
    func setPages(diaryPages: [DiaryPage]) {
        self.pages = diaryPages
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
