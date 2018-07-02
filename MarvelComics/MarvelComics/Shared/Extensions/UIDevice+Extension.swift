//
//  UIDevice+Extension.swift
//  MarvelComics
//
//  Created by Dario Langella on 02/07/2018.
//  Copyright © 2018 Dario Langella. All rights reserved.
//

import UIKit

extension UIDevice {
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }
}
