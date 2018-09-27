//
//  MenuTableView.swift
//  Trofi
//
//  Created by Dhrumil Shah on 2017-07-25.
//  Copyright © 2017 makeschool. All rights reserved.
//

import UIKit

class MenuTableView: UITableView {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath)
        
        cell.textLabel?.text = "Yay - it's working!"

        
        return cell
    }
    
}

