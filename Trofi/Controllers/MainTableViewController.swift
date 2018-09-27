//
//  MainTableViewController.swift
//  Trofi
//
//  Created by Dhrumil Shah on 2017-07-22.
//  Copyright © 2017 makeschool. All rights reserved.
//

import UIKit
import FoldingCell
import Firebase
import Alamofire
import SwiftyJSON

class MainTableViewController: UITableViewController {
    
    var allVendors: [Vendors] = []

    
    let kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 488
    var cellHeights: [CGFloat] = []
    
    var types = ""
    var priceRanges = ""
    var distances = ""
    var vendorNames = ""
    var servingsNumberVar = ""
    var priceLabelVar = ""
    var nameVar = ""
    var vendorKeys = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
         print("r")
     
        print("here")
        print(self.allVendors.count)
        
        loadData()
        
    }
    
    
        
    private func setup() {
        cellHeights = Array(repeating: kCloseCellHeight, count: 20)
        tableView.estimatedRowHeight = kCloseCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
}


// MARK: - TableView
extension MainTableViewController {
    
    func loadData() -> Int{
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        var first_vendor: Vendors
        var r_name = String()
        var r_desc = String()
        var r_add = String()
        var r_disc = Bool()
        
        var postRefFirst = ref.child("xwhX9E9okbM4oVYuu7GWJT2kXe83")
        
        var refHandleFirst = postRefFirst.observe(DataEventType.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            //  let username = value?["username"] as? String ?? ""
            // ...
            print(value!["restaurant_desc"])
            
           r_name = value!["restaurant_name"]! as! String
            r_desc = value!["restaurant_desc"]! as! String
            r_add = value!["address"]! as! String
            r_disc = value!["discounts_active"]! as! Bool
            // return self.allVendors.count
            print(r_name)
            print(r_desc)
            print(r_add)
            print(r_disc)
            //  return self.allVendors.count
            var all_foods = [Food]()
            var postRef = ref.child("xwhX9E9okbM4oVYuu7GWJT2kXe83").child("menu")
            
            var refHandle = postRef.observe(DataEventType.value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                //  let username = value?["username"] as? String ?? ""
                // ...
                //print(value)
                
                
                
                for (key, value2) in value! {
                    let value_in = value2 as! NSDictionary
                    
                    var f_name = String()
                    var f_desc = String()
                    var f_oprice = Int()
                    var f_dprice = Int()
                    var f_pprice = Int()
                    var time = String()
                    
                    for (key2, value) in value_in {
                        
                        
                        if(key2 as! String == "name"){
                            //   print("_------")
                            //  print(value)
                            //  print("_------")
                            f_name = value as! String
                        }
                        
                        if(key2 as! String == "desc"){
                            f_desc = value as! String
                        }
                        
                        if(key2 as! String == "original_price"){
                            let price = value as! NSNumber
                            f_oprice = price.intValue
                        }
                        
                        
                        if(key2 as! String == "discounted_price"){
                            let price = value as! NSNumber
                            f_dprice = price.intValue
                        }
                        if(key2 as! String == "percent_discount"){
                            let price = value as! NSNumber
                            f_pprice = price.intValue
                        }
                        if(key2 as! String == "time"){
                            time = value as! String
                        }
                        
                        // all_foods.append(Food)
                        
                        
                        
                        //    print(value)
                        
                        // self.allVendors.append(Vendors(restaurantName: "Pizz"))
                        //     print("here")
                        
                        //      print(self.allVendors.count)
                        // return self.allVendors.count
                        // return self.allVendors.count
                    }
                    all_foods.append(Food(food_name: f_name, desc: f_desc, original_price: f_oprice, discounted_price: f_dprice, percent_discount: f_pprice, time: time))
                    
                }
                
                var new_vendor = Vendors(restaurant_name: r_name, restaurant_desc: r_desc, restaurant_address: r_add, discounts_active: r_disc, all_foods: all_foods)
                self.allVendors.removeAll()
                self.allVendors.append(new_vendor)
                print("r")
                print(new_vendor)
                self.tableView.reloadData()
                // first_vendor.all_foods = all_foods
                // return self.allVendors.count
                
                //  return self.allVendors.count
                
                
            })
            
        })
      
        print(self.allVendors.count)
        print("dhvani")
         return self.allVendors.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.allVendors.count)
         //self.allVendors.append(Vendors(restaurantName: "Pizz"))
        print("r")
      // var num =
       return self.allVendors.count
    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int
//    {
//        return self.allVendors.count
//    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard case let cell as DemoCell = cell else {
            return
        }
       // cell.menuTableView.dequeueReusableCell(withIdentifier: <#T##String#>)

        let vendor = self.allVendors[indexPath.row]

        print(vendor)
        print("COME ON")
       // print(cell.menuTableView.cellForRow(at: indexPath))
     //  cell.menuTableView.beginUpdates()
      //   cell.menuTableView.insertRowsAtIndexPaths([
    //        NSIndexPath(forRow: Yourarray.count-1, inSection: 0)
    //        ], withRowAnimation: .Automatic)
    //    cell.menuTableView.endUpdates()
    
        
       // print(cell.menuTableView.cellForRow(i))
        print(vendor.all_foods.count)
        
        cell.priceRange.text = String(vendor.discounts_active)
        cell.foodType.text = vendor.restaurant_desc
        cell.vendorName.text = vendor.restaurant_name
        cell.distance.text = vendor.restaurant_address
        cell.backgroundColor = .clear
        
        print(cellHeights)
        if cellHeights[indexPath.row] == kCloseCellHeight {
            
            
            cell.unfold(false, animated: false, completion:nil)
            
            
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
        
        cell.number = indexPath.row
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! FoldingCell
        
        
        
        
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
    
                return cell
    }
  
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == kCloseCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
        
    }
    
}
