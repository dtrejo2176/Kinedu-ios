//
//  CollectionView.swift
//  Kinedu-ios
//
//  Created by David Trejo on 3/30/20.
//  Copyright © 2020 David Trejo. All rights reserved.
//

import UIKit

class KineduCollectionView: UICollectionView {

    override var safeAreaInsets: UIEdgeInsets {
        return UIEdgeInsets(top: super.safeAreaInsets.top, left: 0, bottom: super.safeAreaInsets.bottom, right: 0)
    }
}
