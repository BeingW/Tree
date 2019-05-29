//
//  Diary.swift
//  Tree
//
//  Created by Jae Ki Lee on 5/22/19.
//  Copyright © 2019 Jae Ki Lee. All rights reserved.
//

import Foundation
import UIKit

class User {
    private var profilePicture: String?
    private var userName: String?
    
    init(profilePicture: String?, userName: String?) {
        self.profilePicture = profilePicture ?? "";
        self.userName = userName ?? "";
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getUserName() -> String {
        return userName ?? ""
    }
    
    func getProfilePicture() -> String {
        return profilePicture ?? ""
    }
    
    func chageUserName(userName: String) -> String {
        self.userName = userName
        return self.userName ?? ""
    }
    
    func changeProfilePicture(profilePicture: String) -> String {
        self.profilePicture = profilePicture
        return self.profilePicture ?? ""
    }
}
