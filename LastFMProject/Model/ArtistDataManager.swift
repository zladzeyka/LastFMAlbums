//
//  ArtistDataManager.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 02.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation

public class ArtistDataManager {
    
    var items: [SearchArtists.ArtistResults.ArtistMatches.Artist] = []
    
    public var itemsCount: Int {
        return items.count
    }
    
    func item(at index: Int) -> SearchArtists.ArtistResults.ArtistMatches.Artist {
        return items[index]
    }
}
