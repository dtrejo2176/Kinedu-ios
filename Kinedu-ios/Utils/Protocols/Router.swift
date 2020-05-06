//
//  Router.swift
//  KineduPOC
//
//  Created by David Trejo on 3/27/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import UIKit

protocol Router {
    var viewController: UIViewController? { get }
    func routeBack()
}

extension Router {
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func push(viewController: UIViewController) {
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pop() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
