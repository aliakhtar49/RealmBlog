//
//  UserRepositoryTests.swift
//  DB_Layer_Architecture_RealmTests
//
//  Created by Ali Akhtar on 12/06/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import XCTest
import RealmSwift

@testable import DB_Layer_Architecture_Realm

class UserRepositoryTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testGetAllUsersMethod() {
       let realm = try? Realm(configuration: Realm.Configuration(inMemoryIdentifier: "MyInMemoryRealm"))
        let dbManager = RealmDataManager(realm)
        
        let user = User("nameStub", 1)
        try! realm?.write {
            realm?.add(user)
        }
        let userRepo = UserRepository(dbManager: dbManager)
        
        userRepo.fetch(User.self, predicate: nil, sorted: nil) { (users) in
            XCTAssert(users[0].firstName == "nameStub")
        }

    }

}
