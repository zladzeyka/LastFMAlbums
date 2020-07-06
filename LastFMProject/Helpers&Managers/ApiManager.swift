//
//  ApiManager.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 31.10.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//
import Foundation
import Alamofire

enum LastFMCommand: String {
    case searchArtist = "artist.search"
    case getTopAlbums = "artist.gettopalbums"
    case getAlbumDetails = "album.getInfo"
}

class ApiManager: NSObject {
    struct Constants {
        static let scheme = "http"
        static let path = "/2.0/"
        static let baseURL = "ws.audioscrobbler.com"
        static let apiKey = "api_key"
        static let apiKeyValue = "feac94cc61ed826ad72066add43b210b"
        static let formatKey = "format"
        static let formatKeyValue = "json"
        static let limitKey = "limit"
        static let limitKeyValue = "50"
        static let pageKey = "page"
        static let pageKeyValue = "1"
        static let methodKey = "method"
        static let artistKey = "artist"
        static let albumKey = "album"
    }
    
    fileprivate let queryItemKey = URLQueryItem(name: Constants.apiKey, value: Constants.apiKeyValue)
    fileprivate let queryItemFormat = URLQueryItem(name: Constants.formatKey, value: Constants.formatKeyValue)
    fileprivate let queryItemLimit = URLQueryItem(name: Constants.limitKey, value: Constants.limitKeyValue)
    fileprivate let queryItemPage = URLQueryItem(name: Constants.pageKey, value: Constants.pageKeyValue)
    
    var results: [Codable] = []
    
    var baseURL: URL {
        return URL(string: Constants.baseURL)!
    }
    
    func buildRequestUrl(command: LastFMCommand, parameters: [String]) -> URL {
        var components =
            URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.path = Constants.path
        let queryItemMethod = URLQueryItem(name: Constants.methodKey, value: command.rawValue)
        let queryItemParameter = URLQueryItem(name: Constants.artistKey, value: parameters[0])
        let commandType = command
        switch commandType {
        case .searchArtist, .getTopAlbums:
            do {
                components.queryItems = [queryItemMethod,
                                         queryItemParameter,
                                         queryItemKey,
                                         queryItemFormat,
                                         queryItemLimit,
                                         queryItemPage]
            }
        case .getAlbumDetails:
            do {
                // workaround for "+" in url component
                let parameterValue = parameters[1].replacingOccurrences(of: "+", with: "%2B")
                
                let queryItemSecondParameter = URLQueryItem(name: Constants.albumKey, value: parameterValue)
                components.queryItems = [queryItemMethod,
                                         queryItemKey,
                                         queryItemParameter,
                                         queryItemSecondParameter,
                                         queryItemFormat]
            }
        }
        return components.url!
    }
    
    /**
     Sends an API request.
      * parameters  : [String]  request's parameters.
      * command : LastFMCommand for each query.
      * completion : A closure which is called with results [T].
     - returns: Nothing
     */
    func requestData<T>(_ parameters: [String], command: LastFMCommand, completion: @escaping ([T]) -> Void) {
        let url = self.buildRequestUrl(command: command, parameters: parameters)
        AF.request(url).validate().responseJSON { response in
            guard response.error == nil else {
                print(response.error!)
                return
            }
            guard let data = response.data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                switch command.self {
                case .searchArtist:
                    do {
                        let info = try decoder.decode(SearchArtists.self, from: data)
                        self.results = info.results.artistmatches.artist
                    }
                case .getTopAlbums:
                    do {
                        let info = try decoder.decode(TopAlbums.self, from: data)
                        self.results = info.topalbums.album
                    }
                case .getAlbumDetails:
                    do {
                        self.results = [try decoder.decode(AlbumInfo.self, from: data)]
                    }
                }
            } catch {
                print(error)
            }
            completion(self.results as? [T] ?? [])
        }.resume()
    }
}
