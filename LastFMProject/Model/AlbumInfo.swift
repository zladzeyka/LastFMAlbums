//
//  AlbumInfo.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 16.12.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
/**
 Struct for AlbumInfo response
 */
struct AlbumInfo: Codable {
    var album: AlbumInfoModel
}
struct AlbumInfoModel: Codable {
    var name: String?
    var artist: String?
    var image: [Cover]?
    var tracks: Tracks?
}
