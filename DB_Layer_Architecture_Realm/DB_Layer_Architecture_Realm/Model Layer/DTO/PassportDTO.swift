//
//  PassportDTO.swift
//  DB_Layer_Architecture_Realm
//
//  Created by Ali Akhtar on 09/06/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation

//MARK: - PassportDTO
struct PassportDTO {
    
    var passportNumber = ""
}

//MARK: - PassportDTO RealmMappableProtocol
extension PassportDTO: MappableProtocol{
    
    func mapToPersistenceObject() -> Passport {
        let model = Passport()
        model.passportNumber = passportNumber
        return model
    }
    func mapToRealmObject() -> Passport {
        let model = Passport()
        model.passportNumber = passportNumber
        return model
    }
    
    static func mapFromPersistenceObject(_ object: Passport) -> PassportDTO {
        return PassportDTO(passportNumber: object.passportNumber)
    }
    
}
