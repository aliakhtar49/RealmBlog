//
//  ViewController.swift
//  DB_Layer_Architecture_Realm
//
//  Created by Ali Akhtar on 09/06/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let dbManager: DataManager = RealmDataManager(RealmProvider.default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    

        

       
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}


class ViewModel {
    
    let dbManager: DataManager
    let userRepo: UserRepositoryProtocol
    
    init(dbManager: DataManager = RealmDataManager(RealmProvider.default)) {
         self.dbManager = dbManager
         self.userRepo = UserRepository(dbManager: dbManager)
    }
    
    func getData() {
        let todo1 = TodoDTO(name: "za", details: "dd")
        let todo2 = TodoDTO(name: "hja", details: "za")
        let user = UserDTO(firstName: "aai", userId: 1, passport: PassportDTO(passportNumber:"pass1"), todos: [todo1,todo2])
        userRepo.saveUser(user: user)
        
        userRepo.getAllUsers(on: Sorted(key: "firstName", ascending: true), completionHandler: { (users) in
            print(users[0].firstName)
            print(users[1].firstName)
        })
    }
}
