//
//  GooglePlay.swift
//  RealmConcurrency
//
//  Created by Ali Akhtar on 06/06/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import RealmSwift

class GooglePlay: Object {
    
    @objc dynamic var app = ""
    @objc dynamic var category = ""
    @objc dynamic var rating = ""
    @objc dynamic var reviews = 123
    @objc dynamic var size = ""
    @objc dynamic var type = ""
    @objc dynamic var price = ""
    @objc dynamic var contentRating = ""
    @objc dynamic var genres = ""
    @objc dynamic var currentVer = ""
    @objc dynamic var androidVer = ""
    
}
