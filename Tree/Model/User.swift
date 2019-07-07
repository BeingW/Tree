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
    private var name: String
    private var password: String
    private var profilePicture: String

    var diary: [DiaryPage?]
    
    init(userName: String, userPassword: String, profilePicture: String) {
        self.name = userName
        self.password = userPassword
        self.profilePicture = profilePicture
        self.diary = [nil]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getUserName() -> String {
        return name
    }
    
    func getUserPassword() -> String {
        return password
    }
    
    func getProfilePicture() -> String {
        return profilePicture
    }
    
    /*
     함수명: chageUserName
     기능: user객체의 userName 을 수정한다.
     작성일자: 2019.07.05
     */
    func chageUserName(userName: String) -> String {
        self.name = userName
        return self.name
    }
    
    /*
     함수명: chageUserPassword
     기능: user객체의 userPassword 을 수정한다.
     작성일자: 2019.07.05
     */
    func chageUserPassword(userPassword: String) -> String {
        self.password = userPassword
        return self.password
    }
    
    /*
     함수명: changeProfilePicture
     기능: user객체의 profilePicture 을 수정한다.
     작성일자: 2019.07.05
     */
    func changeProfilePicture(profilePicture: String) -> String {
        self.profilePicture = profilePicture
        return self.profilePicture
    }
    
    /*
    func addNewPage(diaryPage: DiaryPage) -> Int {
        
        self.diary.append(diaryPage)
        
        let count = self.diary.count
        
        var i = 0
        
        while i < count && diaryPage == self.diary[i]! {
            i += 1
        }
        
        return i
    }
 
    
    func deleteAllDiaryPage() {
        self.diary.removeAll()
    }
    
    func deleteDiaryPageAt(index: Int) {
        self.diary.remove(at: index)
    }
     */
}
