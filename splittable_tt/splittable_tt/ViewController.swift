//
//  ViewController.swift
//  splittable_tt
//
//  Created by Lawrence Dawson on 09/11/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import UIKit
import SwiftyJSON

//let cell : Int!
//let text : String!
//let image : UIImage!

class TableViewController: UITableViewController{
 
    var items = [ProfessionObject]()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            addData()
        }
    
    func addData() {
            print("add data called")
            RestApiManager.sharedInstance.getSheetsuApi { (json: JSON) in
                if let results = json.array {
                    for entry in results {
                        self.items.append(ProfessionObject(json: entry))
                    }
                    self.items.sort{$0.sortOrder < $1.sortOrder}
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                }
            }
        }
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.items.count;
        }
    
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let profession = self.items[indexPath.row]

            let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
            
                if let url = NSURL(string: profession.pictureURL) {
                    if let data = NSData(contentsOf: url as URL) {
        
                         cell.mainImageView.image = UIImage(data: data as Data)
                    }
                }
            if  profession.name == "Banner" {
                 cell.mainImageLabel.isHidden = true
                 return cell
            } else {
                cell.mainImageLabel.text = profession.name
                return cell
            }
        }
    
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if  self.items[indexPath.row].name == "Banner" {
                return 250
            } else {
                return 250
            }
        }
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    }
