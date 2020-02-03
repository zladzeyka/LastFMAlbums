//
//  AlbumDetails+CoreDataClass.swift
//
//
//  Created by Nadzeya Karaban on 09.11.19.
//
//

import CoreData
import Foundation

@objc(AlbumDetails)
public class AlbumDetails: NSManagedObject, Codable {
    private enum CodingKeys: String, CodingKey { case album, name, artist, mbid, image, tracks }

    public required convenience init(from decoder: Decoder) throws {
        let helper = CoreDataHelper()
        let context = helper.managedContext

        let entity = NSEntityDescription.entity(forEntityName: "AlbumDetails", in: context)!
        self.init(entity: entity, insertInto: context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let album = try values.nestedContainer(keyedBy:
            CodingKeys.self, forKey: .album)
        name = try album.decode(String.self, forKey: .name)
        name = name?.removingPercentEncoding
        artist = try album.decode(String.self, forKey: .artist)

        let coverImages = try album.decode([Cover].self, forKey: .image)
        image = coverImages[1].text
        tracks = try album.decode(Tracks.self, forKey: .tracks)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(artist, forKey: .artist)
        try container.encode(image, forKey: .image)
        try container.encode(tracks, forKey: .tracks)
    }
}

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

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
