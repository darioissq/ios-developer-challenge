//
//  JSONParser.swift
//  MarvelComics
//
//  Created by Dario Langella on 02/07/2018.
//  Copyright © 2018 Dario Langella. All rights reserved.
//

import UIKit

class JSONParser {
    static func parse(data: Data, parsed: @escaping([String: Any])->(), failed: @escaping(String)->()) {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
            failed("error parsing json")
            print("error parsing json")
            return
        }
        
        guard let data = json as? [String: Any] else {
            failed("error parsing data")
            print("error parsing data")
            return
        }
        parsed(data)
    }
}
