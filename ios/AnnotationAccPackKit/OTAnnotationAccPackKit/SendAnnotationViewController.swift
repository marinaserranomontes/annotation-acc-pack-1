//
//  SendAnnotationViewController.swift
//
//  Copyright © 2016 Tokbox, Inc. All rights reserved.
//

import Foundation

class SendAnnotationViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sharer = OTScreenSharer.sharedInstance()
        sharer.connectWithView(UIApplication.sharedApplication().keyWindow!.rootViewController!.view) {(signal: ScreenShareSignal, error: NSError!) in
            
            if error == nil {
                sharer.publishAudio = false
                sharer.publishVideo = false
            }
        }
    }
}
