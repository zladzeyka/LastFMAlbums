//
//  AlbumDetails+CoreDataProperties.swift
//  
//
//  Created by Nadzeya Karaban on 09.11.19.
//
//

import Foundation
import CoreData

extension AlbumDetails {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlbumDetails> {
        return NSFetchRequest<AlbumDetails>(entityName: AlbumDetails.entity().name!)
    }

    @NSManaged public var artist: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var tracks: Tracks?
}
