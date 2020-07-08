//
//  AlbumCell.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 03.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import CoreData
import Foundation
import UIKit

public class AlbumCell: UITableViewCell {
    @IBOutlet var coverImage: UIImageView!

    @IBOutlet var albumName: UILabel!
    @IBOutlet var artistName: UILabel!
    @IBOutlet var saveButton: FavouriteButton!
    var buttonState = ButtonState.save

    func configure(with item: Album) {
        let url = item.image[1].text
        if  !url.isEmpty {
            coverImage.af_setImage(
                withURL: URL(string: url)!,
                placeholderImage: UIImage(),
                filter: nil,
                imageTransition: .crossDissolve(0.2)
            )
        } else {
            coverImage.image = UIImage().emptyImage()
        }
        let albumNameString = item.name
        let artistNameString = item.artist.name
        albumName.text = albumNameString
        artistName.text = artistNameString

        if CoreDataHelper.shared.wasSaved(album: item) {
            saveButton.configureWithState(state: .delete)
        } else {
            saveButton.configureWithState(state: .save)
        }
        saveButton.action = { [unowned self] in
            switch self.buttonState {
                case .save:
                    CoreDataHelper.shared.preloadAndSaveAlbum(album: item)
                    self.buttonState = .delete
                case .delete:
                    CoreDataHelper.shared.deleteAlbum(album: item)
                    self.buttonState = .save
            }
        }
    }
}
