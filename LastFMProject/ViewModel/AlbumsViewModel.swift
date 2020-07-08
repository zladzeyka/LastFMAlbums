//
//  AlbumsViewModel.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 08.07.20.
//  Copyright © 2020 Nadzeya Karaban. All rights reserved.
//

import Foundation
struct AlbumsViewModel {
    
    weak var dataSource : AlbumsDataSource?
    var requestParameter : String
    
     func loadTopAlbums() {
        let command = LastFMCommand.getTopAlbums
        let artistName = requestParameter
        ApiManager().requestData([artistName], command: command) { (albums: [Album]) in
            self.dataSource?.data.value = albums
        }
    }
}
