//
//  Cover.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 17.12.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
public class Cover: NSObject, Codable, NSCoding {
    private enum CodingKeys: String, CodingKey { case text = "#text" }
    var text: String

    init(text: String) {
        self.text = text
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: CodingKeys.text.rawValue)
    }

    public required convenience init?(coder aDecoder: NSCoder) {
        let text = aDecoder.decodeObject(forKey: CodingKeys.text.rawValue) as! String
        self.init(text: text)
    }
}
