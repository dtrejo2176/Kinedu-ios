//
//  ScoreDetailViewModel.swift
//  Kinedu-ios
//
//  Created by David Trejo on 3/28/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import Foundation
import Bond

private enum Strings {
    static let users = "of the users that answered"
    static let npsScore = "in their nps saw"
    static let activities = "activities"
}

struct ScoreDetailViewModelDataSource {
    let npsArray: [Nps]
    let version: String
}

class ScoreDetailViewModel {
    private let router: ScoreDetailRouter
    private let npsArray: [Nps]
    private let npsGradeDictionary: [Int: [Nps]]
    private let sortedGrades = Observable<[Int]>([])
    private let gradeImages: [UIImage?]
    let version: String
    var grades = Observable<[ScoreDetailCellViewModelDataSource]>([])
    var currentItem = Observable<Int>(0)
    var currentIndexPath = IndexPath(row: 0, section: 0)
    var fremiumUsers = Observable<String?>("0")
    var premiumUsers = Observable<String?>("0")
    var activityMessage = Observable<NSAttributedString?>(nil)
    
    var mutableAttributedString = NSMutableAttributedString()
    let percentageAttribute = [
        NSAttributedString.Key.font: UIFont.gothamFont(withWeight: .bold, andSize: 16.0),
        NSAttributedString.Key.foregroundColor: UIColor.kineduGreen
    ]
    let regularAttribute = [
        NSAttributedString.Key.font: UIFont.gothamFont(withWeight: .medium, andSize: 14.0),
        NSAttributedString.Key.foregroundColor: UIColor.white
    ]
    let activityAttribute = [
        NSAttributedString.Key.font: UIFont.gothamFont(withWeight: .bold, andSize: 16.0),
        NSAttributedString.Key.foregroundColor: UIColor.kineduLightBlue
    ]

    init(dataSource: ScoreDetailViewModelDataSource, router: ScoreDetailRouter) {
        self.router = router
        npsArray = dataSource.npsArray
        version = dataSource.version
        gradeImages = [#imageLiteral(resourceName: "baby_0"), #imageLiteral(resourceName: "baby_1"), #imageLiteral(resourceName: "baby_2"), #imageLiteral(resourceName: "baby_3"), #imageLiteral(resourceName: "baby_4"), #imageLiteral(resourceName: "baby_5"), #imageLiteral(resourceName: "baby_6"), #imageLiteral(resourceName: "baby_7"), #imageLiteral(resourceName: "baby_8"), #imageLiteral(resourceName: "baby_9"), #imageLiteral(resourceName: "baby_10")]
        npsGradeDictionary = Dictionary(grouping: npsArray, by: { $0.nps })
        sortedGrades.value = Array(npsGradeDictionary.keys.sorted())
        _ = grades.bind(signal: sortedGrades.toSignal().map { [weak self] sortedGrades in
            guard let `self` = self else { return [] }
            return sortedGrades.map {
                ScoreDetailCellViewModelDataSource(grade: $0,
                                                   image: self.gradeImages[$0])
            }
        })
        _ = currentItem.observeNext { [weak self ] index in
            guard let `self` = self else { return }
            self.currentIndexPath.row = index
            let currentGrades = self.npsArray.filter { $0.nps == index }
            let freemiumCount = currentGrades.filter { $0.userPlan == "freemium" }.count
            self.fremiumUsers.value = freemiumCount <= 9 ? "0\(freemiumCount)" : "\(freemiumCount)"
            let premiumCount = currentGrades.filter { $0.userPlan == "premium" }.count
            self.premiumUsers.value = premiumCount <= 9 ? "0\(premiumCount)" : "\(premiumCount)"
            self.calculateHighestActivity(gradeArray: currentGrades)
        }
    }
    
    func onBack() {
        router.routeBack()
    }
}

private extension ScoreDetailViewModel {
    func calculateHighestActivity(gradeArray: [Nps]) {
        var counts = [Int: Int]()
        gradeArray.forEach { counts[$0.activityViews] = (counts[$0.activityViews] ?? 0) + 1 }
        
        if let (value, count) = counts.max(by: {$0.1 < $1.1}) {
            let percentage = count*100/gradeArray.count
            let percentageAttributedString = NSAttributedString(string: "\(percentage)%",
                attributes: percentageAttribute)
            let regularAttributedString = NSAttributedString(string: " \(Strings.users) \(currentItem.value) \(Strings.npsScore) ", attributes: regularAttribute)
            let activityAttributedString = NSAttributedString(string: "\(value) \(Strings.activities)", attributes: activityAttribute)
            mutableAttributedString = NSMutableAttributedString()
            mutableAttributedString.append(percentageAttributedString)
            mutableAttributedString.append(regularAttributedString)
            mutableAttributedString.append(activityAttributedString)
            activityMessage.value = mutableAttributedString
        }
    }
}
