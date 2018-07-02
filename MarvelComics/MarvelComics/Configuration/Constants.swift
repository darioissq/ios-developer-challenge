//
//  Constants.swift
//  MarvelComics
//
//  Created by Dario Langella on 1/07/18.
//  Copyright © 2018 Dario Langella. All rights reserved.
//

import UIKit

struct Constants {
    
    
    // APPLICATION
    struct App {
        

        // Main
        static let isDebugJSON = true
        static let isHTTPS = false
        
        
        // Base
        static let BaseURL: String = {
            if Constants.App.isHTTPS {
                return "https://" //Empty because not value on 01/07/2018
            }
            else {
                return "http://gateway.marvel.com"
            }
        }()
        
        #if DEBUG // -> Development

            static let BaseAPIURL = "developer.marvel.com"

        #else // -> Production
        
            static let BaseAPIURL = "developer.marvel.com"
        
        #endif
    
    }

    // MARK: EndPoint
    struct APIEndPoint {
        static let RepoList = "/v1/public/comics" + "?limit=100"
    }
    
    
    // MARK: KeyAPI
    struct APIKey {
        static let PublicKey = "96572891da4fe9fd363999d15a188d1f"
        static let PrivateKey = "eb519998be8f4c5786a1aa228e2e5a3a53b87794"
    }
    
    // MARK:
    struct Request {
        static let TimeOut = 10
    }
    
    // MARK: Marvel Object
    struct MarvelObj {
        
        // MARK: BASE
        static let Code = "code"
        static let Status = "status"
        static let Data = "data"
        static let Etag = "etag"
        static let Copyright = "copyright"
        static let AttributionText = "attributionText"
        static let AttributionHTML = "attributionHTML"
        
        // MARK: Container
        struct Container {
            static let Offset = "offset"
            static let Limit = "limit"
            static let Total = "total"
            static let Count = "count"
            static let Results = "results"
        }
        
        struct Comic {
            static let Id = "id"
            static let DigitalId = "digitalId"
            static let Title = "title"
            static let Thumbnail = "thumbnail"
        }
        
        struct Image {
            static let Path = "path"
            static let Extension = "extension"
            
            struct Size {
                static let PortraitMedium = "portrait_xlarge"
                static let PortraitFullscreen = "portrait_fantastic"
                static let LandscapeFullscreen = "landscape_amazing"
            }
        }
    }
    
    //MARK: Errors
    struct Error {
        static let Basic = "generic_error".localized()
    }
}
