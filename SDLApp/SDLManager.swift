//
//  SDLManager.swift
//  SDLApp
//
//  Created by essadmin on 4/20/16.
//  Copyright © 2016 Baibhav. All rights reserved.
//

import UIKit


class SDLManager: NSObject,SDLProxyListener {

    static let sharedManager:SDLManager = SDLManager()
    
    var  proxy: SDLProxy = SDLProxy();
    let correlationID:Int = 0
    let nextCorrelationID:Int = 0
    var firstHmiFull:Bool = true;
    var firstHmiNotNone:Bool = true;
    var vehicleDataSubscribed:Bool = true;
    var graphicsSupported:Bool = false
    var remoteImages: NSMutableSet =  NSMutableSet()

    
    override init() {
        super.init()
    }
    
    var isFirstHmiFull:Bool {
        get{
            return firstHmiFull
        }
    }
    
    var isFirstHmiNotNone:Bool {
        get{
            return firstHmiNotNone
        }
    }
    var isVehicleDataSubscribed:Bool {
        get{
            return firstHmiNotNone
        }
    }

   
    //1st Method to be called
    func startProxy()
    {
        if k.Platform.isSimulator {
            savePreferences()
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            switch prefs.objectForKey("protocol") as! String
            {
                case "tcpl":
                proxy = SDLProxyFactory .buildSDLProxyWithListener(self, tcpIPAddress: nil, tcpPort: prefs.objectForKey("port") as! String)
                break
                
                case "tcps":
                 proxy = SDLProxyFactory .buildSDLProxyWithListener(self, tcpIPAddress: prefs.objectForKey("ipaddress") as! String, tcpPort: prefs.objectForKey("port") as! String)
                 break;
                
                default:
                    proxy = SDLProxyFactory.buildSDLProxyWithListener(self)
                break
            }
        }
        else{
            NSLog("This is device mode....");
            proxy = SDLProxyFactory.buildSDLProxyWithListener(self)
         }

    }
    
    /**
    *  Delegate method that runs when driver distraction mode changes.
    */
    func onOnDriverDistraction(notification: SDLOnDriverDistraction!) {
        
    }
    
    
    /**
     *     //3rd Method to be called
     *  Delegate method that runs when the app's HMI state on SDL changes.
     */
    func onOnHMIStatus(notification: SDLOnHMIStatus!) {
        
//        OnHMIStatus (notification)
//            {
//                audioStreamingState = "NOT_AUDIBLE";
//                hmiLevel = NONE;
//                systemContext = MAIN;
//        }
    }
    
    
    /**
    *  2nd Method to be called
    *  onProxyOpened is called when a connection is established between the head
    * unit and your application.
    */
    func onProxyOpened() {
        NSLog("This is onProxyOpened....");
        
        let registerAppInterface:SDLRegisterAppInterface = SDLRPCRequestFactory .buildRegisterAppInterfaceWithAppName(k.AppConfiguration.AppName, isMediaApp: k.AppConfiguration.AppIsMediaApp, languageDesired: SDLLanguage.EN_US(), appID: k.AppConfiguration.AppId)
        registerAppInterface.ngnMediaScreenAppName = k.AppConfiguration.ShortAppName;
        let obj = SDLTTSChunkFactory .buildTTSChunkForString(k.AppConfiguration.AppName, type: SDLSpeechCapabilities.TEXT())
        let ttsName:NSMutableArray  = NSMutableArray()
        ttsName.addObject(obj)
        registerAppInterface.ttsName = ttsName
        self.proxy .sendRPC(registerAppInterface)

    }
    
    /**
     *  Delegate method that runs on disconnect from SDL.
     *  Req. if a connection disconnects for any reason,
     */
    func onProxyClosed() {
        
        // Notify the app delegate to clear the lockscreen
     hsdl_postNotification(k.NotificationKey.HSDLDisconnectNotification, info: [])
      self.proxy.dispose()

    }
    
    
    
    /**
    *  Posts SDL notifications.
    *
    *  @param name The name of the SDL notification
    *  @param info The data associated with the notification
    */
    
    func hsdl_postNotification(name:String, info:AnyObject)
    {
        var userInfo:NSDictionary = NSDictionary()
        if isNotNSNull(info) {
            userInfo = [
                k.NotificationKey.HSDLNotificationUserInfoObject : info
            ]
        }
        NSNotificationCenter.defaultCenter().postNotificationName(name, object: self, userInfo: userInfo as [NSObject : AnyObject])
        
    }
}



//MARk: Utils
extension SDLManager
{
    func isNotNull(object:AnyObject?) -> Bool {
        guard let object = object else {
            return false
        }
        return (isNotNSNull(object) && isNotStringNull(object))
    }
    
    func isNotNSNull(object:AnyObject) -> Bool {
        return object.classForCoder != NSNull.classForCoder()
    }
    
    func isNotStringNull(object:AnyObject) -> Bool {
        if let object = object as? String where object.uppercaseString == "NULL" {
            return false
        }
        return true
    }
    
    func savePreferences()
    {
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs .setObject("tcps", forKey: "protocol")
        prefs .setObject("132.132.5.234", forKey: "ipaddress")
        prefs .setObject("12345", forKey: "port")
        prefs .setObject("False", forKey: "firstRun")
        prefs.synchronize()
    }

    
}

