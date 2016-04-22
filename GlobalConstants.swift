//
//  GlobalConstants.swift
//  SDLApp
//
//  Created by essadmin on 4/20/16.
//  Copyright © 2016 Baibhav. All rights reserved.
//

import Foundation



//e.g. Call like this K.App.AppIconFileName

struct k {

    struct Platform {
        
        static var isSimulator: Bool {
            return TARGET_OS_SIMULATOR != 0 // Use this line in Xcode 7 or newer
            return TARGET_IPHONE_SIMULATOR != 0 // Use this line in Xcode 6
        }
        
    }

    
    //MARK: Notifications used to show/hide lockscreen in the AppDelegate
    struct NotificationKey {
        static let HSDLDisconnectNotification = "com.sdl.notification.sdldisconnect"
        static let HSDLLockScreenStatusNotification = "com.sdl.notification.sdlchangeLockScreenStatus"
        static let HSDLNotificationUserInfoObject = "com.sdl.notification.keys.sdlnotificationObject"
    }
    
    //MARK: App configuration
    struct AppConfiguration{
        
        static let IconFile = "SDLAppIcon"
        static let SDLRequestKey = "request"
        static let AppName = "Hello Swift"
        static let AppId = "1775697552"
        static let ShortAppName = "Hello Swift"
        static let AppVrSynonym = "1775697552"
        static let AppIsMediaApp = false
        
        static let WelcomeShow = "Welcome to Hello Swift"
        static let WelcomeSpeak = "Welcome to Hello Swift"
    }
    
    //MARK: Connection Type
    struct SDLConnection {
        static let SDLConnectionTypeStringiAP = "iAP"
        static let SDLConnectionTypeStringTCP = "TCP"
    }
    
    //MARK: App Type
    struct SDLAppType {
        static let SDLAppTypeStringMedia = "Media"
        static let SDLAppTypeStringNonMedia = "Non-Media"
        static let SDLAppTypeStringNavigation = "Navigation"
    }
    
    
    
}

enum SDLConnectionType:Int {
    case SDLConnectionTypeiAP = 0
    case SDLConnectionTypeTCP
    case SDLConnectionTypeUnknown
}

enum SDLProtocol:Int {
    case SDLConnectionTypeiAP = 0
    case SDLConnectionTypeTCP
    case SDLConnectionTypeUnknown
}

enum SDLSimulatorProtocol:Int {
    case tcps = 0
    case tcpl
}


