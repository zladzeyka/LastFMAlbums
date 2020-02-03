//
//  SavedAlbumsDataSourceProvider.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 08.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
import UIKit
class SavedAlbumsDataSourceProvider: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    struct Constants {
        static let cellIdentifier = "savedAlbumCell"
        static let cPadding: CGFloat = 10.0
    }

    private let dataManager: SavedAlbumsDataManager

    init(dataManager: SavedAlbumsDataManager) {
        self.dataManager = dataManager
        super.init()
    }

    // MARK: - UICollectionViewDataSource

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.items.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? SavedAlbumCell {
            let item = dataManager.item(at: indexPath.row)
            cell.configure(item: item)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    // MARK: - UICollectionViewDelegate

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dataManager.item(at: indexPath.row)
        AppNavigator.shared.navigate(to: .savedAlbumDetails(albumInfo: item))
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = collectionView.frame.width - Constants.cPadding
        return CGSize(width: itemSize / 2, height: itemSize / 2)
    }
}
