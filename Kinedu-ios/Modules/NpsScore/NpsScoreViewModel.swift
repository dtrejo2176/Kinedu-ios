//
//  NpsScoreViewModel.swift
//  Kinedu-ios
//
//  Created by David Trejo on 3/28/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import Foundation
import Bond

private enum Strings {
    static let users = "Out of"
}

struct NpsScoreViewModelDataSource {
    let npsArray: [Nps]
}

enum AppVersion: String {
    case version_3_2_2 = "3.2.2"
    case version_3_2_1 = "3.2.1"
    case version_3_1_12 = "3.1.12"
}

class NpsScoreViewModel {
    private let router: NpsScoreRouter
    private let npsArray: [Nps]
    let npsVersionDictionary: [String: [Nps]]
    var currentVersion: AppVersion = .version_3_1_12
    var selectedVersion = Observable<Int?>(0)
    var freemiumNpsScore = Observable<Int>(0)
    var freemiumTextScore = Observable<String?>(nil)
    var freemiumColor = Observable<UIColor?>(nil)
    var freemiumUsers = Observable<String?>(nil)
    var premiumNpsScore = Observable<Int>(0)
    var premiumTextScore = Observable<String?>(nil)
    var premiumColor = Observable<UIColor?>(nil)
    var premiumUsers = Observable<String?>(nil)
    var freemiumUserCount = 0
    var premiumUserCount = 0
    
    init(dataSource: NpsScoreViewModelDataSource, router: NpsScoreRouter) {
        self.router = router
        npsArray = dataSource.npsArray
        npsVersionDictionary = Dictionary(grouping: npsArray, by: {$0.build.version} )
        configureBindings()
    }
    
    func onMoreDetails() {
        if let filteredByVersion = npsVersionDictionary[currentVersion.rawValue] {
            let dataSource = ScoreDetailViewModelDataSource(npsArray: filteredByVersion,
                                                            version: currentVersion.rawValue)
            router.routeToDetail(dataSource: dataSource)
        }
    }
}

private extension NpsScoreViewModel {
    func configureBindings() {
        _ = selectedVersion.observeNext { [weak self] version in
            guard let `self` = self else { return }
            switch version {
            case 0:
                self.currentVersion = .version_3_2_2
            case 1:
                self.currentVersion = .version_3_2_1
            default:
                self.currentVersion = .version_3_1_12
            }
            if let filteredByVersion = self.npsVersionDictionary[self.currentVersion.rawValue] {
                let freemiumArray = filteredByVersion.filter { $0.userPlan == "freemium" }
                self.freemiumUsers.value = "\(Strings.users) \(freemiumArray.count) users"
                self.freemiumNpsScore.value = self.getNpsScore(from: freemiumArray)
                self.freemiumColor.value = ScoreColorHelper.color(forScore: self.freemiumNpsScore.value)
                self.freemiumTextScore.value = "\(self.freemiumNpsScore.value)"
                let premiumArray = filteredByVersion.filter { $0.userPlan == "premium" }
                self.premiumUsers.value = "\(Strings.users) \(premiumArray.count) users"
                self.premiumNpsScore.value = self.getNpsScore(from: premiumArray)
                self.premiumColor.value = ScoreColorHelper.color(forScore: self.premiumNpsScore.value)
                self.premiumTextScore.value = "\(self.premiumNpsScore.value)"
            }
        }
    }
    
    func getNpsScore(from npsArray: [Nps]) -> Int {
        let totalUsers = npsArray.count
        let promoters = npsArray.filter { $0.nps >= 9 }.count
        let detractors = npsArray.filter { $0.nps <= 6 }.count
        let score = (promoters*100)/totalUsers - (detractors*100)/totalUsers
        return score
    }
}
