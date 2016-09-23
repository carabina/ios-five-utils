//
//  FiveNetworkActivityController.swift
//  FiveUtils
//
//  Created by Kristijan Rožanković on 13/07/16.
//  Copyright © 2016 Five Agency. All rights reserved.
//

import Foundation
import UIKit

/**
 Wrapper around UIApplication network activity indicator.
 It ensures that activity indicator cannot be hidden if there is some active task that
 requires its presence.
*/
public class FiveNetworkActivityController {
    
    public static let shared = FiveNetworkActivityController()
    private init() {}
    
    fileprivate let application = UIApplication.shared
    fileprivate var tasks = 0

    private let serialQueue = DispatchQueue(label: "activityIndicatorQueue")
    
    public var taskCount: Int {
        return tasks
    }

    /**
     Turns network activity indicator on if it wasn't previously activated.
    */
    public func startActivity() {
        serialQueue.sync(execute: startActivityWorker)
    }

    /**
     Turns network activity indicator off only if there aren't any currently active tasks.
    */
    public func endActivity() {
        serialQueue.sync(execute: endActivityWorker)
    }
}

extension FiveNetworkActivityController {

    fileprivate func startActivityWorker() {
        if application.isStatusBarHidden {
            return
        }
        application.isNetworkActivityIndicatorVisible = true
        
        tasks += 1
    }

    fileprivate func endActivityWorker() {
        if application.isStatusBarHidden {
            return
        }
        
        tasks -= 1
        
        if tasks <= 0 {
            application.isNetworkActivityIndicatorVisible = false
            tasks = 0
        }
    }
}
