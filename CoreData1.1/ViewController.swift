//
//  ViewController.swift
//  CoreData1.1
//
//  Created by Joseph Castro on 7/2/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var users = [User]()
    let manager = CoreDataManager()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name + " " + users[indexPath.row].username + " " + users[indexPath.row].email
        
        return cell
    }
    
    @IBOutlet weak var tbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        URLSession.shared.dataTask(with: URL(string: "https://jsonplaceholder.typicode.com/users")!) { data, response, error in
            guard let data = data else {
                return
            }

            if let users = try? JSONDecoder().decode([User].self, from: data){
                self.manager.addUsers(users: users)
            }
            let users = self.manager.fetchUsers()
            DispatchQueue.main.async {
                self.users = users
                self.tbl.reloadData()
            }
            
        }.resume()
        
        
    }


}


struct User:Decodable{
    let name: String
    let username: String
    let email: String
}




