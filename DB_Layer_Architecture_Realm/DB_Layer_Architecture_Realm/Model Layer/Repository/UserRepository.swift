//
//  UserRepository.swift
//  DB_Layer_Architecture_Realm
//
//  Created by Ali Akhtar on 09/06/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import RealmSwift


//MARK: -  UserRepositoryProtocol
protocol UserRepositoryProtocol {
    
     //MARK: - Methods
     func getAllUsers(on sort: Sorted?,completionHandler: ([UserDTO]) -> Void)
     func saveUser(user: UserDTO)
     func updateUser(_ user: UserDTO)
}

//MARK: -  UserRepository
class UserRepository : BaseRepository<User> {

}

//MARK: -  UserRepositoryProtocol implementation
extension UserRepository: UserRepositoryProtocol {
    
    //MARK: - Methods
    func getAllUsers(on sort: Sorted? = nil ,completionHandler: ([UserDTO]) -> Void) {
        super.fetch(User.self, predicate: nil, sorted: sort) { (users) in
            completionHandler(users.map { UserDTO.mapFromPersistenceObject($0) } )
        }
    }
    func saveUser(user: UserDTO) {
        do { try super.save(object: user.mapToPersistenceObject()) }
        catch { print(error.localizedDescription) }
    }
    func updateUser(_ user: UserDTO) {
        do { try super.update(object: user.mapToPersistenceObject()) }
        catch { print(error.localizedDescription) }
    }
}







class PassportRepository {
    
    var dbManager : DataManager
    
    //MARK: - Init
    required init(dbManager : DataManager) {
        self.dbManager = dbManager
    }
    
  
    func savePassport(passport: PassportDTO) {
        do { try self.dbManager.save(object: passport.mapToPersistenceObject()) }
        catch { print(error.localizedDescription) }
    }

}

class RealmDataBaseManager: DataBaseManager {
    
    //MARK: - Stored Properties
    private let realm: Realm?
    
    init(_ realm: Realm? = try! Realm()) {
        self.realm = realm
    }
   
    func save(object: Storable) throws {
        guard let realm = realm, let object = object as? Object else { throw RealmError.eitherRealmIsNilOrNotRealmSpecificModel }
        try realm.write {
            realm.add(object)
        }
}
}
protocol DataBaseManager {
    func save(object: Storable) throws
}

