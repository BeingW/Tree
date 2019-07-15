//
//  DiaryPageDAO.swift
//  Tree
//
//  Created by Jae Ki Lee on 15/07/2019.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class DiaryPageDAO: FMDBHelper {
    
    init() {
        super.init(fileName: "Tree", identifier: "db")
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
     함수명: makeDiaryPageId
     기능: 중복되지 않는 diarypage_id 를 만들어 반환한다.
     작성일자: 2019.07.15
     수정일자:
     */
    func makeDiaryPageId() -> String {
        //1. 변수들을 초기화 한다.
        var number = 0
        var presentNumber = 0
        var previousNumber = 0
        var idNumber: String
        var diarypageId: String = ""
        
        do{
            let selectQuery = "SELECT diarypage_id FROM user_diarypage_relation"
            let resultSet = try self.fmdb.executeQuery(selectQuery, values: nil)
            //2.diarypage_id 가 있다면 끝까지 반복한다.
            while resultSet.next() {
                //2.1.diarypage_id 를 뽑아낸다.
                var selectedDiarypageId = resultSet.string(forColumn: "diarypage_id")!
                //2.2.diarypage_id 에서 "D"를 지운다.
                selectedDiarypageId.removeFirst()
                //2.3."D"를 지운 diarypage_id 를 정수화 하여, presnetNumber 에 넣는다.
                presentNumber = Int(selectedDiarypageId)!
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
            
            //7.number 앞에 'D'를 붙여 diarypageId 를 만든다.
            diarypageId = "D" + idNumber
            
        } catch let error as NSError {
            self.fmdb.rollback()
            print("===== fetchPassportData() failure. =====")
            print("failed: \(error.localizedDescription)")
            print("========================================")
        }
        
        //8. 반환한다.
        return diarypageId
    }
    
    /*
     함수명: makeImageId
     기능: 중복되지 않는 image_id 를 만들어 반환한다.
     작성일자: 2019.07.15
     수정일자:
     */
    func makeImageId() -> String {
        //1. 변수들을 초기화 한다.
        var number = 0
        var presentNumber = 0
        var previousNumber = 0
        var idNumber: String
        var imageId: String = ""
        
        do{
            let selectQuery = "SELECT image_id FROM diarypage_images_relation"
            let resultSet = try self.fmdb.executeQuery(selectQuery, values: nil)
            //2.image_id 가 있다면 끝까지 반복한다.
            while resultSet.next() {
                //2.1.image_id 를 뽑아낸다.
                var selectedImageId = resultSet.string(forColumn: "image_id")!
                //2.2.image_id 에서 "I"를 지운다.
                selectedImageId.removeFirst()
                //2.3."I"를 지운 image_id 를 정수화 하여, presnetNumber 에 넣는다.
                presentNumber = Int(selectedImageId)!
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
            
            //7.number 앞에 'I'를 붙여 imageId 를 만든다.
            imageId = "I" + idNumber
            
        } catch let error as NSError {
            self.fmdb.rollback()
            print("===== fetchPassportData() failure. =====")
            print("failed: \(error.localizedDescription)")
            print("========================================")
        }
        
        //8. 반환한다.
        return imageId
    }
    
    /*
     함수명: insertData
     기능: 입력한 diaryPage 를 diaryPage와 관련된 Table에 넣는다.
     작성일자: 2019.07.15
     수정일자:
     */
    func insertData(diaryPage: DiaryPage) {
        //1.DiaryPage 객체를 입력받는다.
        var selectQuery: String = ""
        var insertQuery: String = ""
        var parmeters = [Any]()
        //dbPath 를 넣어 FMDatabaseQueue 객체를 생성한다.
        let fmdbQueue = FMDatabaseQueue(path: self.dbPath)
        fmdbQueue?.inTransaction({ (db, rollback) in
            do {
                //user_id를 찾는다.
                selectQuery = "SELECT user_id FROM user"
                let resultSet = try db.executeQuery(selectQuery, values: nil)
                guard let userId = resultSet.string(forColumn: "user_id") else {return}
                //2.diarypage_id 를 만든다.
                let diarypageId = makeDiaryPageId()
                //3.user_diarypage_relation 테이블에 데이터를 넣는다.
                insertQuery = "INSERT INTO user_diarypage_relation (diarypage_id, user_id) VALUES (?, ?)"
                parmeters.append(diarypageId)
                parmeters.append(userId)
                try db.executeUpdate(insertQuery, values: parmeters)
                parmeters.removeAll()
                //4.diarypage 테이블에 데이터를 넣는다.
                guard let diaryDate = diaryPage.getDate() else {return}
                let diaryDateString = DateFormatter().string(from: diaryDate)
                insertQuery = "INSERT INTO diarypage (diarypage_id, diary_date) VALUES (?, ?)"
                parmeters.append(diarypageId)
                parmeters.append(diaryDateString)
                try db.executeUpdate(insertQuery, values: parmeters)
                parmeters.removeAll()
                //5.title이 있으면, diarypage_title 테이블에 데이터를 넣는다.
                if let diarypageTitle = diaryPage.getTitle(), diarypageTitle != "" {
                    insertQuery = "INSERT INTO diarypage_title (diarypage_id, diarypage_title) VALUES (?, ?)"
                    parmeters.append(diarypageId)
                    parmeters.append(diarypageTitle)
                    try db.executeUpdate(insertQuery, values: parmeters)
                    parmeters.removeAll()
                }
                //6.text이 있으면, diarypage_text 테이블에 데이터를 넣는다.
                if let diarypageText = diaryPage.getText(), diarypageText != "" {
                    insertQuery = "INSERT INTO diarypage_text (diarypage_id, diarypage_text) VALUES (?, ?)"
                    parmeters.append(diarypageId)
                    parmeters.append(diarypageText)
                    try db.executeUpdate(insertQuery, values: parmeters)
                    parmeters.removeAll()
                }
                //7.image이 있으면.
                if diaryPage.getImageAt(index: 0) != nil {
                    guard let postImage = diaryPage.getImageAt(index: 0) else {return}
                    //7.1.image_id를 만든다.
                    let imageId = makeImageId()
    
                    //7.2.diary_images_relation 테이블에 데이터를 넣는다.
                    insertQuery = "INSERT INTO diarypage_images_relation (image_id, diarypage_id) VALUES (?, ?)"
                    parmeters.append(imageId)
                    parmeters.append(diarypageId)
                    try db.executeUpdate(insertQuery, values: parmeters)
                    parmeters.removeAll()
                    
                    //7.3.images 테이블에 데이터를 넣는다.
                    insertQuery = "INSERT INTO images (image_id, image_url, image_width, image_height, image_createdDate) VALUES (?, ?, ?, ?, ?)"
                    guard let imageUrl = postImage.getUrl() else {return}
                    guard let imageWidth = postImage.getWidth() else {return}
                    let imageWidthString = String(imageWidth)
                    guard let imageHeight = postImage.getHeight() else {return}
                    let imageHeightString = String(imageHeight)
                    guard let imageCreatedDate = postImage.getCreatedDate() else {return}
                    let imageCreatedDateString = DateFormatter().string(from: imageCreatedDate)
                    
                    parmeters.append(imageId)
                    parmeters.append(imageUrl)
                    parmeters.append(imageWidthString)
                    parmeters.append(imageHeightString)
                    parmeters.append(imageCreatedDateString)
                    try db.executeUpdate(insertQuery, values: parmeters)
                    parmeters.removeAll()
                }
                
            }catch{
                rollback.pointee = true
                print(error)
            }
        })
        
        
    }
    
    /*
     함수명: updateData
     기능: 특정 user table 을 수정한다.
     작성일자: 2019.07.15
     수정일자:
     */
    func updateData(diaryPage: DiaryPage) {
        //1.Diary 객체를 입력받는다.
        var parmeters = [Any]()
        var selectQuery: String = ""
        var updateQuery: String = ""
        let fmdatabaseQueue = FMDatabaseQueue(path: self.dbPath)
        
        fmdatabaseQueue?.inTransaction({ (db, rollback) in
            do{
                guard let diaryPageTitle = diaryPage.getTitle() else {return}
                guard let diaryPageText = diaryPage.getText() else {return}
                
                //2.diarypage_id 를 찾는다.
                guard let selectedDiarypageDate = diaryPage.getDate() else {return}
                let dateString = DateFormatter().string(from: selectedDiarypageDate)
                selectQuery = "SELECT diarypage_id FROM diarypage WHERE diary_date = \(dateString)"
                let diarypageResultSet = try db.executeQuery(selectQuery, values: nil)
                guard let diarypage_id = diarypageResultSet.string(forColumn: "diarypage_id") else {return}
                
                //3.diarypage_id 에 따른 diarypage_title 테이블을 수정한다.
                updateQuery = "UPDATE diarypage_title SET diarypage_title = ? WHERE diarypage_id = ?"
                parmeters.append(diaryPageTitle)
                parmeters.append(diarypage_id)
                try db.executeUpdate(updateQuery, values: parmeters)
                parmeters.removeAll()
                
                //4.diarypage_id 에 따른 diarypage_text 테이블을 수정한다.
                updateQuery = "UPDATE diarypage_text SET diarypage_text = ? WHERE diarypage_id = ?"
                parmeters.append(diaryPageText)
                parmeters.append(diarypage_id)
                try db.executeUpdate(updateQuery, values: parmeters)
                parmeters.removeAll()
                
                //5.diarypage 객체에 image가 있다면.
                if diaryPage.getImageAt(index: 0) != nil {
                    //5.1.diarypage_id 에 따른 image_id를 찾는다.
                    selectQuery = "SELECT image_id FROM diarypage_images_relation WHERE diarypage_id = \(diarypage_id)"
                    let imageResultSet = try db.executeQuery(selectQuery, values: nil)
                    guard let imageId = diarypageResultSet.string(forColumn: "image_id") else {return}
                    
                    //5.2.image_id 에 따른 images 테이블을 수정한다.
                    guard let image = diaryPage.getImageAt(index: 0) else {return}
                    guard let imageUrl = image.getUrl() else {return}
                    guard let imageWidth = image.getWidth() else {return}
                    let imageWidthString = String(imageWidth)
                    guard let imageHeight = image.getHeight() else {return}
                    let imageHeightString = String(imageHeight)
                    guard let imageCreatedDate = image.getCreatedDate() else {return}
                    let imageCreatedDateString = DateFormatter().string(from: imageCreatedDate)
                    
                    updateQuery = "UPDATE images SET image_url = ?, image_width = ?, image_height = ?, image_createdDate = ?, WHERE image_id = ?"
                    
                    parmeters.append(imageUrl)
                    parmeters.append(imageWidthString)
                    parmeters.append(imageHeightString)
                    parmeters.append(imageCreatedDateString)
                    parmeters.append(imageId)
                    try db.executeUpdate(updateQuery, values: parmeters)
                    parmeters.removeAll()
                }
                
            } catch {
                rollback.pointee = true
                print(error)
            }
            
        })
    }
    
    /*
     함수명: deleteData
     기능: 특정 다이어리 페이지를 지운다.
     작성일자: 2019.07.15
     수정일자:
     */
    func deleteData(diaryPage: DiaryPage) {
        //1.diaryPage를 입력받는다.
        //dbPath 를 넣어 FMDatabaseQueue 객체를 생성한다.
        let fmdbQueue = FMDatabaseQueue(path: self.dbPath)
        fmdbQueue?.inTransaction({ (db, rollback) in
            do {
                //2.입력받은 diaryPage의 diary_date attribute 를 이용해 diarypage 테이블에서 diarypage_id 를 찾는다.
                guard let selectedDiarypageDate = diaryPage.getDate() else {return}
                let dateString = DateFormatter().string(from: selectedDiarypageDate)
                let selectQuery = "SELECT diarypage_id FROM diarypage WHERE diary_date = \(dateString)"
                let diarypageResultSet = try db.executeQuery(selectQuery, values: nil)
                guard let diarypage_id = diarypageResultSet.string(forColumn: "diarypage_id") else {return}
                
                //3.pragma 쿼리를 실행한다.
                let paragmaQuery = "PRAGMA foreign_keys=on"
                try db.executeUpdate(paragmaQuery, values: nil)
                
                //4.diarypage_id 에 관한 row를 user_diarypage_relation table에서 지운다.
                let deleteQuery = "DELETE FROM user_diarypage_relation WHERE diarypage_id = \(diarypage_id)"
                try db.executeUpdate(deleteQuery, values: nil)
                
            }catch{
                rollback.pointee = true
                print(error)
            }
        })
        
    }
    }

    

