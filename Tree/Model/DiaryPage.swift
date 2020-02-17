//
//  DiaryPage.swift
//  Tree
//
//  Created by Jae Ki Lee on 5/29/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import Foundation

class DiaryPage {
    private var title: String = ""
    private var date: Date = Date()
    private var text: String = ""
    var images: [DiaryPageImage]? = nil
    
    init() {
        self.title = ""
        self.date = Date()
        self.text = ""
        self.images = []
    }
    
    init(title: String, date: Date, text: String, images: [DiaryPageImage]?) {
        self.title = title
        self.date = date
        self.text = text
        self.images = images
    }
    
    init(title: String?, date: String, text: String?, images: [DiaryPageImage]?) {
        //1.tile, date, text, image Array 를 optional type 으로 입력받는다.
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        guard let diaryDate = dateFormatter.date(from: date) else {return}
        
        //2.입력받은 값들이 optional 값이면,  String = “”, image = 빈 배열 로 채운다.
        //optional 타입이 아니라면 unwrapping 하여 값을 채운다.
        self.title = title ?? ""
        self.date = diaryDate
        self.text = text ?? ""
        self.images = images
        
    }

    func getTitle() -> String {
        return title
    }
    
    func setTitle(title: String) {
        self.title = title
    }

    func getDate() -> Date {
        return self.date
    }
    
    func setDate(date: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        guard let diaryDate = dateFormatter.date(from: date) else {return}
        
        self.date = diaryDate
    }

    func getText() -> String {
        return self.text
    }
    
    func setText(text: String) {
        self.text = text
    }
    
    func getDiaryPageImages() -> [DiaryPageImage]? {
        return self.images
    }
    
    func setDiaryPageImages(diaryPageImages: [DiaryPageImage]) {
        self.images = diaryPageImages
    }
    
    
//
////    func getImageAt(index: Int) -> Image? {
////
////        let image = self.images[index]
////
////        return image
////    }
//
////    func getImages() -> [Image]? {
////        return images
////    }
//
//
//    //지우고 addImages 하나로 통일
//    /*
//     함수명: addImage
//     기능: 다이어리에 이미지를 넣는다.
//     작성일자: 2019.07.09
//     수정일자:
//     */
////    func addImage(image: Image) {
////        if self.images != nil {
////            self.images?.append(image)
////        }
////    }
//
//    /*
//     함수명: addImages
//     기능: 다이어리페이지에 image 들을 넣습니다.
//     작성일자: 2019.07.25
//     수정일자:
//     */
////    func addImages(images: [Image]) {
////        //1.image array 를 입력받는다.
////        var i = 0
////        //2.images의 배열의 갯수만큼 반복한다.
////        while images.count > i {
////            //2.1.images 에 image를 append 한다.
////            self.images?.append(images[i])
////            i += 1
////        }
////    }
//
//    /*
//     함수명: editTitle
//     기능: 다이어리 제목을 수정한다.
//     작성일자: 2019.07.09
//     수정일자:
//     */
//    func editTitle(title: String) -> String? {
//        self.title = title
//        return self.title
//    }
//
//
//    /*
//     함수명: editText
//     기능: 다이어리 글을 수정한다.
//     작성일자: 2019.07.09
//     수정일자:
//     */
//    func editText(text: String) -> String? {
//        self.text = text
//        return self.text
//    }
//
//    /*
//     함수명: editImages
//     기능: 기존의 Image들을 지우고 새로운 Image를 넣는다.
//     작성일자: 2019.07.25
//     수정일자:
//     */
////    func editImages(images: [Image]) {
////        //1.image Array를 입력받는다.
////        var i = 0
////        //2.기존의 image 들을 모두 지운다.
////        self.images?.removeAll()
////        //3.images의 배열의 갯수만큼 반복한다.
////        while images.count > i {
////            //3.1.images에 append 한다.
////            self.images?.append(images[i])
////            i += 1
////        }
////    }
//
//    /*
//     함수명: deleteImages
//     기능: 입력받은 번째의 image들을 지웁니다.
//     작성일자: 2019.07.25
//     수정일자:
//     */
////    func deleteImages(indexs: [Int]) {
////        //1.indexes 를 입력받는다.
////        //2.i=0 으로 초기화 한다.
////        var i = 0
////        //3.i가 배열의 크기보다 작을 때 까지 반복한다.
////        while indexs.count > i {
////            //3.1.indexs의 i 번 째 수의 Image를 지운다.
////            let index = indexs[i]
////            self.images?.remove(at: index)
////            //3.2.i 를 증가시킨다.
////            i += 1
////        }
////    }
//
//    /*
//     함수명: deleteAllImages
//     기능: 모든 이미지를 지운다.
//     작성일자: 2019.07.09
//     수정일자:
//     */
////    func deleteAllImages(){
////        if self.images != nil {
////            self.images?.removeAll()
////        }
////    }
//}
//
//extension DiaryPage {
//    static func == (leftDiaryPage: DiaryPage, rigthDiaryPage: DiaryPage) -> Bool {
//
//        var isIqual: Bool
//
//        if leftDiaryPage.date == rigthDiaryPage.date {
//            isIqual = true
//        } else {
//            isIqual = false
//        }
//
//        return isIqual
//    }
}
