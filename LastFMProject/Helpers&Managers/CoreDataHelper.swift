//
//  CoreDataHelper.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 08.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import CoreData
import Foundation
import UIKit

class CoreDataHelper {
    struct Constants {
        static let entityName = "AlbumDetails"
        static let artistKey = "artist"
        static let nameFormat = "name == %@"
        static let artistFormat = "artist == %@"
    }
    
    static let shared = CoreDataHelper()
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let privateManagedObjectContext: NSManagedObjectContext = {
        let moc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        moc.parent = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return moc
    }()
    
    /**
     Load saved albums.
     - returns: Nothing
     */
    
    func retrieveAlbums() -> [AlbumInfo] {
        var infoResults: [AlbumInfo] = []
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: Constants.artistKey, ascending: true)]
        
        do {
            let results = try managedContext.fetch(fetchRequest) as! [AlbumDetails]
            for object in results {
                let album = object.name!
                let artist = object.artist!
                let coverUrl = object.image!
                let albumObject = AlbumInfoObject(name: album, artist: artist, image: [Cover.init(text: coverUrl)], tracks: object.tracks!)
                let albumDetails = AlbumInfo(album: albumObject)
                infoResults.append(albumDetails)
            }
        }
        catch {
            print(error)
        }
        return infoResults
    }
    
    /**
     Save albumInfo
     * albumInfo : Object :Codable
     
     - returns: Nothing
     */
    func saveAlbumInfo(albumInfo: AlbumInfo) {
        do {
            if !wasSaved(album: albumInfo.album.name, artist: albumInfo.album.artist) {
                let albumDetails = AlbumDetails(entity: AlbumDetails.entity(), insertInto: managedContext)
                albumDetails.artist = albumInfo.album.artist
                albumDetails.name = albumInfo.album.name
                albumDetails.image = albumInfo.album.image[0].text
                albumDetails.tracks = albumInfo.album.tracks
                try managedContext.save()
            }
        }
        catch {
            print(error)
        }
    }
    
    /**
     Save album after load full album info
     * album : String - album name
     * artist : String - artist name
     - returns: Nothing
     */
    func preloadAndSaveAlbum(album: String, artist: String) {
        ApiManager().requestData([artist, album], command: LastFMCommand.getAlbumDetails) {
            (info: [AlbumInfo]) in
            if !info.isEmpty {
                if let albumDetails = info.first {
                    self.saveAlbumInfo(albumInfo: albumDetails)
                }
            }
        }
    }
    
    /**
     Delete album
     * album : String - album name
     * artist : String - artist name
     - returns: Nothing
     */
    func deleteAlbum(album: String, artist: String) {
        var results: [AlbumDetails] = []
        let fetchRequest = buildFetchRequestForAlbum(album: album, artist: artist)
        do {
            results = try managedContext.fetch(fetchRequest) as! [AlbumDetails]
            if !results.isEmpty {
                if let deletedAlbum = results.first {
                    managedContext.delete(deletedAlbum)
                    try managedContext.save()
                }
            }
        }
        catch {
            print(error)
        }
    }
    
    /**
     Check if album was previously saved
      * album : String - album name
      * artist : String - artist name
     - returns: Bool
     */
    func wasSaved(album: String, artist: String) -> Bool {
        var count = 0
        let fetchRequest = buildFetchRequestForAlbum(album: album, artist: artist)
        do {
            count = try managedContext.count(for: fetchRequest)
        }
        catch {
            print(error)
        }
        return count > 0
    }
    
    /**
     load albumInfo
     * album : String - album name
     * artist : String - artist name
     - returns: AlbumInfo
     */
    func loadAlbumDetails(album: String, artist: String) -> AlbumInfo {
        var albumDetails :AlbumInfo
        let fetchRequest = buildFetchRequestForAlbum(album: album, artist: artist)
        
        do {
            let results = try managedContext.fetch(fetchRequest) as! [AlbumDetails]
            if !results.isEmpty {
                
                let cover = Cover.init(text: results[0].image!)
                let albumObject = AlbumInfoObject.init(name: results[0].name!, artist: results[0].artist!, image: [cover], tracks: results[0].tracks!)
                albumDetails = AlbumInfo(album: albumObject)
                return albumDetails
            }
        }
        catch {
            print(error)
        }
        return AlbumInfo.init(album: AlbumInfoObject(name: "", artist: "", image: [], tracks: Tracks.init(tracks: [])))
    }
    
    func buildFetchRequestForAlbum(album: String, artist: String) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
        let predicate1 = NSPredicate(format: Constants.nameFormat, album)
        let predicate2 = NSPredicate(format: Constants.artistFormat, artist)
        let predicate = NSCompoundPredicate(type: .and, subpredicates: [predicate1, predicate2])
        fetchRequest.predicate = predicate
        return fetchRequest
    }
}
