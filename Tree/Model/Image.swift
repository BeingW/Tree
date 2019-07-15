//
//  Image.swift
//  Tree
//
//  Created by Jae Ki Lee on 04/07/2019.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import UIKit

class Image {
    private var url: String?
    private var width: Int?
    private var height: Int?
    private var createdDate: Date?
    
    init(url: String, width: Int, height: Int, createdDate: Date) {
        self.url = url
        self.width = width
        self.height = height
        self.createdDate = createdDate
    }
    
    func getUrl() -> String? {
        return self.url
    }
    
    func getWidth() -> Int? {
        return self.width
    }
    
    func getHeight() -> Int? {
        return self.height
    }
    
    func getCreatedDate() -> Date? {
        return self.createdDate
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
     함수명: editWidth
     기능: ImageWidth 을 변경한다.
     작성일자: 2019.07.15
     수정일자:
     */
    func editWidth(width: Int) -> Int? {
        self.width = width
        return width
    }
    
    /*
     함수명: editHeight
     기능: ImageHeight 을 변경한다.
     작성일자: 2019.07.15
     수정일자:
     */
    func editHeight(height: Int) -> Int? {
        self.height = height
        return height
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
