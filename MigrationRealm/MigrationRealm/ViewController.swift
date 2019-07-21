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
        
    }


}


class User: Object {
    
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var userId = 0
    
    override static func primaryKey() -> String? {
        return "userId"
    }
    
    convenience init(_ firstName: String, _ userId: Int) {
        self.init()
        self.firstName = firstName
        self.userId = userId
    }
}
