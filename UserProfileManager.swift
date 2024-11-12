//
//  UserProfileManager.swift
//  CC-All
//
//  Created by Wyatt Chrisman on 11/11/24.
//

import Foundation

struct UserProfile {
    var uid: String
    var name: String
    var city: String
    var allergies: [String]
    
    init(user: AuthDataResultModel) {
        self.uid = user.uid
        self.name = ""
        self.city = ""
        self.allergies = []
    }
    
    
}
