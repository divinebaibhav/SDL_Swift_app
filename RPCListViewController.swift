//
//  RPCListViewController.swift
//  SDLApp
//
//  Created by essadmin on 4/28/16.
//  Copyright © 2016 Baibhav. All rights reserved.
//

import UIKit

class RPCListViewController: UITableViewController {
    
    let arrRPC  = ["Add Command","Add choice set"]
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        cell?.textLabel?.text = arrRPC[indexPath.row]
        return (cell)!
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return        arrRPC.count
    }
    

}
