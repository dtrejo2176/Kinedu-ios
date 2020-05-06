//
//  NpsScoreRouter.swift
//  Kinedu-ios
//
//  Created by David Trejo on 3/28/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import UIKit

class NpsScoreRouter: Router {
    internal weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func routeToDetail(dataSource: ScoreDetailViewModelDataSource) {
        let detailViewController = ScoreDetailBuilder.build(with: dataSource)
        push(viewController: detailViewController)
    }
}
