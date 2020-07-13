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

    var artistName = ""
    var albumName = ""

    private lazy var dataSource = AlbumInfoDataSource()

    lazy var viewModel: AlbumInfoViewModel = {
        let viewModel = AlbumInfoViewModel(dataSource: dataSource, artist: artistName, albumName: albumName)
        return viewModel
    }()

    var albumInfo = AlbumInfo(album: AlbumInfoObject(name: "", artist: "", image: [], tracks: Tracks(tracks: [])))

    // for configure initial save button apperiance
    var buttonState: ButtonState = .save

    @IBOutlet var saveButton: FavouriteButton!
    @IBOutlet var tracksTableView: UITableView!
    @IBOutlet var coverImage: UIImageView!
    @IBOutlet var albumNameLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = albumName
        tracksTableView.dataSource = dataSource
        dataSource.data.addAndNotify(observer: self) { [weak self] _ in

             self?.tracksTableView.reloadData()
             self?.updateView()
         }

        albumNameLabel.text = albumName
        artistLabel.text = artistName
        
        viewModel.loadAlbumDetails(artist: albumInfo.album.name, album: albumInfo.album.artist)

        saveButton.configureWithState(state: buttonState)
        saveButton.action = {}

        // implement errow show

//        if CoreDataHelper.shared.wasSaved(album: albumName, artist: artistName) {
//            let albumInfo = CoreDataHelper.shared.loadAlbumDetails(album: albumName, artist: artistName)
//            configureSaveButton(state: .delete)
//            //fillOutData(albumInfo)
//        } else {
//           // viewModel.loadAlbumDetails(artist: artistName, album: albumName)
//        }
    }

    fileprivate func configureSaveButton(state: ButtonState) {
        saveButton.buttonState = state
        saveButton.configureWithState(state: state)
    }

    func updateView() {
        albumNameLabel.text = dataSource.albumName
        artistLabel.text = dataSource.artistName
        let url = dataSource.coverUrlString
        if !url.isEmpty {
            coverImage.af_setImage(
                withURL: URL(string: url)!,
                placeholderImage: UIImage(),
                filter: nil,
                imageTransition: .crossDissolve(0.2)
            )
        }
    }

//    fileprivate func loadAlbumDetails(artist: String, album: String) {
//        let command = LastFMCommand.getAlbumDetails
//        ApiManager().requestData([artist, album], command: command) { [weak self]
//            (info: [AlbumInfo]) in
//            if !info.isEmpty {
//                DispatchQueue.main.async {
//                    self!.fillOutData(info.first!)
//                }
//            } else {
//                self!.showError("", message: Constants.errorMessage)
//            }
//        }
//    }

//    fileprivate func modifyAlbumInfo() {
//        let state = saveButton.buttonState
//        let imageUrl = albumInfo.album.image[0].text
//        let albumName = albumInfo.album.name
//        let artistName = albumInfo.album.artist
//
//        let cover = Cover(text: imageUrl)
//        let track = Tracks(tracks: dataManager.items)
//        let albumObject = AlbumInfoObject(name: albumNameLabel.text!, artist: artistLabel.text!, image: [cover], tracks: track)
//        let albumInfo = AlbumInfo(album: albumObject)
//
//
//        if state == .delete {
//            CoreDataHelper.shared.saveAlbumInfo(albumInfo: albumInfo)
//        } else {
//            CoreDataHelper.shared.deleteAlbum(album: albumName, artist: artistName)
//        }
//    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.modifyAlbumInfo()
    }
}
