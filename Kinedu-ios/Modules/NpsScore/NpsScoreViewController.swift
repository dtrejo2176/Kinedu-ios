//
//  NpsScoreViewController.swift
//  Kinedu-ios
//
//  Created by David Trejo on 3/28/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import UIKit

private enum Strings {
    static let screenTitle = "Kinedu NPS Score"
}

class NpsScoreViewController: UIViewController, StoryboardInstanciable {

    @IBOutlet private weak var versionSegmentedControl: KineduSegmentedControl!
    @IBOutlet private weak var fremiumScoreLabel: UILabel!
    @IBOutlet private weak var fremiumUserCountLabel: UILabel!
    @IBOutlet private weak var premiumScoreLabel: UILabel!
    @IBOutlet private weak var premiumUserCountLabel: UILabel!
    @IBOutlet private weak var moreDetailsButton: UIButton!
    
    private var viewModel: NpsScoreViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func configure(with viewModel: NpsScoreViewModel) {
        self.viewModel = viewModel
    }
}

extension NpsScoreViewController: ViewControllerNavigationStyle {
    var navigationBarStyle: NavigationBarStyle {
        return .blue
    }
}

private extension NpsScoreViewController {
    func configure() {
        title = Strings.screenTitle
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        versionSegmentedControl.selectedSegmentIndex = 0
        versionSegmentedControl.reactive.selectedSegmentIndex.bind(to: viewModel.selectedVersion)
        viewModel.freemiumUsers.bind(to: fremiumUserCountLabel)
        viewModel.premiumUsers.bind(to: premiumUserCountLabel)
        viewModel.freemiumTextScore.bind(to: fremiumScoreLabel)
        viewModel.premiumTextScore.bind(to: premiumScoreLabel)
        _ = fremiumScoreLabel.reactive.textColor.bind(signal: viewModel.freemiumColor.toSignal())
        _ = premiumScoreLabel.reactive.textColor.bind(signal: viewModel.premiumColor.toSignal())
        _ = moreDetailsButton.reactive.tap.observeNext { [unowned self] _ in
            self.viewModel.onMoreDetails()
        }
    }
}
