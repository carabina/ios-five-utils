//
//  HomeViewModel.swift
//  Example
//
//  Created by Miran Brajsa on 20/09/16.
//  Copyright © 2016 Five Agency. All rights reserved.
//

import Foundation
import FiveUtils

class HomeViewModel {

    private let networkActivityController: FiveNetworkActivityController
    private let cellTypes: [ContentCellType] = [
        .randomGenerator,
        .networkActivityController,
        .safeArray,
        .randomArrayElement,
        .clampedValue,
        .linearlyInterpolatedValue
    ]

    var cellCount: Int {
        return cellTypes.count
    }

    init(networkActivityController: FiveNetworkActivityController) {
        self.networkActivityController = networkActivityController
    }

    func cellViewModel(atIndex index: Int) -> ContentCellViewModel {
        return ContentCellViewModel(
            withType: cellTypes[index],
            index: index,
            networkActivityController: networkActivityController
        )
    }
}
