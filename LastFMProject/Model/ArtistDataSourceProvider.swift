//
//  ArtistDataSourceProvider.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 02.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
import UIKit

public class ArtistDataSourceProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    struct Constants {
        static let cellIdentifier = "artistCellID"
        static let segueIdentifier = "showTopAlbums"
    }

    private let dataManager: ArtistDataManager
    var selectedIndexPath = IndexPath()

    init(dataManager: ArtistDataManager) {
        self.dataManager = dataManager
        super.init()
    }

    // MARK: - UITableViewDataSource

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { dataManager.itemsCount }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! ArtistCell
        let item = dataManager.item(at: indexPath.row)
        cell.configure(with: item)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artistName = dataManager.item(at: indexPath.row).name
        AppNavigator.shared.navigate(to: .topAlbums(artistName: artistName))
    }
}
