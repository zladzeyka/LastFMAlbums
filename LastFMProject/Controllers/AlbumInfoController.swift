//
//  AlbumInfoController.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 04.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import CoreData
import Foundation
import UIKit

class AlbumInfoController: LastFMViewController {
    struct Constants {
        static let errorMessage = "Sorry, this album can't be found"
    }

    private var dataManager = AlbumDataManager()
    private lazy var dataSourceProvider = AlbumDataSourceManager(dataManager: dataManager)
    var albumInfo = AlbumInfo(album: AlbumInfo.AlbumInfoObject(name: "", artist: "", image: [], tracks: Tracks(tracks: [])))

    // for configure initial save button apperiance
    var buttonState: SaveButtonState = .save

    @IBOutlet var saveButton: SaveButton!
    @IBOutlet var tracksTableView: UITableView!
    @IBOutlet var coverImage: UIImageView!
    @IBOutlet var albumNameLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let albumName = albumInfo.album.name
        let artistName = albumInfo.album.artist

        title = albumName

        tracksTableView.dataSource = dataSourceProvider

        saveButton.configureWithState(state: buttonState)
        saveButton.action = {}

        if CoreDataHelper.shared.wasSaved(album: albumName, artist: artistName) {
            let albumInfo = CoreDataHelper.shared.loadAlbumDetails(album: albumName, artist: artistName)
            configureSaveButton(state: .delete)
            fillOutData(albumInfo)
        } else {
            loadAlbumDetails(artist: artistName, album: albumName)
        }
    }

    fileprivate func configureSaveButton(state: SaveButtonState) {
        saveButton.buttonState = state
        saveButton.configureWithState(state: state)
    }

    fileprivate func fillOutData(_ albumInfo: AlbumInfo) {
        albumNameLabel.text = albumInfo.album.name
        artistLabel.text = albumInfo.album.artist

        if let tracks = albumInfo.album.tracks.track {
            dataManager.items = tracks
        } else {
            dataManager.items = []
        }

        let url = albumInfo.album.image[0].text
        if !url.isEmpty {
            coverImage.af_setImage(
                withURL: URL(string: url)!,
                placeholderImage: nil,
                filter: nil,
                imageTransition: .crossDissolve(0.2)
            )
        } else {
            coverImage.image = UIImage().emptyImage()
        }
        tracksTableView.reloadData()
    }

    fileprivate func loadAlbumDetails(artist: String, album: String) {
        let command = LastFMCommand.getAlbumDetails
        ApiManager().requestData([artist, album], command: command) { [weak self]
            (info: [AlbumInfo]) in
            if !info.isEmpty {
                DispatchQueue.main.async {
                    self!.fillOutData(info.first!)
                }
            } else {
                self!.showError("", message: Constants.errorMessage)
            }
        }
    }

    fileprivate func modifyAlbumInfo() {
        let state = saveButton.buttonState
        let imageUrl = albumInfo.album.image[0].text
        let albumName = albumInfo.album.name
        let artistName = albumInfo.album.artist
        
        let cover = Cover(text: imageUrl)
        let track = Tracks(tracks: dataManager.items)
        let albumObject = AlbumInfo.AlbumInfoObject(name: albumNameLabel.text!, artist: artistLabel.text!, image: [cover], tracks: track)
        let albumInfo = AlbumInfo(album: albumObject)


        if state == .delete {
            CoreDataHelper.shared.saveAlbumInfo(albumInfo: albumInfo)
        } else {
            CoreDataHelper.shared.deleteAlbum(album: albumName, artist: artistName)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        modifyAlbumInfo()
    }
}
