//
//  SavedAlbumsDataManager.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 09.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
public class SavedAlbumsDataManager {
    
    var items: [AlbumInfo] = []
    
    public var itemsCount: Int {
        return items.count
    }
    
    func item(at index: Int) -> AlbumInfo {
        return items[index]
    }
    
}
