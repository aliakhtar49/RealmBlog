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
        
        notificationToken = users?.observe() { [unowned self] (changes) in
            

            switch changes {
                
            case .initial(let users):
                print(users.count)
                self.tableView.reloadData()
            case .update(let users, let deletions, let insertions, let modifications):
                print(users.count)
                print(deletions)
                print(insertions)
                print(modifications)
                self.tableView.reloadData()
            case .error(let error):
                print(error.localizedDescription)
            }
        }
        
    
    }

    func insertObjectIfNotExistsIntoTheRealm(){
        let realm = RealmProvider.default.realm
       
        users = realm.objects(User.self)
        if (users?.count == 0 ) {
            let 
        }
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
