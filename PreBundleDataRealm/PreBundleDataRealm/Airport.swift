//
//  Airport.swift
//  PreBundleDataRealm
//
//  Created by Ali Akhtar on 31/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import RealmSwift


class Airport: Object {
    
    @objc dynamic var airportName = ""
    @objc dynamic var airportId = 0
    @objc dynamic var airportCode = ""

    
    convenience init(_ airportName: String,_ airportCode: String, _ airportId: Int) {
        self.init()
        self.airportName = airportName
        self.airportId = airportId
        self.airportCode = airportCode
    }
}
