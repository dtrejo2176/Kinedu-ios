//
//  ScoreDetailRouter.swift
//  Kinedu-ios
//
//  Created by David Trejo on 3/28/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import UIKit

class ScoreDetailRouter: Router {
    internal weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
