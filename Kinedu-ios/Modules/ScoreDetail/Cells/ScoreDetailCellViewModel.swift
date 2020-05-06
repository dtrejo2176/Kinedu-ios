//
//  ScoreDetailCellViewModel.swift
//  Kinedu-ios
//
//  Created by David Trejo on 3/29/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import UIKit
import Bond

struct ScoreDetailCellViewModelDataSource {
    let grade: Int
    let image: UIImage?
}

class ScoreDetailCellViewModel {
    let grade: Observable<String?>
    let gradeImage: Observable<UIImage?>
    var isSelected = Observable<Bool>(false)
    var gradeBorderWidth = Observable<CGFloat>(0)
    
    init(dataSource: ScoreDetailCellViewModelDataSource) {
        grade = Observable("\(dataSource.grade)")
        gradeImage = Observable(dataSource.image)
        configureBindings()
    }
}

private extension ScoreDetailCellViewModel {
    func configureBindings() {
        _ = isSelected.observeNext { [weak self] in
            guard let `self` = self else { return }
            self.gradeBorderWidth.value = $0 ? 3 : 0
        }
    }
}
