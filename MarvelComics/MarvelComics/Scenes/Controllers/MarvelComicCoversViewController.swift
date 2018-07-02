//
//  MarvelComicCoversViewController.swift
//  MarvelComics
//
//  Created by Dario Langella on 01/07/2018.
//  Copyright © 2018 Dario Langella. All rights reserved.
//

import UIKit

class MarvelComicCoversViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!{
        didSet{
            collectionView.register(UINib.init(nibName: "MarvelComicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.isPrefetchingEnabled = true
            collectionView.prefetchDataSource = self
        }
    }
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!{
        didSet{
            self.activityIndicator.startAnimating()
        }
    }
    
    var datasource = [MarvelComicObj]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setBackgroundImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    private func setBackgroundImage(){
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "space")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    private func setCollectionViewLayout(){
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    private func getData(){
        APIRequester.getMarvelComics(marvelComics: { (comics) in
            self.datasource = comics
            self.stopLoading()
            self.collectionView.reloadData()
        }, failure: { (error) in
            
        })
    }
    
    private func stopLoading(){
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailsSegue" {
            let detailsVC = segue.destination as! DetailViewController
            let cell = sender as! MarvelComicCollectionViewCell
            let indexPath = self.collectionView.indexPath(for: cell)!
            let marvelComicObj = datasource[indexPath.row]
            detailsVC.marvelComic = marvelComicObj
        }
    }

}
