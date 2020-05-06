//
//  LoadBuilder.swift
//  Kinedu-ios
//
//  Created by David Trejo on 3/31/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import UIKit

enum LoadBuilder {
    static func build() -> UIViewController {
        let viewController = LoadViewController.instantiate(from: .load)
        let router = LoadRouter(viewController: viewController)
        viewController.configure(with: LoadViewModel(apiService: ApiService(), router: router))
        return viewController
    }
}
