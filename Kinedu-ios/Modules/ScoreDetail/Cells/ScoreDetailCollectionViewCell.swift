//
//  ScoreDetailCollectionViewCell.swift
//  Kinedu-ios
//
//  Created by David Trejo on 3/29/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import UIKit

class ScoreDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var roundedView: RoundedView!
    @IBOutlet private weak var gradeImageView: UIImageView!
    @IBOutlet private weak var gradeLabel: UILabel!

    private(set) var viewModel: ScoreDetailCellViewModel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag.dispose()
    }
    
    func configure(with viewModel: ScoreDetailCellViewModel) {
        self.viewModel = viewModel
        configure()
    }
    
    func updateSelection(isSelected: Bool) {
        viewModel.isSelected.value = isSelected
    }
    
    private func configure() {
        viewModel.gradeImage.bind(to: gradeImageView)
        viewModel.grade.bind(to: gradeLabel)
        _ = viewModel.gradeBorderWidth.observeNext { [weak self] in
            self?.roundedView.borderWidth = $0
        }
    }
}
