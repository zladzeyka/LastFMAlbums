//
//  TrackCell.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 04.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
import UIKit

public class TrackCell: UITableViewCell {
    
    func configure(with item: Track) {
        textLabel?.text = item.name
        let duration = Int(item.duration)
        detailTextLabel?.text = duration?.timeString()
    }
}
