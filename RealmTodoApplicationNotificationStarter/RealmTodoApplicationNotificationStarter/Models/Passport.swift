//
//  Passport.swift
//  RealmTodoApplicationNotificationStarter
//
//  Created by Ali Akhtar on 16/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import RealmSwift

class Passport: Object {
    
    @objc dynamic var passportNumber = ""
    let ofUser = LinkingObjects(fromType: User.self,
                                property: "passport")
    
    
    
}
