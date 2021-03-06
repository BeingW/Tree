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
            let selectQuery = "SELECT diarypage_id FROM diarypage"
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
            let selectQuery = "SELECT image_id FROM diarypage_image"
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
     함수명: fetchDiaryPage
     기능: DB 에서 diarypage table 과 관계된 모든 데이터를 가져와 DiaryPage 로 맵핑한 후 DiaryPage 배열로 반환한다.
     작성일자: 2020.02.07
     수정일자:
     */
    
    func fetchDiaryPage() -> [DiaryPage]? {
        var selectQuery: String = ""
        var diaryPageRS = FMResultSet()
        var diaryImageRS = FMResultSet()
        var imageRS = FMResultSet()
        var parameters = [Any]()
        
        var diaryPages = [DiaryPage]()
        var diaryPage = DiaryPage()
        var diaryPageImage = DiaryPageImage()
        var diaryPageImages = [DiaryPageImage]()
        
        let fmdbQueue = FMDatabaseQueue(path: self.dbPath)
        fmdbQueue?.inTransaction({ (db, rollBack) in
            do {
                //1.DB에서 diarypage table 끝까지 반복한다.
                selectQuery = "SELECT * FROM diarypage"
                try diaryPageRS = db.executeQuery(selectQuery, values: nil)
                while diaryPageRS.next() {
                    //1.1.diarypage_id, diarypage_title, diary_date, diarypage_text 를 가져온다.
                    guard let diarypageId = diaryPageRS.string(forColumn: "diarypage_id") else {return}
                    let diarypageTitle = diaryPageRS.string(forColumn: "diarypage_title") ?? ""
                    let diarypageDate = diaryPageRS.string(forColumn: "diarypage_date") ?? ""
                    let diarypageText = diaryPageRS.string(forColumn: "diarypage_text") ?? ""
                    
                    //1.2.diarypage_id 를 이용하여 diarypage_id 와 같은 diarypage_image table 을 가져온다.
                    selectQuery = "SELECT image_id FROM diarypage_image WHERE diarypage_id=?"
                    parameters.append(diarypageId)
                    try diaryImageRS = db.executeQuery(selectQuery, values: parameters)
                    parameters.removeAll()
                    //1.3.diarypage_image table 끝까지 반복한다.
                    diaryPageImages.removeAll()
                    while diaryImageRS.next() {
                        //1.3.1.image_id 를 가져온다.
                        guard let imageId = diaryImageRS.string(forColumn: "image_id") else {return}
                        //1.3.1.1.image_id 에 대한 image table 의 데이터를 가져온다.
                        selectQuery = "SELECT * FROM image WHERE image_id=?"
                        parameters.append(imageId)
                        try imageRS = db.executeQuery(selectQuery, values: parameters)
                        parameters.removeAll()
                        
                        while imageRS.next() {
                            let imageUrl = imageRS.string(forColumn: "image_url") ?? ""
                            let imageCreateDate = imageRS.string(forColumn: "image_createDate") ?? ""
                            diaryPageImage = DiaryPageImage(url: imageUrl, createdDate: imageCreateDate)
                            diaryPageImages.append(diaryPageImage)
                        }
                        
                    }
                    //1.4.DiaryPage 객체를 만든다.
                    diaryPage = DiaryPage(title: diarypageTitle, date: diarypageDate, text: diarypageText, images: diaryPageImages)
                    diaryPages.append(diaryPage)
                    
                }
            } catch {
                self.fmdb.rollback()
                print("===== fetchPassportData() failure. =====")
                print("failed: \(error.localizedDescription)")
                print("========================================")
            }
        })
        
        return diaryPages
        
    }
    
    /*
     함수명: insertDiaryPage
     기능: DiaryPage 객체를 매개변수로 받아 DB 의 diarypage table 과 관계된 table 들을 채운다.
     작성일자: 2020.02.10
     수정일자:
     */
    func insertDiaryPage(diaryPage: DiaryPage) {
        //1.DiaryPage 를 읽어온다.
        var insertQuery: String = ""
        var selectQuery: String = ""
        var parameters = [Any]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateString = dateFormatter.string(from: diaryPage.getDate())
        
        let fmdbQueue = FMDatabaseQueue(path: self.dbPath)
        
        fmdbQueue?.inTransaction({ (db, rollback) in
            //2.DiaryPage title, date, text 데이터를 DB 의 diarypage table 에 넣는다.
            do {
                insertQuery = "INSERT INTO diarypage (diarypage_title, diarypage_date, diarypage_text) VALUES (?, ?, ?)"
                parameters.append(diaryPage.getTitle())
                parameters.append(dateString)
                parameters.append(diaryPage.getText())
                try db.executeUpdate(insertQuery, values: parameters)
                parameters.removeAll()
                
                //3.DiaryPage 의 images 가 있다면.
                var diaryPageId: String = ""
                if let diayPageImages = diaryPage.images, diayPageImages.count != 0  {
                    //3.1.DB 의 diarypage table 에서 diarypage_id 데이터를 가져온다.
                    selectQuery = "SELECT diarypage_id FROM diarypage WHERE diarypage_date=?"
                    parameters.append(dateString)
                    let diaryPageRS = try db.executeQuery(selectQuery, values: parameters)
                    parameters.removeAll()
                    
                    if diaryPageRS.next() {
                        diaryPageId = diaryPageRS.string(forColumn: "diarypage_id") ?? "0"
                    }
                    
                    //3.2.DiaryPage 의 images 의 갯수만큼 반복한다.
                    diayPageImages.forEach({ (diaryPageImage) in
                        //3.2.1.DB 의 diarypage_image table 에 diarypage_id 에 대한 image_id row 를 만든다.
                        do {
                            insertQuery = "INSERT INTO diarypage_image (diarypage_id) VALUES (?)"
                            parameters.append(diaryPageId)
                            try db.executeUpdate(insertQuery, values: parameters)
                            parameters.removeAll()
                            //3.2.2.DB 의 image table 에 image_id 에 해당 diarpageImage 의 데이터를 맵핑한다.
                            insertQuery = "INSERT INTO image(image_createDate, image_url) VALUES (?, ?)"
                            let imageCreateDateString = dateFormatter.string(from: diaryPageImage.getCreatedDate())
                            parameters.append(imageCreateDateString)
                            parameters.append(diaryPageImage.getUrl())
                            try db.executeUpdate(insertQuery, values: parameters)
                            parameters.removeAll()
                        } catch {
                            self.fmdb.rollback()
                            print("===== fetchPassportData() failure. =====")
                            print("failed: \(error.localizedDescription)")
                            print("========================================")
                        }
                    })
                }
            } catch {
                self.fmdb.rollback()
                print("===== fetchPassportData() failure. =====")
                print("failed: \(error.localizedDescription)")
                print("========================================")
            }
        })
        
    }
    
    func deleteDiaryPage(diaryPageDate: Date) {
        //1.특정 diaryPage 의 날짜를 입력 받는다.
        //2.날짜를 이용하여 diarypage table 의 찾고자 하는 데이터를 지운다.
        var diaryPageId: String = ""
        var imageIds = [""]
        var selectQuery: String = ""
        var deleteQuery: String = ""
        
        //dbPath 를 넣어 FMDatabaseQueue 객체를 생성한다.
        let fmdbQueue = FMDatabaseQueue(path: self.dbPath)
        fmdbQueue?.inTransaction({ (db, rollback) in
            do {
                //입력받은 diaryPage의 diary_date attribute 를 이용해 diarypage 테이블에서 diarypage_id 를 찾는다.
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                let dateString = dateFormatter.string(from: diaryPageDate)
                //1.diarypage table 삭제
                selectQuery = "SELECT diarypage_id FROM diarypage WHERE diarypage_date = '\(dateString)'"
                let diarypageResultSet = try db.executeQuery(selectQuery, values: nil)
                if diarypageResultSet.next() {
                    diaryPageId = diarypageResultSet.string(forColumn: "diarypage_id") ?? ""
                }
                //diarypage_id 에 관한 row를 user_diarypage_relation table에서 지운다.
                deleteQuery = "DELETE FROM diarypage WHERE diarypage_id = '\(diaryPageId)'"
                try db.executeUpdate(deleteQuery, values: nil)
                
                //2.diarypage_id 에 대한 diarypage_image table 에 대한 data 삭제
                selectQuery = "SELECT image_id FROM diarypage_image WHERE diarypage_id = '\(diaryPageId)'"
                let diaryImageRS = try db.executeQuery(selectQuery, values: nil)
                while diaryImageRS.next() {
                    imageIds.append(diaryImageRS.string(forColumn: "image_id") ?? "")
                }
                
                deleteQuery = "DELETE FROM diarypage_image WHERE diarypage_id = '\(diaryPageId)'"
                try db.executeUpdate(deleteQuery, values: nil)
    
                //3.image_id에 대한 image table 삭제
                for imageId in imageIds {
                    deleteQuery = "DELETE FROM image WHERE image_id = '\(imageId)'"
                    try db.executeUpdate(deleteQuery, values: nil)
                }
                
            }catch{
                self.fmdb.rollback()
                print("===== fetchPassportData() failure. =====")
                print("failed: \(error.localizedDescription)")
                print("========================================")
            }
        })
    }
    
    func updateDiaryPage(diaryPage: DiaryPage) {
        //1.DiaryPage 객체를 입력받는다.
        var parameters = [Any]()
        var selectQuery: String = ""
        var insertQuery: String = ""
        var deleteQuery: String = ""
        var updateQuery: String = ""
        
        var diaryPageId: String = ""
        var imageIds = [""]
        var imageId: String = ""
        
        let fmdatabaseQueue = FMDatabaseQueue(path: self.dbPath)
        fmdatabaseQueue?.inTransaction({ (db, rollback) in
            do{
                //Delete
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                let dateString = dateFormatter.string(from: diaryPage.getDate())
                //1.diarypage table 삭제
                selectQuery = "SELECT diarypage_id FROM diarypage WHERE diarypage_date = '\(dateString)'"
                let diarypageResultSet = try db.executeQuery(selectQuery, values: nil)
                if diarypageResultSet.next() {
                    diaryPageId = diarypageResultSet.string(forColumn: "diarypage_id") ?? ""
                }
                //diarypage_id 에 관한 row를 user_diarypage_relation table에서 지운다.
                deleteQuery = "DELETE FROM diarypage WHERE diarypage_id = '\(diaryPageId)'"
                try db.executeUpdate(deleteQuery, values: nil)
                
                //2.diarypage_id 에 대한 diarypage_image table 에 대한 data 삭제
                selectQuery = "SELECT image_id FROM diarypage_image WHERE diarypage_id = '\(diaryPageId)'"
                let diaryImageRS = try db.executeQuery(selectQuery, values: nil)
                while diaryImageRS.next() {
                    imageIds.append(diaryImageRS.string(forColumn: "image_id") ?? "")
                }
                
                deleteQuery = "DELETE FROM diarypage_image WHERE diarypage_id = '\(diaryPageId)'"
                try db.executeUpdate(deleteQuery, values: nil)
                
                //3.image_id에 대한 image table 삭제
                for imageId in imageIds {
                    deleteQuery = "DELETE FROM image WHERE image_id = '\(imageId)'"
                    try db.executeUpdate(deleteQuery, values: nil)
                }
                
                //Insert
                insertQuery = "INSERT INTO diarypage (diarypage_title, diarypage_date, diarypage_text) VALUES (?, ?, ?)"
                parameters.append(diaryPage.getTitle())
                parameters.append(dateString)
                parameters.append(diaryPage.getText())
                try db.executeUpdate(insertQuery, values: parameters)
                parameters.removeAll()
                
                if let diayPageImages = diaryPage.images, diayPageImages.count != 0  {
                    //3.1.DB 의 diarypage table 에서 diarypage_id 데이터를 가져온다.
                    selectQuery = "SELECT diarypage_id FROM diarypage WHERE diarypage_date=?"
                    parameters.append(dateString)
                    let diaryPageRS = try db.executeQuery(selectQuery, values: parameters)
                    parameters.removeAll()
                    
                    if diaryPageRS.next() {
                        diaryPageId = diaryPageRS.string(forColumn: "diarypage_id") ?? "0"
                    }
                    
                    //3.2.DiaryPage 의 images 의 갯수만큼 반복한다.
                    diayPageImages.forEach({ (diaryPageImage) in
                        //3.2.1.DB 의 diarypage_image table 에 diarypage_id 에 대한 image_id row 를 만든다.
                        do {
                            insertQuery = "INSERT INTO diarypage_image (diarypage_id) VALUES (?)"
                            parameters.append(diaryPageId)
                            try db.executeUpdate(insertQuery, values: parameters)
                            parameters.removeAll()
                            //3.2.2.DB 의 image table 에 image_id 에 해당 diarpageImage 의 데이터를 맵핑한다.
                            insertQuery = "INSERT INTO image(image_createDate, image_url) VALUES (?, ?)"
                            let imageCreateDateString = dateFormatter.string(from: diaryPageImage.getCreatedDate())
                            parameters.append(imageCreateDateString)
                            parameters.append(diaryPageImage.getUrl())
                            try db.executeUpdate(insertQuery, values: parameters)
                            parameters.removeAll()
                        } catch {
                            self.fmdb.rollback()
                            print("===== fetchPassportData() failure. =====")
                            print("failed: \(error.localizedDescription)")
                            print("========================================")
                        }
                    })
                }
                
            } catch {
                rollback.pointee = true
                print(error)
            }
            
        })
    }

}

    


