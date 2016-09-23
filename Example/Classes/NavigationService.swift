//
//  NavigationService.swift
//  ExampleApp
//
//  Created by Miran Brajsa on 07/04/16.
//  Copyright © 2016 Five Agency. All rights reserved.
//

import FiveUtils
import Foundation
import UIKit

class NavigationService {

    func pushInitalViewController(window: UIWindow) {
        let homeViewModel = HomeViewModel(networkActivityController: FiveNetworkActivityController.shared)
        let homeViewController = HomeViewController(viewModel: homeViewModel)

        let navigationController = UINavigationController(rootViewController: homeViewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
