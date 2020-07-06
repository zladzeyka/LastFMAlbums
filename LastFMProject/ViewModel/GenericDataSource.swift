//
//  GenericDataSource.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 03.07.20.
//  Copyright © 2020 Nadzeya Karaban. All rights reserved.
//

import Foundation
import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}
