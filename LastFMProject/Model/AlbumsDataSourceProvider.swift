//
//  AlbumsDataSourceProvider.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 03.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
import UIKit

public class AlbumsDataSourceProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    struct Constants {
        static let cellIdentifier = "albumsCellID"
        static let mainStoryboard = "Main"
    }

    private let dataManager: AlbumsDataManager

    init(dataManager: AlbumsDataManager) {
        self.dataManager = dataManager
        super.init()
    }

    // MARK: - UITableViewDataSource

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { dataManager.itemsCount
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! AlbumCell
        let album = dataManager.item(at: indexPath.row)
        cell.configure(with: album)

        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = dataManager.item(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! AlbumCell
        let state = cell.buttonState
        let track = Tracks(tracks: [])
        let coverImages = album.image
        let albumObject = AlbumInfo.AlbumInfoObject(name: album.name, artist: album.artist.name, image: coverImages, tracks: track)
        let albumInfo = AlbumInfo(album: albumObject)
        AppNavigator.shared.navigate(to: .albumDetails(album: albumInfo, state:state))
    }
}
