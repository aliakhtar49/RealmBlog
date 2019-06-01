//
//  ViewController.swift
//  PreBundleDataRealm
//
//  Created by Ali Akhtar on 31/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import UIKit
import RealmSwift
import Foundation



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let key = "wrong"
        let encyptedConfig = Realm.Configuration(
            fileURL: inLibrarayFolder(fileName: "encypted.realm"),encryptionKey:key.sha512())
        
        do {
            let encyptedRealm = try Realm(configuration: encyptedConfig)
            
            let airports = encyptedRealm.objects(Airport.self)
            print(airports[0].airportName)
            print(airports[1].airportName)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    func openWithCorrectKey() {
        let key = "password"
        let encyptedConfig = Realm.Configuration(
            fileURL: inLibrarayFolder(fileName: "encypted.realm"),encryptionKey:key.sha512())
        let encyptedRealm = try! Realm(configuration: encyptedConfig)
        
        let airports = encyptedRealm.objects(Airport.self)
        print(airports[0].airportName)
        print(airports[1].airportName)
        
    }
    
    func encyption()  {
        autoreleasepool {
            let mainConfig = Realm.Configuration(
                fileURL: inLibrarayFolder(fileName: "main.realm"))
            let realm = try! Realm(configuration: mainConfig)
            let key = "password"
            try! realm.writeCopy(
                toFile: inLibrarayFolder(fileName: "encypted.realm"), encryptionKey: key.sha512())
            print(mainConfig.fileURL!)
            
        }
    }
    func copyPreBundleDataCompeletely() {
        let mainRealmUrl = inLibrarayFolder(fileName: "main.realm")
        let bundleUrl = Bundle.main.url(forResource: "bundle", withExtension: "realm")!
        
        //After launch after fresh install (if main.realm never created)
        if (!FileManager.default.fileExists(atPath: mainRealmUrl.path)){
            //copy bundled data into writable location compeletely
            try! FileManager.default.copyItem(
                at: bundleUrl, to: mainRealmUrl)
            print(mainRealmUrl)
        }
    }
    
        func dumpBundleNewlyAddedDataIntoTheExistingRealm() {
            
            //Get existing realm object
            let configurationMain = Realm.Configuration(fileURL: inLibrarayFolder(fileName: "main.realm"))
            let realmMain = try! Realm(configuration: configurationMain)
    
            //Get bundle realm object
            let configurationBundle = Realm.Configuration(fileURL: Bundle.main.url(forResource: "bundle", withExtension: "realm"))
            let realmBundle = try! Realm(configuration: configurationBundle)
    
            
            let someHowFigureApplicationUpdateFirstLaunch = true
            
            //Get the lists of the data not in the existing application
            if someHowFigureApplicationUpdateFirstLaunch {
                var needsToCopy = [Airport]()
                for bundledObject in realmBundle.objects(Airport.self){
                    let airports =  realmMain.objects(Airport.self).filter("airportId == %d",bundledObject.airportId)
                    
                    if airports.count <= 0 {
                        needsToCopy.append(bundledObject)
                    }
                }
                
                //insert data into the existing realm
                guard needsToCopy.count > 0 else { return }
                try! realmMain.write {
                    for airport in needsToCopy {
                       realmMain.create(Airport.self, value: airport, update: false)
                    }
                }
        }
            
    }
    
    
    
    func existingDataInThePreviousVersion() {
        let configuration = Realm.Configuration(fileURL: inLibrarayFolder(fileName: "main.realm"))
        let realm = try! Realm(configuration: configuration)
        
        print(configuration.fileURL!)
        
        let airport1 = Airport("London Aiport", "LHP", 3)
        let airport2 = Airport("Heathrow Aiport", "LHR", 4)
        
        try! realm.write {
            realm.add([airport1,airport2])
        }
    }
    
    
    func prebundleData() {
        let configuration = Realm.Configuration(fileURL: inLibrarayFolder(fileName: "bundle.realm"))
        let realm = try! Realm(configuration: configuration)
        print(realm.configuration.fileURL!)
        print(realm.isEmpty)
        
        let airport1 = Airport("jinnah Aiport", "OPKC", 1)
        let airport2 = Airport("Lahore Aiport", "OPKL", 2)
        
        try! realm.write {
            realm.add([airport1,airport2])
        }
        print(realm.configuration.fileURL!)
    }
    
    
    

  
    func readingBundleData() {
        let fileUrl = Bundle.main.url(forResource: "bundle", withExtension: "realm")
        let configuration = Realm.Configuration(fileURL: fileUrl)
        let realm = try! Realm(configuration: configuration)
        
        let airports = realm.objects(Airport.self)
        print(airports[0].airportName)
        print(airports[1].airportName)
        
        try! realm.write {
            airports[0].airportName = "ff"
        }
        print(airports[0].airportName)
    }
    
  
    
    func inLibrarayFolder(fileName: String) -> URL {
        return URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0], isDirectory: true)
            .appendingPathComponent(fileName)
    }
    
    


}

import CommonCrypto
extension String {
    
    func sha512() -> Data? {
            let stringData = data(using: String.Encoding.utf8)!
            var result = Data(count: Int(CC_SHA512_DIGEST_LENGTH))
            _ = result.withUnsafeMutableBytes { resultBytes in
                stringData.withUnsafeBytes { stringBytes in
                    CC_SHA512(stringBytes, CC_LONG(stringData.count), resultBytes)
                }
            }
            return result
    }
    
}
