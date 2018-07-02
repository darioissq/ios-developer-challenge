//
//  MarvelComicCollectionViewCell.swift
//  MarvelComics
//
//  Created by Dario Langella on 01/07/2018.
//  Copyright © 2018 Dario Langella. All rights reserved.
//

import UIKit

class MarvelComicCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!{
        didSet{
            self.activityIndicator.startAnimating()
        }
    }
    var image : UIImage?
    func display(image : UIImage) {
        self.imageView.image = image
        self.image = image
    }
    
    func stopLoading(){
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
}
