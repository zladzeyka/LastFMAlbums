//
//  AppNavigator.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 09.12.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
import UIKit
class AppNavigator: Navigator {
    struct Constants {
        static let searchController = "searchArtistController"
        static let topAlbumsController = "albumsController"
        static let albumInfoController = "albumInfoController"
        static let savedAlbumsController = "savedAlbumsController"
        static let mainStoryboard = "Main"
    }

    enum Destination {
        case search
        case savedAlbumDetails(albumInfo: AlbumInfo)
        case topAlbums(artistName: String)
        case albumDetails(album: AlbumInfo, state : SaveButtonState)
    }

    static let shared = AppNavigator()
    static let window = UIApplication.shared.windows.first { $0.isKeyWindow }
    var naviController = window!.rootViewController as! UINavigationController

    // MARK: - Navigator

    func navigate(to destination: Destination) {
        let viewController = makeViewController(for: destination)
        naviController.pushViewController(viewController, animated: true)
    }

    // MARK: - Private

    private func makeViewController(for destination: Destination) -> LastFMViewController {
        var identifier = ""
        switch destination {
        case .savedAlbumDetails(let albumInfo):
            
            identifier = Constants.albumInfoController
            let vc = UIStoryboard(name: Constants.mainStoryboard, bundle: nil).instantiateViewController(withIdentifier: identifier) as! AlbumInfoController
            vc.buttonState = .delete
            vc.albumInfo = albumInfo
            return vc
        case .search:
            
            identifier = Constants.searchController
            return UIStoryboard(name: Constants.mainStoryboard, bundle: nil).instantiateViewController(withIdentifier: identifier) as! LastFMViewController
        case .topAlbums(let artistName):
            
            identifier = Constants.topAlbumsController
            let vc = UIStoryboard(name: Constants.mainStoryboard, bundle: nil).instantiateViewController(withIdentifier: identifier) as! AlbumsController
            vc.artistName = artistName
            return vc
        case .albumDetails(let album, let state):
            
            identifier = Constants.albumInfoController
            let vc = UIStoryboard(name: Constants.mainStoryboard, bundle: nil).instantiateViewController(withIdentifier: identifier) as! AlbumInfoController
            vc.buttonState = state
            vc.albumInfo = album
            
            return vc
        }
    }
}
