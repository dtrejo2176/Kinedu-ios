//
//  ViewController.swift
//  Kinedu-ios
//
//  Created by David Trejo on 3/28/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import UIKit

class LoadViewController: UIViewController, StoryboardInstanciable {
    
    private var viewModel: LoadViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func configure(with viewModel: LoadViewModel) {
        self.viewModel = viewModel
    }
}

extension LoadViewController: ViewControllerNavigationStyle {
    var navigationBarStyle: NavigationBarStyle {
        return .clear
    }
}
