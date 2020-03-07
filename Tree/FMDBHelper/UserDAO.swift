//
//  UserDAO.swift
//  Tree
//
//  Created by Jae Ki Lee on 02/07/2019.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

struct UserTableData {
    let userName: String
    let userProfileImage: String
}

class UserDAO: FMDBHelper {
    
    init() {
        super.init(fileName: "Tree", identifier: "db")
    }
    
    /*
     함수명: insertIntoUserTable
     기능: DB user Table 에 userName, userProfileImage 를 넣는다.
     작성일자: 2020.02.06
     수정일자:
     */
    func insertUser(userName: String, userProfileImage: String) {
        //1. userName, userProfileImage 을 입력받는다.
        var insertQuery: String = ""
        var parmeters = [Any]()
        //2.dbPath 를 넣어 FMDatabaseQueue 객체를 생성한다.
        let fmdbQueue = FMDatabaseQueue(path: self.dbPath)
        
        fmdbQueue?.inTransaction({ (db, rollback) in
            do {
                //3.입력받을 데이터를 넣을 쿼리를 작성한다.
                insertQuery = "INSERT INTO user (user_name, user_profileImage) VALUES (?, ?)"
//                parmeters.append(userId)
                parmeters.append(userName)
                parmeters.append(userProfileImage)
                //4.쿼리를 작동한다.
                try db.executeUpdate(insertQuery, values: parmeters)
                parmeters.removeAll()
                
            }catch{
                rollback.pointee = true
                print(error)
            }
        })
    }
    
    /*
     함수명: getUserTableData
     기능: DB user Table 에서 data 를 가져와 useTable 객체로 바꾸어 반환한다.
     작성일자: 2020.02.06
     수정일자:
     */
    func getUserTableData() -> UserTableData {
        var selectQuery = ""
        var resultSet = FMResultSet()
        var userTableData: UserTableData = UserTableData(userName: "", userProfileImage: "")
        //1.fmdb 객체를 가져온다.
        let fmdbQueue = FMDatabaseQueue(path: self.dbPath)
        fmdbQueue?.inTransaction({ (db, rollBack) in
            do {
                //2.user Table 이 select query 를 작성한다.
                selectQuery = "SELECT * FROM user"
                try resultSet = db.executeQuery(selectQuery, values: nil)
                
                if resultSet.next() {
                    //3.user Table 에 data 를 가져온다.
                    let userName = resultSet.string(forColumn: "user_name") ?? ""
                    let userProfileImage = resultSet.string(forColumn: "user_profileImage") ?? ""
                    //4.useTable 객체를 가져온 data를 이용해 만든다.
                    userTableData = UserTableData(userName: userName, userProfileImage: userProfileImage)
                }
            } catch {
                self.fmdb.rollback()
                print("===== fetchPassportData() failure. =====")
                print("failed: \(error.localizedDescription)")
                print("========================================")
            }
        })
        //5.UserTable 을 반환한다.
        return userTableData
    }
    
    func checkOutUserTableExeist() -> Bool {
        var isExist: Bool = false
        
        do {
            let selectQuery = "SELECT * FROM user"
            let selectResultSet = try self.fmdb.executeQuery(selectQuery, values: nil)
            while selectResultSet.next() {
                if let userId = selectResultSet.string(forColumn: "user_id") {
                    isExist = true
                } else {
                    isExist = false
                }
            }
        } catch let error as NSError{
            self.fmdb.rollback()
            print("===== fetchPassportData() failure. =====")
            print("failed: \(error.localizedDescription)")
            print("========================================")
        }
    
        return isExist
        
    }
    
