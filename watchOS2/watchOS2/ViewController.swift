//
//  ViewController.swift
//  watchOS2
//
//  Created by Daniel Mathews on 2015-10-13.
//  Copyright © 2015 Daniel Mathews. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {

    var session: WCSession!
    @IBOutlet weak var messageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Swift
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        //handle received message
        
        if let messageTest = message["Message"] as? String {
            messageLabel.text = messageTest
        }
        
        replyHandler(["Reply":"Hello from my iPhone"])
        
    }

}

