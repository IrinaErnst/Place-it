//
//  DraftsViewController.swift
//  Place-it
//
//  Created by Ilona Michalowska on 11/5/14.
//  Copyright (c) 2014 Ilona Michalowska & Irina Kalashnikova. All rights reserved.
//

import UIKit

class DraftsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var EditButton: UIButton!
    @IBOutlet weak var DraftsMessagesTableView: UITableView!
    @IBOutlet weak var DraftsLabel: UILabel!
    
    var messageToEdit: message = message()
    var indexToEdit: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if (segue.identifier == "toPlaceItViewCtrlr") {
            var svc = segue!.destinationViewController as Place_itViewController
            svc.toPass = messageToEdit
        }
    }
    
    
    // Returning to View--Update the list of messages:
    override func viewWillAppear(animated: Bool) {
        DraftsMessagesTableView.reloadData()
    }
    
    
    // Optional function for UITableViewDelegate--Delete functionality for the table:
    // After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
    // Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            
            var tempMessage: message = draftsMessageMgr.messages.removeAtIndex(indexPath.row)
            
            // Append tempMessage to Trash array
            trashMessageMgr.addMessage(tempMessage.receiver, place_arg: tempMessage.place, content_arg: tempMessage.content)
            
            //Update the Table View:
            DraftsMessagesTableView.reloadData()
        }
    }
    
    // Select & Edit
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        // Get the row data for the selected row
        messageToEdit = draftsMessageMgr.messages[indexPath.row]
        indexToEdit = indexPath.row
        
        var alert: UIAlertView = UIAlertView()
        alert.title = "Message selected"
        //alert.message = "Now you can Edit"
        alert.addButtonWithTitle("Ok")
        alert.show()
        
    }
    
   
    // Events
    @IBAction func EditButton_Clicked(sender: AnyObject) {
        // if message is no selected: display notification: select message
        
        /*var alert: UIAlertView = UIAlertView()
        alert.title = "Select Message!"
        alert.addButtonWithTitle("Ok")
        alert.show()*/
        
        // else if message is selected, do the following:
        // Delete message from drafts
        messageToEdit = draftsMessageMgr.messages.removeAtIndex(indexToEdit)

        performSegueWithIdentifier("toPlaceItViewCtrlr", sender: self)
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
        cell_d.textLabel.text = draftsMessageMgr.messages[indexPath.row].receiver
        cell_d.detailTextLabel?.text = draftsMessageMgr.messages[indexPath.row].content
        //need to do sth with the place member variable & optionally date
        
        return cell_d
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
