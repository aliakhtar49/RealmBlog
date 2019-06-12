//
//  RealmMappableProtocol.swift
//  DB_Layer_Architecture_Realm
//
//  Created by Ali Akhtar on 09/06/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import RealmSwift

//MARK: - MappableProtocol
protocol MappableProtocol {
    
    associatedtype PersistenceType: Storable
    
    //MARK: - Method
    func mapToPersistenceObject() -> PersistenceType
    static func mapFromPersistenceObject(_ object: PersistenceType) -> Self
    
}






