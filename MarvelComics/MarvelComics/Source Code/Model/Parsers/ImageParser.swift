//
//  ImageParser.swift
//  MarvelComics
//
//  Created by Dario Langella on 02/07/2018.
//  Copyright © 2018 Dario Langella. All rights reserved.
//

import Foundation
import UIKit

class ImageParser {
    static func imageParse(data: Data)->UIImage? {
        guard let img = UIImage(data: data) else {
            return nil
        }
        return img
    }
}
