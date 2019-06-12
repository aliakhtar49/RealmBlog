//
//  ViewController.swift
//  RealmConcurrency
//
//  Created by Ali Akhtar on 06/06/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

    @IBAction func exportButtonTapped(_ sender: UIBarButtonItem) {
        loadGooglePlayStoreAppsFromCSVWithConcurrencyWithBatchInsert()
    }
    func loadGooglePlayStoreAppsFromCSVWithConcurrencyWithThousandsBatchInsert() {
        
       
        
        let writeQueue = DispatchQueue(label: "background",
                                       qos: .background,
                                       attributes: [.concurrent])
        writeQueue.async {
            let startTime = CFAbsoluteTimeGetCurrent()
            autoreleasepool {
                var realmBatches = [GooglePlay]()
                let realm = try! Realm()
                
                print(realm.configuration.fileURL!)
                
                var data = self.readDataFromCSV(fileName: "googleplaystore", fileType: "csv")
                data = self.cleanRows(file: data ?? "d") ; let csvRows = self.csv(data: data ?? "d")
                for i in 1 ..< (csvRows.count - 1 ) {
                    let googlePlay = GooglePlay()
                    googlePlay.app = csvRows[i][0]
                    googlePlay.category = csvRows[i][1]
                    googlePlay.rating = csvRows[i][2]
                    googlePlay.reviews = Int(csvRows[i][3]) ?? 123
                    googlePlay.size = csvRows[i][4]
                    googlePlay.type = csvRows[i][5]
                    googlePlay.price = csvRows[i][6]
                    googlePlay.contentRating = csvRows[i][7]
                    googlePlay.genres = csvRows[i][8]
                    googlePlay.currentVer = csvRows[i][9]
                    googlePlay.androidVer = csvRows[i][10]
                    realmBatches.append(googlePlay)
                    if i % 1000 == 0 {
                        try! realm.write {
                            realm.add(realmBatches)
                            realmBatches.removeAll()
                        }
                    }
                }
            }
            print("background Thread Time \(CFAbsoluteTimeGetCurrent() - startTime)")
        }
    }
    func loadGooglePlayStoreAppsFromCSVWithConcurrencyWithBatchInsert() {
      let writeQueue = DispatchQueue(label: "background",
                                               qos: .background,
                                               attributes: [.concurrent])
        writeQueue.async {
            let startTime = CFAbsoluteTimeGetCurrent()
           autoreleasepool {
                var realmBatches = [GooglePlay]()
                
                let realm = try! Realm()
           
                print(realm.configuration.fileURL!)
                
                var data = self.readDataFromCSV(fileName: "googleplaystore", fileType: "csv")
                data = self.cleanRows(file: data ?? "d")
                let csvRows = self.csv(data: data ?? "d")
                
                for i in 1 ..< (csvRows.count - 1 ) {
                    
                    let googlePlay = GooglePlay()
                    googlePlay.app = csvRows[i][0]
                    googlePlay.category = csvRows[i][1]
                    googlePlay.rating = csvRows[i][2]
                    googlePlay.reviews = Int(csvRows[i][3]) ?? 123
                    googlePlay.size = csvRows[i][4]
                    googlePlay.type = csvRows[i][5]
                    googlePlay.price = csvRows[i][6]
                    googlePlay.contentRating = csvRows[i][7]
                    googlePlay.genres = csvRows[i][8]
                    googlePlay.currentVer = csvRows[i][9]
                    googlePlay.androidVer = csvRows[i][10]
                    realmBatches.append(googlePlay)
                }
                try! realm.write {
                    realm.add(realmBatches)
                }
           }
            print("background Thread Time \(CFAbsoluteTimeGetCurrent() - startTime)")
        }
    }
    func loadGooglePlayStoreAppsFromCSVWithoutConcurrencyWithoutBatchInsert() {
        let startTime = CFAbsoluteTimeGetCurrent()
        
        let realm = try! Realm()
        print(realm.configuration.fileURL!)
        
        var data = self.readDataFromCSV(fileName: "googleplaystore", fileType: "csv")
        data = self.cleanRows(file: data ?? "d")
        let csvRows = self.csv(data: data ?? "d")
        
        for i in 1 ..< (csvRows.count - 1 ) {
            
            let googlePlay = GooglePlay()
            googlePlay.app = csvRows[i][0]
            googlePlay.category = csvRows[i][1]
            googlePlay.rating = csvRows[i][2]
            googlePlay.reviews = Int(csvRows[i][3]) ?? 123
            googlePlay.size = csvRows[i][4]
            googlePlay.type = csvRows[i][5]
            googlePlay.price = csvRows[i][6]
            googlePlay.contentRating = csvRows[i][7]
            googlePlay.genres = csvRows[i][8]
            googlePlay.currentVer = csvRows[i][9]
            googlePlay.androidVer = csvRows[i][10]
           
            try! realm.write {
                realm.add(googlePlay)
            }
        }
        print("Main Thread Block Time \(CFAbsoluteTimeGetCurrent() - startTime)")
    }
    
    func loadGooglePlayStoreAppsFromCSVWithoutConcurrencyWithBatchInsert() {
            let startTime = CFAbsoluteTimeGetCurrent()
            var realmBatches = [GooglePlay]()
            
            let realm = try! Realm()
            print(realm.configuration.fileURL!)
            
            var data = self.readDataFromCSV(fileName: "googleplaystore", fileType: "csv")
            data = self.cleanRows(file: data ?? "d")
            let csvRows = self.csv(data: data ?? "d")
            
            for i in 1 ..< (csvRows.count - 1 ) {
                
                let googlePlay = GooglePlay()
                googlePlay.app = csvRows[i][0]
                googlePlay.category = csvRows[i][1]
                googlePlay.rating = csvRows[i][2]
                googlePlay.reviews = Int(csvRows[i][3]) ?? 123
                googlePlay.size = csvRows[i][4]
                googlePlay.type = csvRows[i][5]
                googlePlay.price = csvRows[i][6]
                googlePlay.contentRating = csvRows[i][7]
                googlePlay.genres = csvRows[i][8]
                googlePlay.currentVer = csvRows[i][9]
                googlePlay.androidVer = csvRows[i][10]
                realmBatches.append(googlePlay)
               
            }
        autoreleasepool {
            try! realm.write {
                realm.add(realmBatches)
            }
        }
    print("Main Thread Block Time \(CFAbsoluteTimeGetCurrent() - startTime)")
        
    }
    
    
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            result.append(columns)
        }
        return result
    }
    
    func readDataFromCSV(fileName:String, fileType: String)-> String!{
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return nil
        }
        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = cleanRows(file: contents)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }
    
    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
    }
    
    //MARK: - Some Other code
    func updateOnMainThread() {
        checkAfterWriteBackgroundThreadUpdated()
        
        let realmOnMainThread = try! Realm()
        
        let googlePlay = GooglePlay()
        googlePlay.app = "main thread insert"
        
        try! realmOnMainThread.write {
            realmOnMainThread.add(googlePlay)
            
        }
    }
    func checkAfterWriteBackgroundThreadUpdated() {
        
        DispatchQueue.init(label: "background").async {
            
            let realmOnBackgroundThread = try! Realm()
            let googlePlays = realmOnBackgroundThread.objects(GooglePlay.self)
            
            var isToContunue = true
            while isToContunue {
                realmOnBackgroundThread.refresh()
                if googlePlays.count > 0 {
                    isToContunue = false
                    print("Found")
                }
            }
        }
    }
    
    
    func solutionAccessMainThreadRealmObjectOnBackgroundThreadExample() {
        
        let realmOnMainThread = try! Realm()
        let googlePlays =  realmOnMainThread.objects(GooglePlay.self)
        let googlePlayRef = ThreadSafeReference(to: googlePlays[0])
        DispatchQueue.init(label: "backgorund").async {
            
            let realmOnBakcgorundThread = try! Realm()
            guard let googlePlay = realmOnBakcgorundThread.resolve(googlePlayRef) else {
                return // person was deleted
            }
            
            try! realmOnBakcgorundThread.write {
                googlePlay.app = "Dd"
            }
        }
        
        
    }
    func accessMainThreadRealmObjectOnBackgroundThreadExample() {
        let realmOnMainThread = try! Realm()
        let googlePlays =  realmOnMainThread.objects(GooglePlay.self)
        
        DispatchQueue.init(label: "backgorund").async {
            
            let realmOnBakcgorundThread = try! Realm()
            let googlePlay = GooglePlay()
            googlePlay.app = "F"
            
            try! realmOnBakcgorundThread.write {
                googlePlays[0].app = "Dd"
            }
        }
        
    }
    func accessMainThreadRealmOnBackgroundThreadExample() {
        let realmOnMainThread = try! Realm()
        
        DispatchQueue.init(label: "backgorund").async {
            let googlePlay = GooglePlay()
            googlePlay.app = "F"
            
            try! realmOnMainThread.write {
                realmOnMainThread.add(googlePlay)
            }
        }
        
    }
    func compactFile() {
        let defaultURL = Realm.Configuration.defaultConfiguration.fileURL!
        let defaultParentURL = defaultURL.deletingLastPathComponent()
        let compactedURL = defaultParentURL.appendingPathComponent("default-compact.realm")
        autoreleasepool {
            let realm = try! Realm()
            try! realm.writeCopy(toFile: compactedURL)
        }
        try! FileManager.default.removeItem(at: defaultURL)
        try! FileManager.default.moveItem(at: compactedURL, to: defaultURL)
        
        printFileSIze(defaultURL.path)
    }
    
    func printFileSIze(_ filePath: String) {
        
        var fileSize : UInt64
        
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: filePath)
            fileSize = attr[FileAttributeKey.size] as! UInt64
            
            //if you convert to NSDictionary, you can get file size old way as well.
            let dict = attr as NSDictionary
            fileSize = dict.fileSize()
            let fileSizeSizeInMB = Double(fileSize) * (0.000001)
            
            print("File Size of \(filePath) = \(fileSizeSizeInMB) MB")
        } catch {
            print("Error: \(error)")
        }
    }
    func deleteAllRealmObjects() {
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
            print(realm.isEmpty)
            printFileSIze(realm.configuration.fileURL!.path)
        }
    }

}



