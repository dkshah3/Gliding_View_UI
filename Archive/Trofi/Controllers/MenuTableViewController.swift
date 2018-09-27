//
//  MenuTableViewController.swift
//  Trofi
//
//  Created by Dhrumil Shah on 2017-07-25.
//  Copyright © 2017 makeschool. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    // 1
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // 2
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 3
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath)
        
        // 5
        return cell
    }

}






