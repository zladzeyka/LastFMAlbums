//
//  AlbumsController.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 03.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
import UIKit
class AlbumsController: LastFMViewController {
    private var dataManager = AlbumsDataManager()
    private lazy var dataSourceProvider = AlbumsDataSourceProvider(dataManager: dataManager)
    var artistName = ""

    @IBOutlet var albumsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = artistName
        albumsTableView.dataSource = dataSourceProvider
        albumsTableView.delegate = dataSourceProvider
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTopAlbums()
    }

    fileprivate func loadTopAlbums() {
        let command = LastFMCommand.getTopAlbums
        let artistName = self.artistName
        ApiManager().requestData([artistName], command: command) { [weak self] (albums: [Album]) in
            self?.dataManager.items = albums
            DispatchQueue.main.async {
                self?.albumsTableView?.reloadData()
            }
            
        }
    }
}
