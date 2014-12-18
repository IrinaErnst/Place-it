//
//  DraftsViewController.swift
//  Place-it
//
//  Created by Ilona Michalowska on 11/5/14.
//  Copyright (c) 2014 Ilona Michalowska & Irina Kalashnikova. All rights reserved.
//

import UIKit

class DraftsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var CancelBarButton: UINavigationItem!
    @IBOutlet weak var DraftsMessagesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Drafts"

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /* Segue
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if (segue.identifier == "toPlaceItViewCtrlr") {
            var svc = segue!.destinationViewController as Place_itViewController
            svc.toPass = messageToEdit
        }
    }*/
    
    
    // Returning to View--Update the list of messages:
    override func viewWillAppear(animated: Bool) {
        DraftsMessagesTableView.reloadData()
    }
    
    
    // Optional function for UITableViewDelegate--Delete functionality for the table:
    // After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
    // Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            
            var tempMessage: message = draftsMessageMgr.removeMessage(indexPath.row)
            
            // Append tempMessage to Trash array
            trashMessageMgr.addMessage(tempMessage.sender, receiver_arg: tempMessage.receiver, place_arg: tempMessage.place, time_arg: tempMessage.time, content_arg: tempMessage.content, timeOfCreating_arg: tempMessage.timeOfCreating, ID_arg: tempMessage.ID)
            
            //Update the Table View:
            DraftsMessagesTableView.reloadData()
        }
    }
    
    
    // Mandatory function for UITableViewDataSource (tell the table how many rows it needs to render):
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return draftsMessageMgr.messages.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    
    // Mandatory function for UITableViewDataSource (create cells in the table)
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell_d: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "test")
        
        // might be incorrect...
        cell_d.textLabel?.text = draftsMessageMgr.messages[indexPath.row].receiver
        cell_d.detailTextLabel?.text = draftsMessageMgr.messages[indexPath.row].content
        cell_d.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell_d
    }
    
    
    // Select & Display
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        // Create an Instance of NavPlace_itViewController:
        var detail: NavPlace_itViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NavPlace_itViewController") as NavPlace_itViewController
        
        // Assign message details
        detail.From = draftsMessageMgr.messages[indexPath.row].sender
        detail.To = draftsMessageMgr.messages[indexPath.row].receiver
        detail.Where = draftsMessageMgr.messages[indexPath.row].place
        detail.When = draftsMessageMgr.messages[indexPath.row].time
        detail.What = draftsMessageMgr.messages[indexPath.row].content
        // Here don't pass the time of creating, it will be modified in the next view...
        
        draftsMessageMgr.removeMessage(indexPath.row)
        
        // Programmatically push to associated VC (Nav_Place_itViewCOntroller)
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
    
    
    // Events
    /*@IBAction func EditButton_Clicked(sender: AnyObject) {
    // if message is not selected: display notification: select message
    
    /*var alert: UIAlertView = UIAlertView()
    alert.title = "Select Message!"
    alert.addButtonWithTitle("Ok")
    alert.show()*/
    
    // else if message is selected, do the following:
    // Delete message from drafts
    messageToEdit = draftsMessageMgr.messages.removeAtIndex(indexToEdit)
    
    performSegueWithIdentifier("toPlaceItViewCtrlr", sender: self)
    }*/

}
