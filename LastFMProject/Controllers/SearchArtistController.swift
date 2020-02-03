//
//  SearchArtistController.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 28.10.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
import UIKit
class SearchArtistController: LastFMViewController {
    struct Constants {
        static let title = "Search"
    }
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var artistsTableView: UITableView!
     var dataManager = ArtistDataManager()
    private lazy var dataSourceProvider = ArtistDataSourceProvider(dataManager: dataManager)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.title
        artistsTableView.delegate = dataSourceProvider
        artistsTableView.dataSource = dataSourceProvider
    }
}

