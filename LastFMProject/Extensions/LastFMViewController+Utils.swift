//
//  UIViewController+Utils.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 08.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
import UIKit
extension LastFMViewController {
    func showError(_ title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }
}
