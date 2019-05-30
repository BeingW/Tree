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
    private var contents: String?
    private var images: [String?]
    
    init(title: String?, date: String, contents: String?) {
        self.title = title
        self.date = date
        self.contents = contents
        self.images = [nil]
    }
    
    func getTitle() -> String {
        guard let title = self.title else {return ""}
        return title
    }
    
    func getDate() -> String {
        return date
    }
    
    func getContents() -> String {
        guard let contents = self.contents else {return ""}
        return contents
    }
    
    func getImages() -> [String?] {
        return images
    }
    
    func writeTitle(title: String) -> String {
        self.title = title
        return self.title!
    }
    
    func writeDate() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy/MM/dd, hh:mm"
        
        let today = NSDate()
        
        let dateString = dateFormatter.string(from: today as Date)
        
        return dateString
    }
    
    func writeContents(contents: String) -> String {
        self.contents = contents
        return self.contents!
    }
    
    func postImages(images: [String]) -> [String] {
        var i = 0
        let count = self.images.count
        
        self.images.removeAll()
        
        while i < count {
            self.images.append(images[i])
            i += 1
        }
        
        return self.images as! [String]
    }
    
    func deleteTitle() {
        self.title = ""
    }
    
    func deleteContents() {
        self.contents = ""
    }
    
    func deleteAllImages() {
        self.images.removeAll()
    }
    
    func deleteImageAt(index: Int){
        self.images.remove(at: index)
    }
}

extension DiaryPage {
    static func == (leftDiaryPage: DiaryPage, rigthDiaryPage: DiaryPage) -> Bool {
        
        var isIqual: Bool
        
        if leftDiaryPage == rigthDiaryPage {
            isIqual = true
        } else {
            isIqual = false
        }
        
        return isIqual
    }
}
