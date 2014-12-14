//
//  BeaconTranslator.swift
//  Place-it
//
//  Created by Ilona Michalowska on 12/14/14.
//  Copyright (c) 2014 Ilona Michalowska & Irina Kalashnikova. All rights reserved.
//

import UIKit

class BeaconTranslator: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
   
        $redis.set("B9407F30-F5F8-466E-AFF9-25556B57FE6D:43875:58414", "Green")
        $redis.set("B9407F30-F5F8-466E-AFF9-25556B57FE6D:61334:32857", "Purple")
        $redis.set("B9407F30-F5F8-466E-AFF9-25556B57FE6D:21137:30314", "Blue")
    
   
    1- green, 2 - purple, 3- blue?
  
    UUID:  B9407F30-F5F8-466E-AFF9-25556B57FE6D
    Major value: 43875
    Minor value: 58414
    
    */

}
