//
//  User.swift
//  RealmTodoApplicationNotificationStarter
//
//  Created by Ali Akhtar on 16/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import RealmSwift


class User: Object {
    
    @objc dynamic var firstName = ""
    @objc dynamic var userId = 0
    @objc dynamic var passport: Passport?
    let todos = List<Todo>()
    
    override static func primaryKey() -> String? {
        return "userId"
    }
    
    convenience init(_ firstName: String, _ userId: Int) {
        self.init()
        self.firstName = firstName
        self.userId = userId
    }
}

