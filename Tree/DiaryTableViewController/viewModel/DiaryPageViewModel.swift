//
//  DiaryViewModel.swift
//  Tree
//
//  Created by Jae Ki Lee on 29/02/2020.
//  Copyright © 2020 Jae Ki Lee. All rights reserved.
//

import Foundation
import UIKit

struct DiaryPageViewModel {
    let title: String
    let date: Date
    let text: String
    var images = [UIImage]()
    
    init() {
        self.title = ""
        self.date = Date()
        self.text = ""
    }
    
    init(diaryPage: DiaryPage) {
        title = diaryPage.getTitle()
        date = diaryPage.getDate()
        text = diaryPage.getText()
        
        if let diaryPageImages = diaryPage.getDiaryPageImages(), diaryPageImages.count != 0 {
            diaryPageImages.forEach { (diaryImage) in
                images.append(diaryImage.getImage()!)
            }
        }
    }
    
    
}
