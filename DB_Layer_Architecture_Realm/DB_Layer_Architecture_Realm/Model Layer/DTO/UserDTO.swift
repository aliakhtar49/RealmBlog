//
//  UserDTO.swift
//  DB_Layer_Architecture_Realm
//
//  Created by Ali Akhtar on 09/06/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation

//MARK: - UserDTO
struct UserDTO {
    
    var firstName = ""
    var userId = 0
    var passport: PassportDTO?
    var todos = [TodoDTO]()
}


//MARK: - MappableProtocol Implementation
extension UserDTO: MappableProtocol{
    
    func mapToPersistenceObject() -> User {
        let model = User()
        model.firstName = firstName
        model.passport = passport?.mapToPersistenceObject()
        model.userId = userId
        model.todos.append(objectsIn: todos.map { $0.mapToPersistenceObject() })
        return model
    }
    
    static func mapFromPersistenceObject(_ object: User) -> UserDTO {
        var todos = [TodoDTO]()
        object.todos.forEach { (todo) in
            todos.append(TodoDTO.mapFromPersistenceObject(todo))
        }
        return UserDTO(firstName: object.firstName, userId: object.userId, passport: PassportDTO.mapFromPersistenceObject(object.passport!), todos: todos)
    }
    
}


