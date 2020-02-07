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
//    func addNewPage(diaryPage: DiaryPage) -> Int {
//
//        self.diary.append(diaryPage)
//
//        let count = self.diary.count
//
//        var i = 0
//
//        while i < count && diaryPage == self.diary[i]! {
//            i += 1
//        }
//
//        return i
//    }
    
    /*
     함수명: deleteDiaryPages
     기능: 선택된 diaryPage들을 지웁니다.
     작성일자: 2019.07.25
     수정일자:
     */
    func deleteDiaryPages(indexs: [Int]) {
        //1.지울 diarypage들에 대한 배열변호를 입력받는다.
        //2.i=0 으로 초기화 한다.
        var i = 0
        //3.i 가 배열의 수보다 작을 동안 반복한다.
        while indexs.count > i {
            //3.1.indexes의 i 번째 diaryPage를 지운다.
            let index = indexs[i]
            diary.remove(at: index)
            //3.2.i 를 증가시킨다.
            i += 1
        }
    }
    
    /*
     함수명: deleteAllDiary
     기능: 모든 diaryPage를 지운다.
     작성일자: 2019.07.25
     수정일자:
     */
    func deleteAllDiary() {
        self.diary.removeAll()
    }
    
    
    
 
    
}
