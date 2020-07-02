//
//  TopAlbums.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 04.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
/**
 Struct for Top albums response
 */
struct TopAlbums: Codable {
    struct Albums: Codable {
        var album: [Album]
    }
    var topalbums: Albums
}
struct Album: Codable {
    var artist: Artist
    var name: String
    var playcount: Int
    var image: [Cover]
}