    /*
     함수명: selectUser
     기능: 데이터가 성공적으로 입력되었는지 확인한다.
     작성일자: 2019.07.15
     수정일자:
     */
    func selectQuery(tableName: String, primaryKey: String) {
        //0.확인할 table 이름을 입력받는다.
        //1.select query 를 만든다.
        do{
            let selectQuery = "SELECT \(primaryKey) FROM \(tableName)"
            //2.select query 를 실행한다.
            let resultSet = try self.fmdb.executeQuery(selectQuery, values: nil)
            //3.while문을 돌며 결과들을 출력한다.
            while resultSet.next() {
                print("\(resultSet.string(forColumn: primaryKey))")
            }
        }catch let error as NSError{
            self.fmdb.rollback()
            print("===== fetchPassportData() failure. =====")
            print("failed: \(error.localizedDescription)")
            print("========================================")
        }
    }
    
    /*
     함수명: makeUserId
     기능: 중복되지 않는 user_id 를 만들어 반환한다.
     작성일자: 2019.07.02
     수정일자:
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
            
            if resultSet.string(forColumn: "user_id") == "" {
                userId = "U0001"
            } else {
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
            }
            
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
    /*
     함수명: fetchData
     기능: DB 에서 user data 를 가져와 user class 에 넣어 생성한 후 반환한다.
     작성일자: 2019.07.02
     수정일자: 2019.07.09
     */
    func fetchData() -> User {
        var selectQuery: String = ""
        var resultSet = FMResultSet()
        
        var user = User()
        var diaryPage = DiaryPage()
        var diaryDate: String = ""
        var diaryTitle: String = ""
        var diaryText: String = ""
        var image: Image
        var images = [Image]()
        
        let fmdbQueue = FMDatabaseQueue(path: self.dbPath)
        fmdbQueue?.inTransaction({ (db, rollBack) in
            do {
                //1.user Table 을 이용해 user 객체를 만든다.
                selectQuery = "SELECT * FROM user"
                try resultSet = db.executeQuery(selectQuery, values: nil)
                if resultSet.next() {
                    let userName = resultSet.string(forColumn: "user_name")
                    let userPassword = resultSet.string(forColumn: "user_password")
                    let userProfilePicture = resultSet.string(forColumn: "user_profilePicture_url")
                    user = User(name: userName, password: userPassword, profilePictureUrl: userProfilePicture)
                }
                
                //2.user_diarypage_relation 의 수만큼 반복한다.(diarypage_id 가 'D0000'일 경우 pass)
                selectQuery = "SELECT * FROM user_diarypage_relation"
                try resultSet = db.executeQuery(selectQuery, values: nil)
                while resultSet.next() {
                    //2.1.해당번째의 diarypage_id를 뽑아낸다.
                    if let diarypageId = resultSet.string(forColumn: "diarypage_id"), diarypageId != "D0000" {
                        //2.2.diarypage에서 diarypage_id 의 diary_date를 뽑아낸다.
                        selectQuery = "SELECT diary_date FROM diarypage WHERE diarypage_id = '\(diarypageId)'"
                        let diaryResultSet = try db.executeQuery(selectQuery, values: nil)
                        if diaryResultSet.next() {
                            diaryDate = diaryResultSet.string(forColumn: "diary_date") ?? ""
                        }
                        //2.3.diarypage_title에서 diarypage_id 의 diarypage_title를 뽑아낸다.
                        selectQuery = "SELECT diarypage_title FROM diarypage_title WHERE diarypage_id = '\(diarypageId)'"
                        let diaryTitleResultSet = try db.executeQuery(selectQuery, values: nil)
                        if diaryTitleResultSet.next() {
                            diaryTitle = diaryTitleResultSet.string(forColumn: "diarypage_title") ?? ""
                        }
                        //2.4.diarypage_text에서 diarypage_id 의 diarypage_text를 뽑아낸다.
                        selectQuery = "SELECT diarypage_text FROM diarypage_text WHERE diarypage_id = '\(diarypageId)'"
                        let diaryTextResultSet = try db.executeQuery(selectQuery, values: nil)
                        if diaryTextResultSet.next() {
                            diaryText = diaryTextResultSet.string(forColumn: "diarypage_text") ?? ""
                        }
                        //2.5.diarypage_images_relation에서 diarypage_id 의 image_id가 있다면, 데이터베이스 끝까지 반복한다.
                        selectQuery = "SELECT image_id FROM diarypage_images_relation WHERE diarypage_id = '\(diarypageId)'"
                        let diarypageImageRelationRS = try db.executeQuery(selectQuery, values: nil)
                        while diarypageImageRelationRS.next() {
                            //2.5.1.해당번째 image_id 를 뽑아낸다.
                            guard let imageId = diarypageImageRelationRS.string(forColumn: "image_id") else {return}
                            selectQuery = "SELECT * FROM images WHERE image_id = '\(imageId)'"
                            let imagesResultSet = try db.executeQuery(selectQuery, values: nil)
                            if imagesResultSet.next() {
                                //2.5.2.image_id 의 image_url 를 뽑아낸다.
                                let imageUrl = imagesResultSet.string(forColumn: "image_url")
                                //2.5.3.image_id 의 image_width 를 뽑아낸다.
                                guard let imageWidth = imagesResultSet.string(forColumn: "image_width") else {return}
                                let imageWidthInt = Int(imageWidth)
                                //2.5.4.image_id 의 image_height 를 뽑아낸다.
                                guard let imageHeight = imagesResultSet.string(forColumn: "image_height") else {return}
                                let imageHeightInt = Int(imageHeight)
                                //2.5.5.image_id 의 image_createdDate 를 뽑아낸다.
                                guard let imageCreatedDateString = imagesResultSet.string(forColumn: "image_createdDate") else {return}
                                let dateFormatter = DateFormatter()
                                let imageCreateDate = dateFormatter.date(from: imageCreatedDateString)
                                //2.5.6.image 객체를 만든다.
                                let image = Image(url: imageUrl, width: imageWidthInt, height: imageHeightInt, createdDate: imageCreateDate)
                                //2.5.7.images 에 추가한다.
                                images.append(image)
                            }
                            
                        }
                        //2.6.diarypage 객체를 만든다.
                        diaryPage = DiaryPage(title: diaryTitle, date: diaryDate, text: diaryText, images: images)
                    }
                    //2.7.user 객체에 diary에 diarypage를 넣는다.
                    user.addNewPage(diaryPage: diaryPage)
                }
            } catch {
                self.fmdb.rollback()
                print("===== fetchPassportData() failure. =====")
                print("failed: \(error.localizedDescription)")
                print("========================================")
            }
        })
        
        //3.user 객체를 반환한다.
        return user
    }
*/
    
