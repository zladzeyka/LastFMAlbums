//
//  AlbumsDataManager.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 03.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
public class AlbumsDataManager {
    
    var items: [Album] = []
    
    public var itemsCount: Int {
        return items.count
    }
    
    func item(at index: Int) -> Album {
        return items[index]
    }
    
}
