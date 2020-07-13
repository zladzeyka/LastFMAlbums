//
//  AlbumInfoViewModel.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 08.07.20.
//  Copyright © 2020 Nadzeya Karaban. All rights reserved.
//

import Foundation
import UIKit

struct AlbumInfoViewModel {
    weak var dataSource: AlbumInfoDataSource?
    var artist: String = ""
    var albumName: String = ""
    var imageURLString: String = ""
    var isFavourite: Bool = true

    func loadAlbumDetails(artist: String, album: String) {
        let command = LastFMCommand.getAlbumDetails
        let requestParameter1 = artist
        let requestParameter2 = album
        ApiManager().requestData([requestParameter1, requestParameter2], command: command) {
            (info: [AlbumInfo]) in
            if !info.isEmpty {
                DispatchQueue.main.async {
                    self.dataSource?.data.value = info
                    let albumInfo = info[0]
                    
                    self.dataSource?.albumName = albumInfo.album.name
                    self.dataSource?.artistName = albumInfo.album.artist
                    self.dataSource?.coverUrlString = albumInfo.album.image[0].text
                }
            }
        }
    }


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
//            CoreDataHelper.shared.deleteAlbum(album: albumName, artist: artist)
//        }
    //   }

    func modifyAlbumInfo() {
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
        if let albumInfo = dataSource?.data.value.first {
            if isFavourite {
                CoreDataHelper.shared.saveAlbumInfo(albumInfo: albumInfo)
            } else {
                let artist = albumInfo.album.artist
                let albumName = albumInfo.album.name
                CoreDataHelper.shared.deleteAlbum(album: albumName, artist: artist)
            }
        }
    }
}
