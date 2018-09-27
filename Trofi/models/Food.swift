//
//  Food.swift
//  Trofi
//
//  Created by Dhvani Patel on 2018-02-26.
//  Copyright © 2018 makeschool. All rights reserved.
//
import Foundation
import UIKit


class Food {
    
    var food_name: String
    var desc: String
    var original_price: Int
    var discounted_price: Int
    var percent_discount: Int
    var time: String
    
    
    
    init(food_name: String, desc: String, original_price: Int, discounted_price: Int, percent_discount: Int, time: String) {
        self.food_name = food_name
        self.desc = desc
        self.original_price = original_price
        self.discounted_price = discounted_price
        self.percent_discount = percent_discount
        self.time = time
        
    }
    
}
