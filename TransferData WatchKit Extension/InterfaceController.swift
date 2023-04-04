//
//  InterfaceController.swift
//  TransferData WatchKit Extension
//
//  Created by Akshay Phulare on 04/04/23.
//

import WatchKit
import Foundation
import WatchConnectivity //**1

class InterfaceController: WKInterfaceController {
  
  @IBOutlet weak var label: WKInterfaceLabel!//**2
  let session = WCSession.default//**3
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    // Configure interface objects here.
    session.delegate = self//**4
    session.activate()//**5
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  @IBAction func tapSendToiPhone() {//**6
    let data: [String: Any] = ["watch": "data from watch" as Any] //Create your dictionary as per uses
    session.sendMessage(data, replyHandler: nil, errorHandler: nil) //**6.1
  }
}

extension InterfaceController: WCSessionDelegate {
  
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
  }
  
  func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
    
    print("received data: \(message)")
    if let value = message["iPhone"] as? String {//**7.1
      self.label.setText(value)
    }
  }
}
