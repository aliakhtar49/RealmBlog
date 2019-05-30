//
//  RealmProvider.swift
//  RealmTodoApplicationNotificationStarter
//
//  Created by Ali Akhtar on 17/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmProvider {
    
    let configuration: Realm.Configuration
    
    internal init(config: Realm.Configuration) {
        configuration = config
    }
    
    var realm: Realm {
        return try! Realm(configuration: configuration)
    }
    
    private static let defaultConfig = Realm.Configuration()
    
    public static var `default`: RealmProvider = {
        return RealmProvider(config: RealmProvider.defaultConfig)
    }()
}
