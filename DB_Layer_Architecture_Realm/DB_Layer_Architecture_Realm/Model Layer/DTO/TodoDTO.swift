//
//  TodoDTO.swift
//  DB_Layer_Architecture_Realm
//
//  Created by Ali Akhtar on 09/06/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation


//MARK: - TodoDTO
struct TodoDTO {
    
    var name: String
    var details: String
}

//MARK: - TodoDTO RealmMappableProtocol
extension TodoDTO: MappableProtocol{

    func mapToPersistenceObject() -> Todo {
        let model = Todo()
        model.name = name
        model.details = details
        return model
    }
    
    static func mapFromPersistenceObject(_ object: Todo) -> TodoDTO {
        return TodoDTO(name: object.name, details: object.details)
    }
    
}
