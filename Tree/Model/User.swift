//
//  Diary.swift
//  Tree
//
//  Created by Jae Ki Lee on 5/22/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import Foundation
import UIKit

class User {

    static var shared = User()
    
    private var name: String?
    private var password: String?
    private var profilePictureUrl: String?

    var diary: [DiaryPage?]
    
    init() {
        self.name = ""
        self.password = ""
        self.profilePictureUrl = ""
        self.diary = []
    }
    
    init(name: String?, password: String?, profilePictureUrl: String?) {
        self.name = name
        self.password = password
        self.profilePictureUrl = profilePictureUrl
        self.diary = []
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getName() -> String? {
        return name
    }
    
    func getPassword() -> String? {
        return password
    }
    
    func getProfilePictureUrl() -> String? {
        return profilePictureUrl
    }
    
    /*
     함수명: editName
     기능: user객체의 userName 을 수정한다.
     작성일자: 2019.07.05
     수정일자:
     */
    func editName(name: String) -> String?{
        self.name = name
        return self.name
    }
    
    /*
     함수명: editPassword
     기능: user객체의 userPassword 을 수정한다.
     작성일자: 2019.07.05
     수정일자:
     */
    func editPassword(password: String) -> String?{
        self.password = password
        return self.password
    }
    
    /*
     함수명: editProfilePictureUrl
     기능: user객체의 profilePicture 을 수정한다.
     작성일자: 2019.07.05
     수정일자:
     */
    func editProfilePictureUrl(url: String) -> String?{
        self.profilePictureUrl = url
        return self.profilePictureUrl
    }
    /*
     함수명: addNewPage
     기능: 다이어리에 새 페이지를 꽂는다.
     작성일자: 2019.07.09
     수정일자:
     */
    func addNewPage(diaryPage: DiaryPage) -> Int {
        
        self.diary.append(diaryPage)
        
        let count = self.diary.count
        
        var i = 0
        
        while i < count && diaryPage == self.diary[i]! {
            i += 1
        }
        
        return i
    }
    
    /*
     함수명: deleteDiaryPageAt
     기능: 특정한 DiaryPage 를 지운다.
     작성일자: 2019.07.09
     수정일자:
     */
    func deleteDiaryPageAt(index: Int) {
        self.diary.remove(at: index)
    }
    
    /*
     함수명: deleteDiaryPageAt
     기능: 특정한 DiaryPage 를 지운다.
     작성일자: 2019.07.09
     수정일자:
     */
    func deleteDiary() {
        self.diary.removeAll()
    }
    
    
    
 
    
}
