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
    
    init(title: String?, contents: String?, images: [Image?]) {
        self.title = title ?? ""
        self.text = contents ?? ""
        self.images = images 
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd, hh:mm:ss"
        let today = NSDate()
        let dateString = dateFormatter.string(from: today as Date)
        
        self.date = dateString
    }
    
    func getTitle() -> String? {
        return self.title
    }
    
    func getDate() -> String? {
        return self.date
    }
    
    func getText() -> String? {
        return self.text
    }
    
    func getImageAt(index: Int) -> Image? {
        return self.images[index]
    }
    
    func getImages() -> [Image?] {
        return images
    }
    
    func editTitle(title: String) -> String? {
        self.title = title
        return self.title
    }
    
    func editText(text: String) -> String? {
        self.text = text
        return self.text
    }
    
    func deleteImageAt(index: Int){
        self.images.remove(at: index)
    }
    
    func deleteAllImages() {
        self.images.removeAll()
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
