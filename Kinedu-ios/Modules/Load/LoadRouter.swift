//
//  ViewControllerRouter.swift
//  Kinedu-ios
//
//  Created by David Trejo on 3/28/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import UIKit

class LoadRouter: Router {
    internal weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func routeToScore(dataSource: NpsScoreViewModelDataSource) {
        let scoreViewController = NpsScoreBuilder.build(with: dataSource)
        push(viewController: scoreViewController)
    }
}
