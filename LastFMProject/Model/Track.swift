//
//  Track.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 17.12.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
public class Track: NSObject, Codable, NSCoding {
    private enum CodingKeys: String, CodingKey { case name ,duration }

    var name: String
    var duration: String
    
    init(name: String, duration: String) {
        self.name = name
        self.duration = duration
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: CodingKeys.name.rawValue)
        aCoder.encode(duration, forKey: CodingKeys.duration.rawValue)
    }

    public required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: CodingKeys.name.rawValue) as! String
        let duration = aDecoder.decodeObject(forKey: CodingKeys.duration.rawValue) as! String
        self.init(name: name,duration:duration)
    }
}
