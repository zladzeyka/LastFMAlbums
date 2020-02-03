//
//  AlbumDataManager.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 04.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
import CoreData
public class AlbumDataManager {
    
    var items: [Track] = []
    var artist:String = ""
    var albumName:String = ""
    
    public var itemsCount: Int {
        return items.count
    }
    
    func item(at index: Int) -> Track {
        return items[index]
    }
    
}
