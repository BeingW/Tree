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
<<<<<<< HEAD
    private var name: String
    private var password: String
    private var profilePicture: String

    var diary: [DiaryPage?]
    
    init(userName: String, userPassword: String, profilePicture: String) {
        self.name = userName
        self.password = userPassword
        self.profilePicture = profilePicture
=======
    private var name: String?
    private var password: String?
    private var profilePictureUrl: String?

    var diary: [DiaryPage?]
    
    init(name: String?, password: String?, profilePictureUrl: String?) {
        self.name = name
        self.password = password
        self.profilePictureUrl = profilePictureUrl
>>>>>>> working
        self.diary = [nil]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
<<<<<<< HEAD
    func getUserName() -> String {
        return name
    }
    
    func getUserPassword() -> String {
=======
    func getName() -> String? {
        return name
    }
    
    func getPassword() -> String? {
>>>>>>> working
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
<<<<<<< HEAD
    func chageUserName(userName: String) -> String {
        self.name = userName
=======
    func editName(name: String) -> String?{
        self.name = name
>>>>>>> working
        return self.name
    }
    
    /*
     함수명: editPassword
     기능: user객체의 userPassword 을 수정한다.
     작성일자: 2019.07.05
     수정일자:
     */
<<<<<<< HEAD
    func chageUserPassword(userPassword: String) -> String {
        self.password = userPassword
=======
    func editPassword(password: String) -> String?{
        self.password = password
>>>>>>> working
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
 */
    
}
