//
//  To-FromVC.swift
//  
//
//  Created by Ilona Michalowska on 12/4/14.
//
//

import UIKit

class To_FromVC: UIViewController {

    @IBOutlet weak var ToLabel: UILabel!
    @IBOutlet weak var ToDisplayLabel: UILabel!
    @IBOutlet weak var FromLabel: UILabel!
    @IBOutlet weak var FromDisplayLabel: UILabel!
    @IBOutlet weak var PlaceLabel: UILabel!
    @IBOutlet weak var PlaceDisplayLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var TimeDisplayLabel: UILabel!
    @IBOutlet weak var MessageTextView: UITextView!
    
    var to: String = ""
    var from: String = ""
    var place: String = ""
    var time: String = ""
    var messageToDisplay: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display message (& details)
        ToDisplayLabel.text = to
        FromDisplayLabel.text = from
        PlaceDisplayLabel.text = place
        TimeDisplayLabel.text = time
        MessageTextView.text = messageToDisplay
        
        // Assign NavBar title
        self.title = to

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
