//
//  MarvelComicCoversViewController+CollectionView.swift
//  MarvelComics
//
//  Created by Dario Langella on 01/07/2018.
//  Copyright © 2018 Dario Langella. All rights reserved.
//

import UIKit

// MARK: Datasource
extension MarvelComicCoversViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MarvelComicCollectionViewCell
        let marvelComic = datasource[indexPath.row]
        marvelComic.getMainImage(type: Constants.MarvelObj.Image.Size.PortraitMedium, image: { image in
            cell.display(image: image)
            cell.stopLoading()
        }, failure: { error  in
            print("error")
        })
        
        if let image = datasource[indexPath.row].thumbnailImg {
            cell.display(image: image)
        }
        return cell
    }
}

//MARK: Delegate
extension MarvelComicCoversViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        self.performSegue(withIdentifier: "showDetailsSegue", sender: cell)
    }
}

//MARK: Prefetch Items
extension MarvelComicCoversViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let marvelCover : MarvelComicObj = datasource[indexPath.row]
            marvelCover.getMainImage(type: Constants.MarvelObj.Image.Size.PortraitMedium, image: { image in
                print("image downloaded")
            }, failure: { error  in
                print("error")
            })
        }
    }
}

//MARK: LayoutDelegate
extension MarvelComicCoversViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = UIScreen.main.bounds.height - 60
        var cellHeight = (height / 4) - 20
        if UIDevice.current.iPhoneX {
            cellHeight = cellHeight - 16
        }
        let cellWidth = (cellHeight / 4) * 3 //Width is calculted thinking about an aspect ratio of 3:4
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}
