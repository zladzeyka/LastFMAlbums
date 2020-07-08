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
    private lazy var dataSource = AlbumsDataSource()
    var artistName = ""
    
    lazy var viewModel : AlbumsViewModel = {
        let viewModel = AlbumsViewModel(dataSource: dataSource, requestParameter: artistName)
         return viewModel
     }()

    @IBOutlet var albumsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = artistName
        
        albumsTableView.dataSource = viewModel.dataSource
        albumsTableView.delegate = viewModel.dataSource
        
        viewModel.dataSource?.data.addAndNotify(observer: self) { [weak self] _ in
            self?.albumsTableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadTopAlbums()
    }
}
