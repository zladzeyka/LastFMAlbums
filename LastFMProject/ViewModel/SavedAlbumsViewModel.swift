//
//  SavedAlbumsViewModel.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 08.07.20.
//  Copyright © 2020 Nadzeya Karaban. All rights reserved.
//

import Foundation
struct SavedAlbumsViewModel {
    
    weak var dataSource : SavedAlbumsDataSource?
    
     func loadSavedAlbums() {
        dataSource?.data.value = CoreDataHelper.shared.retrieveAlbums()
    }
}
