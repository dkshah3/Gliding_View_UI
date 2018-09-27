//
//  Vendor.swift
//  Trofi
//
//  Created by Dhvani Patel on 2018-02-26.
//  Copyright © 2018 makeschool. All rights reserved.
//

import Foundation
import UIKit

class Vendors {
    
    var restaurant_name: String
    var restaurant_desc: String
    var restaurant_address: String
    var discounts_active: Bool
    var all_foods = [Food]()
    
    init(restaurant_name: String, restaurant_desc: String, restaurant_address: String, discounts_active: Bool, all_foods: [Food]) {
        self.restaurant_name = restaurant_name
        self.restaurant_desc = restaurant_desc
        self.restaurant_address = restaurant_address
        self.discounts_active = discounts_active
        self.all_foods = all_foods
        
    }
    
}



