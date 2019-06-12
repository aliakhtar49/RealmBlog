//
//  StorageContext.swift
//  DB_Layer_Architecture_Realm
//
//  Created by Ali Akhtar on 09/06/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import RealmSwift

extension Object: Storable {
    
}

public struct Sorted {
    var key: String
    var ascending: Bool = true
}



