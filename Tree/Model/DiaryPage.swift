//
//  DiaryPage.swift
//  Tree
//
//  Created by Jae Ki Lee on 5/29/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import Foundation

class DiaryPage {
    private var title: String?
    private var date: Date?
    private var text: String?
    private var images: [Image]?
    
    init() {
        self.title = ""
        self.date = Date()
        self.text = ""
        self.images = []
    }
    
    init(title: String?, text: String?, images: [Image]?) {
        self.title = title ?? ""
        self.text = text ?? ""
        self.images = images
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let today = Date()
        let dateString = dateFormatter.string(from:today)
        guard let dateWithFormatter = dateFormatter.date(from: dateString) else {return}
        
        self.date = dateWithFormatter
    }
    
    init(title: String?, date: String?, text: String?, images: [Image]?) {
        guard let date = date else {return}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        guard let diaryDate = dateFormatter.date(from: date) else {return}
        
        self.title = title ?? ""
        self.date = diaryDate
        self.text = text ?? ""
        self.images = images
    }
    
    func getTitle() -> String? {
        return title
    }
    
    func getDate() -> Date? {
        return self.date
    }
    
    func getText() -> String? {
        return self.text
    }
    
    func getImageAt(index: Int) -> Image? {
        
        let image = self.images?[index]
        
        return image
    }
    
    func getImages() -> [Image]? {
        return images
    }
    
    /*
     함수명: editTitle
     기능: 다이어리 제목을 수정한다.
     작성일자: 2019.07.09
     수정일자:
     */
    func editTitle(title: String) -> String? {
        self.title = title
        return self.title
    }
    

    /*
     함수명: editText
     기능: 다이어리 글을 수정한다.
     작성일자: 2019.07.09
     수정일자:
     */
    func editText(text: String) -> String? {
        self.text = text
        return self.text
    }
    
    /*
     함수명: editImageAt
     기능: 특정 Image 를 수정한다.
     작성일자: 2019.07.09
     수정일자:
     */
    func editImageAt(index: Int, image: Image) -> Image? {
        
        if self.images != nil {
            self.images?.remove(at: index)
            self.images?.insert(image, at: index)
        }
        
        return images?[index]
    }
    
    /*
     함수명: addImage
     기능: 다이어리에 이미지를 넣는다.
     작성일자: 2019.07.09
     수정일자:
     */
    func addImage(image: Image) {
        if self.images != nil {
            self.images?.append(image)
        }
    }
    
    /*
     함수명: deleteImageAt
     기능: 특정 이미지를 지운다.
     작성일자: 2019.07.09
     수정일자:
     */
    func deleteImageAt(index: Int) {
        if self.images != nil {
            self.images?.remove(at: index)
        }
    }
    
    /*
     함수명: deleteAllImages
     기능: 모든 이미지를 지운다.
     작성일자: 2019.07.09
     수정일자:
     */
    func deleteAllImages(){
        if self.images != nil {
            self.images?.removeAll()
        }
    }
}

extension DiaryPage {
    static func == (leftDiaryPage: DiaryPage, rigthDiaryPage: DiaryPage) -> Bool {
        
        var isIqual: Bool
        
        if leftDiaryPage.date == rigthDiaryPage.date {
            isIqual = true
        } else {
            isIqual = false
        }
        
        return isIqual
    }
}