    /*
     함수명: insertData
     기능: 입력한 user Data 를 user Table 에 넣는다.
     작성일자: 2019.07.02
     수정일자: 2020.02.05
     */
    func insertData(userName: String, userProfileImage: String) {
        //1. userName, userProfileImage 을 입력받는다.
        var insertQuery: String = ""
        var parmeters = [Any]()
        //2.dbPath 를 넣어 FMDatabaseQueue 객체를 생성한다.
        let fmdbQueue = FMDatabaseQueue(path: self.dbPath)
        
        fmdbQueue?.inTransaction({ (db, rollback) in
            do {
                //3.입력받을 데이터를 넣을 쿼리를 작성한다.
                insertQuery = "INSERT INTO user (user_name, user_profileImage) VALUES (?, ?)"
                parmeters.append(userName)
                parmeters.append(userProfileImage)
                //4.쿼리를 작동한다.
                try db.executeUpdate(insertQuery, values: parmeters)
                parmeters.removeAll()
            }catch{
                self.fmdb.rollback()
                print("===== fetchPassportData() failure. =====")
                print("failed: \(error.localizedDescription)")
                print("========================================")
            }
        })
    }
    
    
    func updateUser(userName: String, userProfileImage: String) {
        var parameters = [Any]()
        var updateQuery: String = ""
        let fmdbQueue = FMDatabaseQueue(path: self.dbPath)
        
        fmdbQueue?.inTransaction({ (db, rollback) in
            do {
                updateQuery = "UPDATE user SET user_name = ?, user_profileImage = ? WHERE user_id = 1"
                parameters.append(userName)
                parameters.append(userProfileImage)
                try db.executeUpdate(updateQuery, values: parameters)
                parameters.removeAll()
            } catch {
                self.fmdb.rollback()
                print("===== fetchPassportData() failure. =====")
                print("failed: \(error.localizedDescription)")
                print("========================================")
            }
        })
    }
//    /*
//     함수명: updateData
//     기능: 특정 user table 을 수정한다.
//     작성일자: 2019.07.02
//     수정일자: 2019.07.09
//     */
//    func updateData(userId: String, userName: String?, userPassword: String?, userProfilePictureUrl: String?) {
//        //1. userId, userName, userProfile 을 입력받는다.
//        var parmeters = [Any]()
//        var updateQuery: String = ""
//        let fmdatabaseQueue = FMDatabaseQueue(path: self.dbPath)
//        
//        fmdatabaseQueue?.inTransaction({ (db, rollback) in
//            do{
//                //2.userName 이 nil 이 아니면, userId 컬럼을 수정한다.
//                if userName != nil {
//                    guard let userName = userName else {return}
//                    //2.1.userName 을 수정할 쿼리를 작성한다.
//                    updateQuery = "UPDATE user SET user_name = ? WHERE user_id = ?"
//                    parmeters.append(userName)
//                    parmeters.append(userId)
//                    //2.2.userName을 수정한다.
//                    try db.executeUpdate(updateQuery, values: parmeters)
//                    parmeters.removeAll()
//                    
//                //3.userPassword 이 nil 이 아니면, userPassword 컬럼을 수정한다.
//                } else if userPassword != nil {
//                    guard let userPassword = userPassword else {return}
//                    //3.1.userPassword 을 수정할 쿼리를 작성한다.
//                    updateQuery = "UPDATE user SET user_password = ? WHERE user_id = ?"
//                    parmeters.append(userPassword)
//                    parmeters.append(userId)
//                    //2.2.userPassword을 수정한다.
//                    try db.executeUpdate(updateQuery, values: parmeters)
//                    parmeters.removeAll()
//                    
//                //4.userProfilePictureUrl 이 nil 이 아니면, userProfilePictureUrl 컬럼을 수정한다.
//                } else if userProfilePictureUrl != nil {
//                    guard let userProfilePicture = userProfilePictureUrl else {return}
//                    //4.1.userProfilePicture 을 수정할 쿼리를 작성한다.
//                    updateQuery = "UPDATE user SET user_profilepicture = ? WHERE user_id = ?"
//                    parmeters.append(userProfilePicture)
//                    parmeters.append(userId)
//                    //4.2.userPassword을 수정한다.
//                    try db.executeUpdate(updateQuery, values: parmeters)
//                    parmeters.removeAll()
//                }
//            } catch {
//                rollback.pointee = true
//                print(error)
//            }
//            
//        })
//    }
    
    /*
     함수명: backupData
     기능: 지금 현재 상태의 user 객체를 Tree.db 에 넣는다.
     작성일자: 2019.07.17
     수정일자:
     */
    
    /*
     함수명: deleteData
     기능: 특정 user table 을 지우고, 그에 따른 모든 데이터를 지운다(회원탈퇴).
     작성일자: 2019.07.02
     수정일자: 2019.07.09
     */
    func deleteData(userId: String) {
        let paragmaQuery = "PRAGMA foreign_keys=on"
        let deleteQuery = "DELETE FROM user WHERE user_id = '\(userId)'"
        
        let fmdbQueue = FMDatabaseQueue(path: self.dbPath)
        
        fmdbQueue?.inTransaction({ (db, rollback) in
            do{
                try self.fmdb.executeQuery(paragmaQuery, values: nil)
                try self.fmdb.executeUpdate(deleteQuery, values: nil)
            } catch {
                self.fmdb.rollback()
                print("===== fetchPassportData() failure. =====")
                print("failed: \(error.localizedDescription)")
                print("========================================")
            }
        })
    }
    
    

    
}
