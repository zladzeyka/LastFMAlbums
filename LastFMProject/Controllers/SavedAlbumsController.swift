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
    
    private lazy var dataSource = SavedAlbumsDataSource()
    lazy var viewModel : SavedAlbumsViewModel = {
        let viewModel = SavedAlbumsViewModel(dataSource: dataSource)
         return viewModel
     }()

    @IBOutlet var albumsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(activateSearch))
        albumsCollectionView.delegate = dataSource
        albumsCollectionView.dataSource = dataSource
        
        dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            self?.albumsCollectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadSavedAlbums()
    }

    @objc func activateSearch() {
        AppNavigator.shared.navigate(to: AppNavigator.Destination.search)
    }

}

