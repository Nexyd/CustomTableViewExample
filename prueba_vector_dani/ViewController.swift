//
//  ViewController.swift
//  prueba_vector_dani
//
//  Created by Daniel Morato on 05/10/2018.
//  Copyright © 2018 dani. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,
    UITableViewDelegate, UIScrollViewDelegate, GetRandomUserProtocol {

    @IBOutlet weak var table: UITableView!
    let connection = ConnectionManager()
    var users = [User]()
    var isLoadingMore = false
    let threshold: CGFloat = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        connection.delegate = self
        loadMore()
    }
    
    func OnGetUserData(users: Users) {
        self.users.append(contentsOf: users.results)
        self.table.reloadData()
    }

    func loadMore() {
        isLoadingMore = true
        DispatchQueue.global(qos: .userInitiated).async {
            self.connection.getRandomUser()
            DispatchQueue.main.async {
                self.table.reloadData()
                self.isLoadingMore = false
            }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = table.contentOffset.y
        let maximumOffset = table.contentSize.height
            - table.frame.size.height;
        
        if !isLoadingMore && (maximumOffset - contentOffset <= threshold) {
            loadMore()
        }
    }

    func tableView(_ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "UserCell") as! UserTableViewCell

        let imageUrl = user.picture?.thumbnail
        let url = URL(string: imageUrl!)

        DispatchQueue.global(qos: .userInitiated).async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.userImage.image = UIImage(data: data!)
            }
        }
        
        if let firstname = user.name?.first,
            let lastname = user.name?.last {
            cell.fullname.text = firstname + " " + lastname
        }
        
        cell.email.text = user.email
        cell.cellNumber.text = user.cell

        return cell
    }
}
