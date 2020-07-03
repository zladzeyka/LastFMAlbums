//
//  ArtistDataManager.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 02.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation

public class ArtistDataManager {
    
    var items: [Artist] = []
    
    public var itemsCount: Int {
        return items.count
    }
    
    func item(at index: Int) -> Artist {
        return items[index]
    }
}
