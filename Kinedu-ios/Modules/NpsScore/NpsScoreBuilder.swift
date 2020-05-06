//
//  NpsScoreBuilder.swift
//  Kinedu-ios
//
//  Created by David Trejo on 3/28/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import UIKit

enum NpsScoreBuilder {
    static func build(with dataSource: NpsScoreViewModelDataSource) -> UIViewController {
        let viewController = NpsScoreViewController.instantiate(from: .scores)
        let router = NpsScoreRouter(viewController: viewController)
        viewController.configure(with: NpsScoreViewModel(dataSource: dataSource, router: router))
        return viewController
    }
}
