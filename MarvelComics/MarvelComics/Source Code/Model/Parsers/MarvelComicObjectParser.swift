//
//  MarvelComicObjectParser.swift
//  MarvelComics
//
//  Created by Dario Langella on 02/07/2018.
//  Copyright © 2018 Dario Langella. All rights reserved.
//

import Foundation

class MarvelComicObjectParser {
    
    /// Parse the data from the request
    ///
    /// - Parameter data: JSON Data
    /// - Returns: MarvelComicObject
    static func parseMarvelComicObject(data: [String: Any]) -> MarvelComicObj? {
        guard let id = data[Constants.MarvelObj.Comic.Id] as? Int,
            let digitalID = data[Constants.MarvelObj.Comic.DigitalId] as? Int,
            let thumbnail = data[Constants.MarvelObj.Comic.Thumbnail] as? [String: Any] else {
                return nil
        }
        
        guard let imagePath = thumbnail[Constants.MarvelObj.Image.Path] as? String,
            let imageExtension = thumbnail[Constants.MarvelObj.Image.Extension] as? String else {
                return nil
        }
        
        return MarvelComicObj(id: id, digitalId: digitalID, imagePath: imagePath, imageExt: imageExtension)
    }
}
