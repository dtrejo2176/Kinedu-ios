//
//  ScoreDetailBuilder.swift
//  Kinedu-ios
//
//  Created by David Trejo on 3/28/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import UIKit

enum ScoreDetailBuilder {
    static func build(with dataSource: ScoreDetailViewModelDataSource) -> UIViewController {
        let viewController = ScoreDetailViewController.instantiate(from: .detail)
        let router = ScoreDetailRouter(viewController: viewController)
        viewController.configure(with: ScoreDetailViewModel(dataSource: dataSource, router: router))
        return viewController
    }
}
