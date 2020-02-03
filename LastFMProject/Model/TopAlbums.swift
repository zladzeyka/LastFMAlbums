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
        struct Album: Codable {
            struct Artist: Codable {
                var name: String
                var mbid: String
            }
//            struct Cover: Codable {
//                var text: String?
//                enum CoverKeys: String, CodingKey {
//                    case text = "#text", size
//                }
//                public init(from decoder: Decoder) throws {
//                    let values = try decoder.container(keyedBy: CoverKeys.self)
//                    text = try values.decode(String.self, forKey: CoverKeys.text)
//                }
//            }
            var artist: Artist
            var name: String
            var playcount: Int
            var image: [Cover]
        }
        var album: [Album]
    }
    var topalbums: Albums
}
