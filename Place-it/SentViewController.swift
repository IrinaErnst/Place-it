//
//  SentViewController.swift
//  Place-it
//
//  Created by Ilona Michalowska on 11/5/14.
//  Copyright (c) 2014 Ilona Michalowska & Irina Kalashnikova. All rights reserved.
//

import UIKit

class SentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var CancelBarButton: UIBarButtonItem!
    @IBOutlet weak var MessagesTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Sent"

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Returning to View--Update the list of messages:
    override func viewWillAppear(animated: Bool) {
        MessagesTableView.reloadData()
    }
    
    
    // Optional function for UITableViewDelegate--Delete functionality for the table:
    // After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
    // Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            
            var tempMessage: message = sentMessageMgr.messages.removeAtIndex(indexPath.row)
            
            // Append tempMessage to Trash array
            trashMessageMgr.addMessage(tempMessage.receiver, place_arg: tempMessage.place, content_arg: tempMessage.content)
            
            //Update the Table View:
            MessagesTableView.reloadData()
            
            //println("Delete this row")
        }
    }
    
    
    // Mandatory function for UITableViewDataSource (tell the table how many rows it needs to render):
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return sentMessageMgr.messages.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    
    // Mandatory function for UITableViewDataSource (create cells in the table)
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "test")
        
        // might be incorrect...
        cell.textLabel?.text = sentMessageMgr.messages[indexPath.row].receiver
        cell.detailTextLabel?.text = sentMessageMgr.messages[indexPath.row].content
        //need to do sth with the place member variable & optionally date
        
        return cell
    }
    
    
    // Select & Edit
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        // Create an Instance of To-FromVC
        var detail: To_FromVC = self.storyboard?.instantiateViewControllerWithIdentifier("To_FromVC") as To_FromVC
        
        // Assign message details
        detail.to = sentMessageMgr.messages[indexPath.row].receiver
        detail.messageToDisplay = sentMessageMgr.messages[indexPath.row].content
        
        // Programmatically push to associated VC (To-FromVC)
        self.navigationController?.pushViewController(detail, animated: true)
        
        
        /*
        // Get the row data for the selected row
        messageToEdit = draftsMessageMgr.messages[indexPath.row]
        indexToEdit = indexPath.row
        
        var alert: UIAlertView = UIAlertView()
        alert.title = "Message selected"
        //alert.message = "Now you can Edit"
        alert.addButtonWithTitle("Ok")
        alert.show()*/
        
    }

}
