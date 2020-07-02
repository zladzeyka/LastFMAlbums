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
    func configure(with item: Artist) {
        textLabel?.text = item.name
        if let listeners = item.listeners {
            detailTextLabel?.text = "listeners:\(listeners)"
        } else {
            detailTextLabel?.text = "listeners: not availiable"
        }
    }
}
