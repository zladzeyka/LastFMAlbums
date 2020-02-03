//
//  Tracks.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 17.12.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import Foundation
public class Tracks: NSObject, NSCoding, Codable {
    public var track: [Track]? = []

    enum Key: String {
        case track
    }

    init(tracks: [Track]) {
        self.track = tracks
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(track, forKey: Key.track.rawValue)
    }

    public required convenience init?(coder aDecoder: NSCoder) {
        let mTracks = aDecoder.decodeObject(forKey: Key.track.rawValue) as! [Track]
        self.init(tracks: mTracks)
    }
}
