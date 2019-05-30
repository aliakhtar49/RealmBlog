//
//  ViewController.swift
//  RealmTodoApplicationNotificationStarter
//
//  Created by Ali Akhtar on 16/05/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var users: Results<User>?
    var notificationToken: NotificationToken?
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        insertObjectIfNotExistsIntoTheRealm()
        addObserver()
    }
    func addObserver() {
        
        notificationToken = users?.observe() { [unowned self] (changes) in
            switch changes {
            case .initial(let users):
                print("Initial case \(users.count)")
                self.tableView.reloadData()
            case .update(let users, let deletions, let insertions, let modifications):
                print("update case \(users.count)")
                print("deletions Indexes\(deletions)")
                print("insertions Indexes\(insertions)")
                print("modifications Indexes\(modifications)")
                self.tableView.reloadData()
            case .error(let error):
                print(error.localizedDescription)
            }
        }
        
    }

    func insertObjectIfNotExistsIntoTheRealm(){
        let realm = RealmProvider.default.realm
        
        users = realm.objects(User.self)
        print("Before Insert Live Results\(String(describing: users?.count))")
        if (users?.count == 0 ) {
            
            let user = User("ali", 1)
            //Todos
            let todo1 = Todo("RxSwift", "Need ot create RxSwift blog")
            let todo2 = Todo("RxSwift-VIPER", "Need ot create RxSwift with VIPER blog")
            let todo3 = Todo("RxSwift-MVVM", "Need ot create RxSwift with MVVM blog")
            user.todos.append(objectsIn: [todo1,todo2,todo3])
            
            let userPassport = Passport()
            userPassport.passportNumber = "Pass1"
            user.passport = userPassport
            
            try! realm.write {
                realm.add(user)
            }
            
            print("After Insert Live Results\(String(describing: users?.count))")
        }
    }
    
    @IBAction func inserTodoButtonTapped(_ sender: Any) {
        let realm = try! Realm()
        let users = realm.objects(User.self).filter("userId == 1")
        
         let todo = Todo("GCD", "Need ot create GCD blog")
        
        try! realm.write {
            users[0].todos.append(todo)
            print(users[0].todos.count)
        }
    }
    
    @IBAction func updateTodoButtonTapped(_ sender: Any) {
    }
    
    @IBAction func deletTodoButtonTapped(_ sender: Any) {
    }
    @IBAction func updatePassportButtonTapped(_ sender: Any) {
    }
}

extension ViewController : UITableViewDelegate {
    
    
    //Mark: - TableView Delegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "Cell1") as! HeaderTableViewCell
        
            let user = users?[section]
            headerCell.firstName.text = user?.firstName
            headerCell.passportNumber.text = user?.passport?.passportNumber
        
            return headerCell.contentView
        }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 51
    }
    
    
}



extension ViewController : UITableViewDataSource {
    
    //Mark: - TableView DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?[section].todos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        let todo = users?[indexPath.section].todos[indexPath.row]
        cell.textLabel!.text = todo?.name
        cell.detailTextLabel?.text = todo?.details
        return cell
    }
    
    
}
