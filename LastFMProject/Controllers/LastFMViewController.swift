//
//  LastFMViewController.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 03.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
import UIKit

class LastFMViewController: UIViewController {
    enum Constants {
        static let mainStoryboard = "Main"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureInterfaceStyle()
    }

    func configureInterfaceStyle() {
        overrideUserInterfaceStyle = .dark
    }

}
