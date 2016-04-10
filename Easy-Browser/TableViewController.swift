//
//  TableViewController.swift
//  Easy-Browser
//
//  Created by Ashutosh Purushottam on 4/10/16.
//  Copyright © 2016 Vivid Designs. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var websites = ["apple.com", "hackingwithswift.com"]
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ShowWebPage"
        {
            if let indexPath = tableView.indexPathForSelectedRow
            {
                let navigationController = segue.destinationViewController as! UINavigationController
                let controller = navigationController.topViewController as! WebViewController
                controller.webSite = websites[indexPath.row]
            }
        }
    }

    //MARK: -Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return websites.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel!.text = websites[indexPath.row]
        return cell
    }
    
    
    
    
    
}
