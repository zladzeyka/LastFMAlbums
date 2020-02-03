//
//  Navigator.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 09.12.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
protocol Navigator {
    associatedtype Destination

    func navigate(to destination: Destination)
}
