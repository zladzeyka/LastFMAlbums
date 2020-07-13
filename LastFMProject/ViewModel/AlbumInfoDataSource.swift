//
//  AlbumDataSourceManager.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 04.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
import UIKit

class AlbumInfoDataSource : GenericDataSource<AlbumInfo> {
    struct Constants {
        static let cellIdentifier = "trackCellID"
    }
    var albumName = ""
    var artistName = ""
    var coverUrlString = ""
    
}

// MARK: - UITableViewDataSource

extension AlbumInfoDataSource: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data.value.count > 0 {
            let album = data.value[0]
            let tracks = album.album.tracks.track
            return tracks?.count ?? 0
        }
        return 0
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! TrackCell
        let album = data.value[0] as AlbumInfo
        let track = album.album.tracks.track?[indexPath.row] ?? Track(name: "", duration: "")
        cell.configure(with: track)
        return cell
    }
}
