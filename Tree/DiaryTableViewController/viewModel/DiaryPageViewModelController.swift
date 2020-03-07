//
//  DiaryViewModelController.swift
//  Tree
//
//  Created by Jae Ki Lee on 29/02/2020.
//  Copyright © 2020 Jae Ki Lee. All rights reserved.
//

import Foundation

class DiaryPageViewModelController {
    fileprivate var viewModels: [DiaryPageViewModel] = []
    
    var viewModelCount: Int {
        return viewModels.count
    }
    
    func retrieveDiaryPages(_ completionBlock: @escaping (_ success: Bool, _ error: NSError?) -> ()) {
        self.viewModels.removeAll()
        //DiaryPageDAO 를 선언 하여 DiaryPage 배열 객체를 가져온다.
        guard let diaryPages = DiaryPageDAO().fetchDiaryPage() else {
            completionBlock(false, nil)
            return
        }
        //가져온 객체를 date 기준으로 Decending 한다.
        let decendingDiaryPages = diaryPages.sorted(by: { $0.getDate().compare($1.getDate()) == .orderedDescending })
        //가져온 객체를 차례대로 DiaryPageViewModel 에 맵핑한다.
        decendingDiaryPages.forEach { (diaryPage) in
            let diaryPageViewModel = DiaryPageViewModel(diaryPage: diaryPage)
            viewModels.append(diaryPageViewModel)
        }
        
        completionBlock(true, nil)
    }
    
    func getDiaryPageViewModel(at index: Int) -> DiaryPageViewModel? {
        if self.viewModels.count < 0 {
            return nil
        } else {
            return viewModels[index]
        }
    }
}
