//
//  ViewController.swift
//  MigrationRealm
//
//  Created by Ali Akhtar on 12/06/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = Realm.Configuration(
            schemaVersion: 3,
            migrationBlock: { migration, oldVersion in
                
                migration.enumerateObjects(ofType: "User") { old, new in
                    if oldVersion == 1 {
                        if old?["title"] == nil {
                        new?["title"] = "migrated value"
                        }
                        migration.renameProperty(onType: "User", from: "currentUser", to: "isCurrentUser")
                    }
                    
                }
                if oldVersion == 2 {
                    
                     migration.enumerateObjects(ofType: "User") { old, new in
                        let passport:MigrationObject = migration.create("Passport", value: [
                            "passportNumber": "migration passport Number"
                            ])
                        new?["passport"] = passport
                    }
                }
                
        }
        )
        let realm = try! Realm(configuration: configuration)
        let users = realm.objects(User.self)
        for user in users {
            print(user.userId)
            print(user.title ?? "Default value")
            print(user.isCurrentUser)
            print(user.passport?.passportNumber ?? "default")
        }
    }
}

class User: Object {
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var title: String? = nil
    @objc dynamic var userId = 0
    @objc dynamic var isCurrentUser = false
    @objc dynamic var passport: Passport?
    
    override static func primaryKey() -> String? {
        return "userId"
    }
    
    convenience init(_ firstName: String, _ userId: Int) {
        self.init()
        self.firstName = firstName
        self.userId = userId
    }
}
class Passport: Object {
     @objc dynamic var passportNumber = ""
}
