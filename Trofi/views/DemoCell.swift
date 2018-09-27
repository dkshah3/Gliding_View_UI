//
//  DemoCell.swift
//  Trofi
//
//  Created by Dhrumil Shah on 2017-07-22.
//  Copyright © 2017 makeschool. All rights reserved.
//

import UIKit
import FoldingCell
import Firebase

class DemoCell: FoldingCell, UITableViewDelegate, UITableViewDataSource {
    
  
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var vendorLogo: UIImageView!
    @IBOutlet weak var vendorName: UILabel!
    @IBOutlet weak var foodType: UILabel!
    @IBOutlet weak var priceRange: UILabel!
    @IBOutlet weak var distance: UILabel!
    var allVendors: [Vendors] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.allVendors.count > 0){
            return self.allVendors[0].all_foods.count
        }
        else{
             return self.allVendors.count
        }
        
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
       

        print("bro")
        print(indexPath.row)
        let vendor = self.allVendors[0]
        
        cell.name.text = vendor.all_foods[indexPath.row].food_name
        cell.priceLabel.text = String(vendor.all_foods[indexPath.row].discounted_price)
        cell.discount.text = String(vendor.all_foods[indexPath.row].percent_discount)
        cell.timer.text = vendor.all_foods[indexPath.row].time
        cell.servingsNumber.text = String(vendor.all_foods[indexPath.row].original_price)
        
        
        
        return cell
        
    }

    var number: Int = 0 {
        didSet {
        }
    }
    
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
                print("DHVANI")
                print(new_vendor)
               // self.tableView.reloadData()
                // first_vendor.all_foods = all_foods
                // return self.allVendors.count
                
                //  return self.allVendors.count
               self.menuTableView.reloadData()
                
            })
            
        })
        
        print(self.allVendors.count)
        print("dhvani")
        return self.allVendors.count
    }

    override func awakeFromNib() {
        menuTableView.delegate = self
        menuTableView.dataSource = self
        print("hereeee")
        
       loadData()
        
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }


    //this code is for animations of the foldingcell
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[2]
    }

}




// MARK: - Actions
extension DemoCell {
    @IBAction func buttonHandler(_ sender: AnyObject) {
        print("tap")
    }

    
}
