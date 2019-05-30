//
//  Todo.swift
//  RealmTodoApplicationNotificationStarter
//
//  Created by Ali Akhtar on 16/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import RealmSwift

class Todo: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var details = ""
    let ofUser = LinkingObjects(fromType: User.self,
                                property: "todos")
}
