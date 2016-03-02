//
//  InterfaceController.swift
//  watchOS2 WatchKit Extension
//
//  Created by Daniel Mathews on 2015-10-13.
//  Copyright © 2015 Daniel Mathews. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {

    var session : WCSession!
    @IBOutlet var sentText: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        sentText.setText("Welcome iPhone from Watch")
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }
    
    @IBAction func sendText() {
        let messageToSend = ["Message":"Welcome iPhone from Watch"]
        
        session.sendMessage(messageToSend, replyHandler: { (replyDict) -> Void in
            
            if let replyText = replyDict["Reply"] as? String {
                self.sentText.setText(replyText)
            }
            
            }) { (error) -> Void in }

    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
