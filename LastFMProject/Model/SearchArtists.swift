//
//  SearchArtists.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 04.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
/**
 Struct for Search artists response
*/
struct SearchArtists:Codable {
    struct ArtistResults:Codable {
        struct ArtistMatches: Codable {
            var artist:[Artist]
        }
        var artistmatches:ArtistMatches
    }
    var results:ArtistResults
}
struct Artist: Codable
{
    var name : String
    var mbid : String
    var listeners : String?
}
