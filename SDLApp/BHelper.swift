//
//  BHelper.swift
//  SDLApp
//
//  Created by essadmin on 4/22/16.
//  Copyright © 2016 Baibhav. All rights reserved.
//

import Foundation

class BHelper {
    
    //MARK: Utils
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
}

//Get random from array
extension Array {
    func sampleItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}