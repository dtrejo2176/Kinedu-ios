//
//  NavigationController+Kinedu.swift
//  KineduPOC
//
//  Created by David Trejo on 3/28/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import UIKit

enum NavigationBarStyle {
    case clear
    case blue
}

protocol ViewControllerNavigationStyle {
    var navigationBarStyle: NavigationBarStyle { get }
}

class KineduNavigationController: UINavigationController {
    static func navigationController() -> KineduNavigationController {
        let navController = KineduNavigationController()
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.tintColor = .white
        let textAttributes = [
            NSAttributedString.Key.font: UIFont.gothamFont(withWeight: .medium, andSize: 17.0),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navController.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        navController.delegate = navController
        return navController
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return viewControllers.last?.preferredStatusBarStyle ?? .default
    }
    
    func adjustNavigationBar(forViewController viewController: UIViewController) {
        if let viewControllerNavigationStyle = viewController as? ViewControllerNavigationStyle {
            adjustNavigationBar(forStyle: viewControllerNavigationStyle.navigationBarStyle)
        } else {
            adjustNavigationBar(forStyle: .clear)
        }
        setNeedsStatusBarAppearanceUpdate()
    }
}

extension KineduNavigationController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        adjustNavigationBar(forViewController: viewController)
    }
    
    private func adjustNavigationBar(forStyle style: NavigationBarStyle) {
        let textColor: UIColor
        switch style {
        case .clear:
            textColor = .gray
            navigationBar.barTintColor = .clear
            navigationBar.isTranslucent = true
            navigationBar.setBackgroundImage(UIImage(), for: .default)
        case .blue:
            textColor = .white
            navigationBar.barTintColor = .kineduBlue
            navigationBar.isTranslucent = false
        }
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: textColor
        ]
        navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
    }
}
