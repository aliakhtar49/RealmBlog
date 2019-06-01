//
//  TodayViewController.swift
//  PreBundleExtension
//
//  Created by Ali Akhtar on 01/06/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import UIKit
import RealmSwift
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let fileURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.ali.test")?.appendingPathComponent("shared.realm")
        let sharedConfig = Realm.Configuration(
            fileURL: fileURL)
        
        let sharedRealm = try! Realm(configuration: sharedConfig)
        let airports = sharedRealm.objects(Airport.self)
        
        if airports.count > 0 {
            print(airports[0].airportName)
            print(airports[1].airportName)
        }
        print("Airports in database = \(airports.count)")
        print(sharedConfig.fileURL!)
        
        
        
    }
    
    func accessDataFromApplication() {
        let config = Realm.Configuration(
            fileURL: inLibrarayFolder(fileName: "main.realm"))
        let realm = try! Realm(configuration: config)
        
        let airports = realm.objects(Airport.self)
        
        if airports.count > 0 {
            print(airports[0].airportName)
            print(airports[1].airportName)
        }
        print("Airports in database = \(airports.count)")
        print(config.fileURL!)
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    func inLibrarayFolder(fileName: String) -> URL {
        return URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0], isDirectory: true)
            .appendingPathComponent(fileName)
    }
 
    
    
}
