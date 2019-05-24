//
//  Diary.swift
//  Tree
//
//  Created by Jae Ki Lee on 5/22/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import Foundation
import UIKit

class Diary {
    var profilePicture: UIImage?
    var userName: String?
    
    init(profilePicture: UIImage?, userName: String?) {
        self.profilePicture = profilePicture ?? nil;
        self.userName = userName ?? "";
        
        //self.post?.id ?? ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
