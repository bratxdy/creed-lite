//
//  UserDefaultKeys.swift
//  
//
//  Created by Scott Petit on 4/5/23.
//

import Foundation

public enum UserDefaultKeys: String {
    case authToken = "com.ladder.authToken"
    case userAuthenticationCache = "com.ladder.user.cache"
    case imposterAuthToken = "com.ladder.imposterAuthToken"
    case usageStats = "com.ladder.usage.stats"
    case testHomeFeedCountdown = "com.ladder.test.home.feed.countdown"
    case lastSentPushStatus = "com.ladder.last.sent.push.status"

    //Admin Testing
    case adminForceHomeTip = "com.ladder.admin.force.home.tip"
}

public extension UserDefaults {
    
    func string(for key: UserDefaultKeys) -> String? {
        string(forKey: key.rawValue)
    }
    
    func bool(for key: UserDefaultKeys) -> Bool {
        bool(forKey: key.rawValue)
    }
    
    func removeObject(for key: UserDefaultKeys) {
        removeObject(forKey: key.rawValue)
    }
    
}
