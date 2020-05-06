//
//  ScoreDetailViewController.swift
//  Kinedu-ios
//
//  Created by David Trejo on 3/28/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import UIKit

private enum Strings {
    static let screenTitle = "NPS Detail"
    static let kGradeCollectionViewCellReuseIdentifier = "GradeCollectionViewCell"
}

class ScoreDetailViewController: UIViewController, StoryboardInstanciable {
    
    @IBOutlet private weak var gradesCollectionView: KineduCollectionView!
    @IBOutlet private weak var fremiumUsersLabel: UILabel!
    @IBOutlet private weak var premiumUsersLabel: UILabel!
    @IBOutlet private weak var activiesLabel: UILabel!
    
    private var viewModel: ScoreDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let cell = gradesCollectionView.cellForItem(at: viewModel.currentIndexPath) as! ScoreDetailCollectionViewCell
        cell.updateSelection(isSelected: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func configure(with viewModel: ScoreDetailViewModel) {
        self.viewModel = viewModel
    }
}

extension ScoreDetailViewController: ViewControllerNavigationStyle {
    var navigationBarStyle: NavigationBarStyle {
        return .blue
    }
}

private extension ScoreDetailViewController {
    func configure() {
        title = "\(Strings.screenTitle) \(viewModel.version)"
        navigationItem.leftBarButtonItem = UIBarButtonItem.backBarButtonItem(withColor: .white) { [weak self] in
            self?.viewModel.onBack()
        }
        gradesCollectionView.collectionViewLayout = KineduPagedFlowLayout()
        gradesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        gradesCollectionView.showsHorizontalScrollIndicator = false
        viewModel.grades.bind(to: gradesCollectionView) { (grades, indexPath, collectionView) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.kGradeCollectionViewCellReuseIdentifier, for: indexPath) as! ScoreDetailCollectionViewCell
            cell.configure(with: ScoreDetailCellViewModel(dataSource: grades[indexPath.row]))
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            return cell
        }
        viewModel.fremiumUsers.bind(to: fremiumUsersLabel)
        viewModel.premiumUsers.bind(to: premiumUsersLabel)
        _ = activiesLabel.reactive.attributedText.bind(signal: viewModel.activityMessage.toSignal())
    }
}

extension ScoreDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 128)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let cell = gradesCollectionView.cellForItem(at: viewModel.currentIndexPath) as! ScoreDetailCollectionViewCell
        cell.updateSelection(isSelected: false)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView:UIScrollView) {
        let midX:CGFloat = scrollView.bounds.midX
        let midY:CGFloat = scrollView.bounds.midY
        let point:CGPoint = CGPoint(x:midX, y:midY)

        guard let indexPath:IndexPath = gradesCollectionView.indexPathForItem(at:point) else { return }

        let newPage:Int = indexPath.item
        viewModel.currentItem.value = newPage
        
        let cell = gradesCollectionView.cellForItem(at: indexPath) as! ScoreDetailCollectionViewCell
        cell.updateSelection(isSelected: true)
    }
}
