//
//  ArtistCell.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 03.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
import UIKit

public class ArtistCell: UITableViewCell {
    func configure(with item: SearchArtists.ArtistResults.ArtistMatches.Artist) {
        textLabel?.text = item.name
        detailTextLabel?.text = "listeners:\(item.listeners)"
    }
}
