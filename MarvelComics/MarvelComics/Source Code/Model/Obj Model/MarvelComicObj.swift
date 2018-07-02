//
//  MarvelComicObj.swift
//  MarvelComics
//
//  Created by Dario Langella on 02/07/2018.
//  Copyright © 2018 Dario Langella. All rights reserved.
//

import UIKit

struct MarvelComicImage{
    var imagePath = ""
    var imageExtension = ""
}

class MarvelComicObj {
    private let id: Int!
    private let digitalId: Int!
    var image = MarvelComicImage()
    var thumbnailImg: UIImage?
    var portraitFullImage: UIImage?
    var lanscapeFullImage: UIImage?
    
    init(id: Int, digitalId: Int, imagePath: String, imageExt: String) {
        self.id = id
        self.digitalId = digitalId
        self.image.imagePath = imagePath
        self.image.imageExtension = imageExt
    }
    
    
    /// Get Main image of the Object
    ///
    /// - Parameters:
    ///   - type: Constant image size
    ///   - image: image
    ///   - failure: failure error
    func getMainImage(type: String, image: @escaping(UIImage)->(), failure: @escaping(Error)->()) {
        let tempImage = checkImage(size: type)
        if tempImage == nil {
            downloadImage(type: type, image: { img in
                image(img)
            }, failure: { error in
                failure(error)
            })
        } else {
            image(tempImage!)
        }
    }
    
    private func downloadImage(type: String, image: @escaping(UIImage)->(), failure: @escaping(Error)->()) {
        APIRequester.getImage(marvelComic: self, imageSize: type, image: { img in
            switch type {
            case Constants.MarvelObj.Image.Size.LandscapeFullscreen:
                self.lanscapeFullImage = img
            case Constants.MarvelObj.Image.Size.PortraitFullscreen:
                self.portraitFullImage = img
            case Constants.MarvelObj.Image.Size.PortraitMedium:
                self.thumbnailImg = img
            default:
                break
            }
            image(img)
        }, failure: { error in
            failure(error)
        })
    }
    
    private func checkImage(size : String) -> UIImage?{
        switch size {
        case Constants.MarvelObj.Image.Size.LandscapeFullscreen:
            if self.lanscapeFullImage != nil {
                return self.lanscapeFullImage
            }
        case Constants.MarvelObj.Image.Size.PortraitFullscreen:
            if self.portraitFullImage != nil {
                return self.portraitFullImage
            }
        case Constants.MarvelObj.Image.Size.PortraitMedium:
            if self.thumbnailImg != nil {
                return self.thumbnailImg
            }
        default:
            return nil
        }
        return nil
    }
}
