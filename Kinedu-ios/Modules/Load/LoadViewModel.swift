//
//  ViewControllerViewModel.swift
//  Kinedu-ios
//
//  Created by David Trejo on 3/28/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import Foundation

class LoadViewModel {
    
    private var apiService: ApiService
    private var router: LoadRouter
    
    init(apiService: ApiService, router: LoadRouter) {
        self.apiService = apiService
        self.router = router
        downloadScores()
    }
}

private extension LoadViewModel {
    func downloadScores() {
        apiService.getNps { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let npsArray):
                let array = npsArray.map { $0.npsAux }
                print("Loaded \(array.count) elements")
                let dataSource = NpsScoreViewModelDataSource(npsArray: array)
                self.router.routeToScore(dataSource: dataSource)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
