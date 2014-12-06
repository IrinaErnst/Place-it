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
    // outlet for real time
    
    
    var To: String = ""
    var From: String = ""
    var Where: String = ""
    var When: String = ""
    var What: String = ""
    var realTime: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display message (& details)
        ToDisplayLabel.text = To
        FromDisplayLabel.text = From
        PlaceDisplayLabel.text = Where
        TimeDisplayLabel.text = When
        MessageTextView.text = What
        // Display time of creation:
        // sth ??? = realTime
        
        // Assign NavBar title
        self.title = To

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
