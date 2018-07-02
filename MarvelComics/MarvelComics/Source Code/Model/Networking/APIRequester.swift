//
//  APIRequester.swift
//  MarvelComics
//
//  Created by Dario Langella on 02/07/2018.
//  Copyright © 2018 Dario Langella. All rights reserved.
//

import Foundation
import Alamofire
import CryptoSwift

class APIRequester {
    
    /// Get Marvel Comics Array
    ///
    /// - Parameters:
    ///   - marvelComics: MarvelComicsObject Array
    ///   - failure: Error
    static func getMarvelComics(marvelComics: @escaping([MarvelComicObj])->(), failure: @escaping(Error)->()) {
        let url = "\(Constants.App.BaseURL)" + "\(Constants.APIEndPoint.RepoList)"
        let ts = Date().timeIntervalSince1970.description
        
        let parameters: Parameters = ["ts": ts,
                                      "apikey": Constants.APIKey.PublicKey,
                                      "hash": (ts + Constants.APIKey.PrivateKey + Constants.APIKey.PublicKey).md5()]
        
        Networking.performRequest(url: url, parameters: parameters, success: { responseData in
            JSONParser.parse(data: responseData, parsed: { parsedJSON in
                guard let code = parsedJSON[Constants.MarvelObj.Code] as? Int,
                    let data = parsedJSON[Constants.MarvelObj.Data] as? [String: Any] else {
                        print("Not found data in JSON")
                        return
                }
                
                guard let comics = data[Constants.MarvelObj.Container.Results] as? [[String: Any]] else {
                    debugPrint("NO Object")
                    marvelComics([MarvelComicObj]())
                    return
                }
                
                if code == 200 {
                    let comicsArr = comics.compactMap({
                        MarvelComicObjectParser.parseMarvelComicObject(data: $0)
                    })
                    marvelComics(comicsArr)
                } else {
                    print("Status \(code)")
                    marvelComics([MarvelComicObj]())
                }
            }, failed: { error in
                print(error)
            })
        }, failure: { error in
            print(error)
        })
    }
    
    
    /// Get Marvel Comics Image
    ///
    /// - Parameters:
    ///   - marvelComic: MarvelComicObj
    ///   - imageSize: Constant image size
    ///   - image: image
    ///   - failure: error
    static func getImage(marvelComic: MarvelComicObj, imageSize: String, image: @escaping(UIImage)->(), failure: @escaping(Error)->()) {
        
        let url = "\(marvelComic.image.imagePath)/\(imageSize).\(marvelComic.image.imageExtension)"
        Networking.performRequest(url: url, success: { data in
            guard let img = ImageParser.imageParse(data: data) else {
                return
            }
            image(img)
        }, failure: { error in
            failure(error)
        })
    }
}
