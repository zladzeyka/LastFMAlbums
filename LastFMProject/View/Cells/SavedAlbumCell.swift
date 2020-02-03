//
//  SavedAlbumCollectionCell.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 03.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
import AlamofireImage
import UIKit

class SavedAlbumCell: UICollectionViewCell {
    @IBOutlet var albumImageView: UIImageView!
    @IBOutlet var albumName: UILabel!
    @IBOutlet var artistName: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(item: AlbumInfo) {
        artistName.text = item.album.artist
        albumName.text = item.album.name
        let url = item.album.image[0].text
        if !(url.isEmpty) {
            albumImageView.af_setImage(
                withURL: URL(string: url)!,
                placeholderImage: UIImage(),
                filter: nil,
                imageTransition: .crossDissolve(0.2)
            )
        }
    }
}
