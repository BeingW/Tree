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
    
    func editImageUrl(url: String) -> String? {
        self.url = url
        return url
    }
    
    func editWidth(width: Int) -> Int? {
        self.width = width
        return width
    }
    
    func editHeight(height: Int) -> Int? {
        self.height = height
        return height
    }
    
    func editCreateDate(date: Date) -> Date? {
        self.createdDate = date
        return createdDate
    }
    
}
