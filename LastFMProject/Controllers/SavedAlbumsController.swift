//
//  SavedAlbumsController.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 28.10.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import UIKit

class SavedAlbumsController: LastFMViewController {
    struct Constants {
        static let searchController = "searchArtistController"
    }
    
    private var dataManager = SavedAlbumsDataManager()
    private lazy var savedAlbumsManager = SavedAlbumsDataSourceProvider(dataManager: dataManager)
    @IBOutlet var albumsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(activateSearch))
        albumsCollectionView.delegate = savedAlbumsManager
        albumsCollectionView.dataSource = savedAlbumsManager
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAlbums()
    }

    @objc func activateSearch() {
        AppNavigator.shared.navigate(to: AppNavigator.Destination.search)
    }

    func fetchAlbums() {
        dataManager.items = CoreDataHelper.shared.retrieveAlbums()
        albumsCollectionView.reloadData()
    }
}

