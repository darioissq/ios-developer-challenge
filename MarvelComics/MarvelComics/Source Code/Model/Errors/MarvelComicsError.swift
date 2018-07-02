//
//  MarvelComicsError.swift
//  MarvelComics
//
//  Created by Dario Langella on 01/07/2018.
//  Copyright © 2018 Dario Langella. All rights reserved.
//

import Foundation

enum MarvelComicsError: Error {
    case httpStatus(status: Int)
    case unknownError(message: String)
    case parseError(message: String)
}
