//
//  URL+Document.swift
//  DB_Layer_Architecture_Realm
//
//  Created by Ali Akhtar on 10/06/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation


extension URL {
    
    // returns an absolute URL to the desired file in documents folder
    static func inDocumentsFolder(fileName: String) -> URL {
        return URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0], isDirectory: true)
            .appendingPathComponent(fileName)
    }
}
