//
//  Image.swift
//  Tree
//
//  Created by Jae Ki Lee on 04/07/2019.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class DiaryPageImage {
    private var url: String = ""
    private var createdDate: Date = Date()
    private var image: UIImage?
    
    init() {
        self.url = ""
        self.createdDate = Date()
    }
    
    init(url: String, createdDate: String) {
        //1.imageWidth, imageHeight, imageCreateDate, imageUrl 을 입력받는다.
        //2.imageUrl 을 Url type 으로 변경한다.
        //3.imageUrl 을 UIImage type 으로 변경한다.
        //4.imageWidth, imageHeight, imageCreateDate, imageUrl, image 를 채운다.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        guard let diaryDate = dateFormatter.date(from: createdDate) else {return}
        
        self.url = url
        self.createdDate = diaryDate
        self.image = ConvertingDataAndImage().convertingFromUrlToImage(uniqueId: url)
        
    }
    
    func getUrl() -> String {
        return self.url
    }
    
    func setUrl(url: String) {
        self.url = url
        self.image = ConvertingDataAndImage().convertingFromUrlToImage(uniqueId: url)
    }
    
    func getCreatedDate() -> Date {
        return self.createdDate
    }
    
    func setCreateDate(date: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        guard let diaryDate = dateFormatter.date(from: date) else {return}
        
        self.createdDate = diaryDate
    }
    
    func getImage() -> UIImage? {
        return self.image
    }
    
    /*
     함수명: editImageUrl
     기능: ImageUrl 을 변경한다.
     작성일자: 2019.07.15
     수정일자:
     */
    func editImageUrl(url: String) -> String? {
        self.url = url
        return url
    }
    
    /*
     함수명: editCreateDate
     기능: ImageCreateDate 을 변경한다.
     작성일자: 2019.07.15
     수정일자:
     */
    func editCreateDate(date: Date) -> Date? {
        self.createdDate = date
        return createdDate
    }
    
}