protocol Manager {
    func fetch<T: Object>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: ((T) -> Void) )
}


public protocol Storable {
}
extension Object: Storable {
}

/*
 Operations on context
 */
protocol StorageContext {
    /*
     Create a new object with default values
     return an object that is conformed to the `Storable` protocol
     */
    func create<T: Storable>(_ model: T.Type, completion: @escaping ((T) -> Void)) throws
    /*
     Save an object that is conformed to the `Storable` protocol
     */
    func save(object: Storable) throws
    /*
     Update an object that is conformed to the `Storable` protocol
     */
    func update(block: @escaping () -> ()) throws
    /*
     Delete an object that is conformed to the `Storable` protocol
     */
    func delete(object: Storable) throws
    /*
     Delete all objects that are conformed to the `Storable` protocol
     */
    func deleteAll<T: Storable>(_ model: T.Type) throws
    /*
     Return a list of objects that are conformed to the `Storable` protocol
     */
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> ()))
    

}

public struct Sorted {
    var key: String
    var ascending: Bool = true
}


class RealmStorageContext: StorageContext {
 
     var realm: Realm?
    
    func create<T>(_ model: T.Type, completion: @escaping ((T) -> Void)) throws where T : Storable {
        guard let realm = self.realm,let model = model as? Object.Type else {
            throw NSError()
        }
        
        try realm.write  {
            let newObject = realm.create(model, value: [], update: false) as! T
            completion(newObject)
        }
    }
    
    func save(object: Storable) throws {
        guard let realm = self.realm,let object = object as? Object else {
            throw NSError()
        }
        
        try realm.write {
            realm.add(object)
        }
    }
    
    func update(block: @escaping () -> ()) throws {
        
        guard let realm = self.realm else {
            throw NSError()
        }
        
        try realm.write {
            block()
        }
    }
    
    func delete(object: Storable) throws {
        guard let realm = self.realm ,let object = object as? Object else {
            throw NSError()
        }
        
        try realm.write {
            realm.delete(object)
        }
    }
    
    func deleteAll<T>(_ model: T.Type) throws where T : Storable {
        guard let realm = self.realm,let model = model as? Object.Type else {
            throw NSError()
        }
        
        try realm.write {
            let objects = realm.objects(model)
            
            for object in objects {
                realm.delete(object)
            }
        }
    }
    
    func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> ())) where T : Storable {
        
        guard let realm = self.realm,let model = model as? Object.Type else {
           return
        }
        
        var objects = realm.objects(model)
        
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        
        if let sorted = sorted {
            objects = objects.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
        }
        
        completion(objects.compactMap { $0 as? T })
        
    }
    

}


