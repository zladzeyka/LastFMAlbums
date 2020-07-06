//
//  AlbumDataSourceManager.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 04.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
import UIKit

class AlbumDataSourceManager :NSObject, UITableViewDataSource {
    struct Constants {
        static let cellIdentifier = "trackCellID"
    }
    
    private let dataManager: AlbumDataManager

    init(dataManager: AlbumDataManager) {
        self.dataManager = dataManager
        super.init()
    }
    
    // MARK: - UITableViewDataSource

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {  dataManager.itemsCount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! TrackCell
        let item = dataManager.item(at: indexPath.row)
        cell.configure(with: item)
        return cell
    }
}
