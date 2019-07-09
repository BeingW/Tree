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
    private var date: String
    private var text: String?
    private var images: [Image?]
    
<<<<<<< HEAD
    init(title: String?, contents: String?, images: [Image?]) {
        self.title = title ?? ""
        self.text = contents ?? ""
=======
    init(title: String?, text: String?, images: [Image?]) {
        self.title = title ?? ""
        self.text = text ?? ""
>>>>>>> working
        self.images = images 
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd, hh:mm:ss"
        let today = NSDate()
        let dateString = dateFormatter.string(from: today as Date)
        self.date = dateString
    }
    
    func getTitle() -> String? {
<<<<<<< HEAD
        return self.title
=======
        return title
>>>>>>> working
    }
    
    func getDate() -> String? {
        return self.date
    }
    
    func getText() -> String? {
<<<<<<< HEAD
        return self.text
    }
    
    func getImageAt(index: Int) -> Image? {
        return self.images[index]
=======
        return text
    }
    
    func getImageAt(index: Int) -> Image? {
        
        return images[index]
>>>>>>> working
    }
    
    func getImages() -> [Image?] {
        return images
    }
    
<<<<<<< HEAD
=======
    /*
     함수명: editTitle
     기능: 다이어리 제목을 수정한다.
     작성일자: 2019.07.09
     수정일자:
     */
>>>>>>> working
    func editTitle(title: String) -> String? {
        self.title = title
        return self.title
    }
    
<<<<<<< HEAD
=======
    /*
     함수명: editTitle
     기능: 다이어리 글을 수정한다.
     작성일자: 2019.07.09
     수정일자:
     */
>>>>>>> working
    func editText(text: String) -> String? {
        self.text = text
        return self.text
    }
    
<<<<<<< HEAD
    func deleteImageAt(index: Int){
=======
    /*
     함수명: editImageAt
     기능: 특정 Image 를 수정한다.
     작성일자: 2019.07.09
     수정일자:
     */
    func editImageAt(index: Int, image: Image) -> Image? {
        self.images.remove(at: index)
        self.images.insert(image, at: index)
        
        return images[index]
    }
    
    /*
     함수명: deleteImageAt
     기능: 특정 이미지를 지운다.
     작성일자: 2019.07.09
     수정일자:
     */
    func deleteImageAt(index: Int) {
>>>>>>> working
        self.images.remove(at: index)
    }
    
    /*
     함수명: deleteAllImages
     기능: 모든 이미지를 지운다.
     작성일자: 2019.07.09
     수정일자:
     */
    func deleteAllImages(){
        self.images.removeAll()
    }
<<<<<<< HEAD
    
=======
>>>>>>> working
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
