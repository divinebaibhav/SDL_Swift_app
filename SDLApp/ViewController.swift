//
//  ViewController.swift
//  SDLApp
//
//  Created by essadmin on 4/20/16.
//  Copyright © 2016 Baibhav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var txtConnectionType:BTextField?
    
    //MARK:View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtConnectionType!.elements = ["TCP","iAP"]
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:Private Methods
    func sdl_registerForLockScreenNotifications()
    {
        let notification = NSNotificationCenter.defaultCenter()
        notification.addObserver(self, selector: "didChangeLockScreenStatus:", name: k.NotificationKey.HSDLLockScreenStatusNotification, object: nil)
         notification.addObserver(self, selector: "proxyDidDisconnect:", name: k.NotificationKey.HSDLDisconnectNotification, object: nil)
    
    }
    
    func didChangeLockScreenStatus(notif:NSNotification)
    {
//        lblStatus.text = "Connected"
    }
    func proxyDidDisconnect(notif:NSNotification)
    {
        //lblStatus.text = "DisConnected"

    }
    
    @IBAction func tapConnect(sender: AnyObject) {
        SDLManager .sharedManager.startProxy()
        sdl_registerForLockScreenNotifications()

    }
    

}

