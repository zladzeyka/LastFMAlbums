//
//  SearchArtistController+UISearchBar.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 20.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
import UIKit
extension SearchArtistController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let command = LastFMCommand.searchArtist
        let text = searchText

        ApiManager().requestData([text], command: command) {[weak self] (artists: [Artist]) in
            self?.dataManager.items = artists
            DispatchQueue.main.async {
                self?.artistsTableView.reloadData()

            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
