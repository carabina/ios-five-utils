//
//  AppDelegate.swift
//  FiveUtils
//
//  Created by Miran Brajsa on 09/17/2016.
//  Copyright © 2016 Five Agency. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }

        let navigationService = NavigationService()
        navigationService.pushInitalViewController(window: window)
        return true
    }

}
