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
    private static let mainConfig = Realm.Configuration(
        fileURL:  URL.inDocumentsFolder(fileName: "main.realm"),
        schemaVersion: 1)
    
    public static var `default`: RealmProvider = {
        return RealmProvider(config: RealmProvider.defaultConfig)
    }()
    
    
    
}

    extension URL {

        // returns an absolute URL to the desired file in documents folder
        static func inDocumentsFolder(fileName: String) -> URL {
            return URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0], isDirectory: true)
                .appendingPathComponent(fileName)
        }
    }
