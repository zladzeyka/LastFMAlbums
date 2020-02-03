//
//  Int+Utils.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 12.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
import UIKit
extension Int {
    func timeString() -> String {
        let minute = self / 60 % 60
        let second = self % 60
        return String(format: "%02i:%02i", minute, second)
    }
}

extension UIImage {
    func emptyImage() -> UIImage {
        return UIImage(systemName: "music.mic")!
    }
}
