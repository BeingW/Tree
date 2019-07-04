//
//  UserDAO.swift
//  Tree
//
//  Created by Jae Ki Lee on 02/07/2019.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class UserDAO: FMDBHelper {
    
    init() {
        super.init(fileName: "Tree", identifier: "db")
    }
    
    /*
     함수명: makeUserId
     기능: 중복되지 않는 user_id 를 만들어 반환한다.
     작성일자: 2019.07.02
     */
    func makeUserId() -> String {
        //1. 변수들을 초기화 한다.
        var number = 0
        var presentNumber = 0
        var previousNumber = 0
        var idNumber: String
        var userId: String = ""
        
        do{
            let selectQuery = "SELECT user_id FROM user"
            let resultSet = try self.fmdb.executeQuery(selectQuery, values: nil)
            //2.user_id 가 있다면 끝까지 반복한다.
            while resultSet.next() {
                //2.1.user_id 를 뽑아낸다.
                var selectedUserId = resultSet.string(forColumn: "user_id")!
                //2.2.user_id 에서 "U"를 지운다.
                selectedUserId.removeFirst()
                //2.3."U"를 지운 user_id 를 정수화 하여, presnetNumber 에 넣는다.
                presentNumber = Int(selectedUserId)!
                //2.4.presentNumber 와 previousNumber를 비교한다.
                //2.4.1.previousNumber 가 크다면 number에 previousNumber 을 넣는다,
                if previousNumber > presentNumber {
                    number = previousNumber
                //2.4.2.presentNumber 가 크다면 number에 presentNumber 을 넣는다,
                } else if previousNumber < presentNumber {
                    number = presentNumber
                }
                //2.5.previousNumber 에 presentNumber 를 넣는다.
                previousNumber = presentNumber
            }
            //3. number에 1을 더한다.
            number += 1
            //4. number가 1 자리이면 앞에 000 을 더한다
            if number >= 0 || number <= 9 {
                idNumber = "000" + "\(number)"
            //5. number가 2 자리이면 앞에 00 을 더한다
            } else if number >= 10 || number <= 99{
                idNumber = "00" + "\(number)"
            //6. number가 3 의 자리이면 앞에 0 을 더한다
            } else if number >= 100 || number <= 999 {
                idNumber = "0" + "\(number)"
            } else {
                idNumber = "\(number)"
            }
            
            //7.number 앞에 'U'를 붙여 userId 를 만든다.
            userId = "U" + idNumber
            
        } catch let error as NSError {
            self.fmdb.rollback()
            print("===== fetchPassportData() failure. =====")
            print("failed: \(error.localizedDescription)")
            print("========================================")
        }
        
        //8. 반환한다.
        return userId
    }
    
    /*
     함수명: fetchData
     기능: DB 에서 user data 를 가져와 user class 에 넣어 생성한 후 반환한다.
     작성일자: 2019.07.02
     */
    func fetchData() -> User {
        var userName: String = ""
        var userProfilePicture: String = ""
        var user: User
        
        do {
            //1.user table 을 읽는다.
            let selectQuery = "SELECT * FROM user"
            let resultSet = try self.fmdb.executeQuery(selectQuery, values: nil)
            //2.userName 과 userProfilePictrue 을 저장해 놓는다.
            userName = resultSet.string(forColumn: "user_name")!
            userProfilePicture = resultSet.string(forColumn: "user_profilepicture")!
            
        } catch let error as NSError {
            self.fmdb.rollback()
            print("===== fetchPassportData() failure. =====")
            print("failed: \(error.localizedDescription)")
            print("========================================")
        }
        //3.저장해 놓은 data로 user class 를 만든다.
        user = User(profilePicture: userProfilePicture, userName: userName)
        //4.user class 를 반환한다.
        return user
    }
    
    /*
     함수명: insertData
     기능: 입력한 user Data 를 user, user_diarypage_relation Table 에 넣는다.
     작성일자: 2019.07.02
     */
    func insertData(userName: String, userProfilePicture: String) {
        //1. userName 과 userProfilePicture 을 입력받는다.
        //2. makeUserId 함수를 실행시켜 userId를 만든다.
        let userId = makeUserId()
        var insertQuery: String = ""
        var parmeters = [Any]()
        //3.dbPath 를 넣어 FMDatabaseQueue 객체를 생성한다.
        let fmdbQueue = FMDatabaseQueue(path: self.dbPath)
        
        fmdbQueue?.inTransaction({ (db, rollback) in
            do {
                //4.입력받을 데이터를 넣을 쿼리를 작성한다.
                insertQuery = "INSERT INTO user (user_id, user_name, user_profilepicture) VALUES (?, ?, ?)"
                parmeters.append(userId)
                parmeters.append(userName)
                parmeters.append(userProfilePicture)
                //5.쿼리를 작동한다.
                try db.executeUpdate(insertQuery, values: parmeters)
                parmeters.removeAll()
                
                //4.입력받을 데이터를 넣을 쿼리를 작성한다.
                insertQuery = "INSERT INTO user_diarypage_relation (diarypage_id, user_id) VALUES (?, ?)"
                parmeters.append("NULL")
                parmeters.append(userId)
                //5.쿼리를 작동한다.
                try db.executeUpdate(insertQuery, values: parmeters)
                parmeters.removeAll()
                
            }catch{
                rollback.pointee = true
                print(error)
            }
        })
        
    }
    
    /*
     함수명: updateData
     기능: 특정 user table 을 수정한다.
     작성일자: 2019.07.02
     */
    func updateData(userId: String, userName: String?, userProfilePicture: String?) {
        //1. userId, userName, userProfile 을 입력받는다.
        var parmeters = [Any]()
        var updateQuery: String = ""
        //2.userName 이 nil 이 아니면, userId 컬럼을 수정한다.
        if userName != nil {
            guard let userName = userName else {return}
            do {
                //2.1.userName을 수정할 쿼리를 작성한다.
                updateQuery = "UPDATE user SET user_name = ? WHERE user_id = ?"
                parmeters.append(userName)
                parmeters.append(userId)
                //2.2.userName을 수정한다.
                try self.fmdb.executeUpdate(updateQuery, values: parmeters)
            } catch let error as NSError {
                self.fmdb.rollback()
                print("===== fetchPassportData() failure. =====")
                print("failed: \(error.localizedDescription)")
                print("========================================")
            }
        //3.userProfilePicture 이 nil 이 아니면, userProfilePicture 컬럼을 수정한다.
        } else if userProfilePicture != nil{
            guard let userProfilePicture = userProfilePicture else {return}
            do {
                //3.1.userProfilePicture 을 수정할 쿼리를 작성한다.
                updateQuery = "UPDATE user SET user_profilepicture = ? WHERE user_id = ?"
                parmeters.append(userProfilePicture)
                parmeters.append(userId)
                //2.2.userProfilePicture을 수정한다.
                try self.fmdb.executeUpdate(updateQuery, values: parmeters)
            } catch let error as NSError {
                self.fmdb.rollback()
                print("===== fetchPassportData() failure. =====")
                print("failed: \(error.localizedDescription)")
                print("========================================")
            }
        }
    }
    
    /*
     함수명: deleteData
     기능: 특정 user table 을 지우고, 그에 따른 모든 데이터를 지운다(회원탈퇴).
     작성일자: 2019.07.02
     */
    func deleteData(userId: String) {
        //1.지울 user_id 를 입력 받는다.
        var selectQuery: String = ""
        var deleteQuery: String = ""
        //2.dbPath로 FMDatabaseQueue 객체를 생성한다.
        let fmdbQueue = FMDatabaseQueue(path: self.dbPath)
        
        fmdbQueue?.inTransaction({ (db, rollback) in
            do {
                selectQuery = "SELECT diarypage_id FROM user_diarypage_relation"
                let userDiaryPGRS = try db.executeQuery(selectQuery, values: nil)
            //3.user_diarypage_relation row 갯수만큼 반복한다.
                while userDiaryPGRS.next() {
                    guard let diarypageId = userDiaryPGRS.string(forColumn: "diarypage_id") else {return}
                    //3.1.diarypage_id 에 따른 diarypage_title table row 를 지운다.
                    deleteQuery = "DELETE FROM diarypage_title WHERE diarypage_id = ?"
                    try db.executeUpdate(deleteQuery, values: [diarypageId])
                    //3.2.diarypage_id 에 따른 diarypage_text table row 를 지운다.
                    deleteQuery = "DELETE FROM diarypage_text WHERE diarypage_id = ?"
                    try db.executeUpdate(deleteQuery, values: [diarypageId])
                    
                    
                    selectQuery = "SELECT image_id FROM diarypage_images_relation WHERE diarypage_id = ?"
                    let diaryImageRelationRS = try db.executeQuery(selectQuery, values: [diarypageId])
                    //3.3.diarypage_images_relation 갯수만큼 반복한다.
                    while diaryImageRelationRS.next() {
                        //3.3.1.image_id 에 따른 images table row 를 지운다.
                        guard let imageId = diaryImageRelationRS.string(forColumn: "image_id") else {return}
                        deleteQuery = "DELETE FROM images WHERE image_id = ?"
                        try db.executeUpdate(deleteQuery, values: [imageId])
                    }
                    
                    //3.4.diarypage_id 에 따른 user_diarypage_relation table row 를 지운다.
                    deleteQuery = "DELETE FROM diarypage_images_relation WHERE diarypage_id = ?"
                    try db.executeUpdate(deleteQuery, values: [diarypageId])
                    //3.5.diarypage_id 에 따른 diarypage table row 를 지운다.
                    deleteQuery = "DELETE FROM diarypage WHERE diarypage_id = ?"
                    try db.executeUpdate(deleteQuery, values: [diarypageId])
                }
                //4.user_id 에 따른 user_diarypage_relation table row 를 지운다.
                deleteQuery = "DELETE FROM user_diarypage_relation WHERE user_id = ?"
                try db.executeUpdate(deleteQuery, values: [userId])
                //5.user_id 에 따른 user table row 를 지운다.
                deleteQuery = "DELETE FROM user WHERE user_id = ?"
                try db.executeUpdate(deleteQuery, values: [userId])
                
            } catch {
                rollback.pointee = true
                print(error)
            }
        })
    
    }
    
}
