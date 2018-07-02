//
//  DetailViewController.swift
//  MarvelComics
//
//  Created by Dario Langella on 01/07/2018.
//  Copyright © 2018 Dario Langella. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!{
        didSet{
            self.activityIndicator.startAnimating()
        }
    }
    var marvelComic : MarvelComicObj? {
        didSet{
            marvelComic?.getMainImage(type: Constants.MarvelObj.Image.Size.PortraitFullscreen, image: { (img) in
                self.stopLoading()
                self.imageView.image = img
            }, failure: { (error) in
                
            })
        }
    }
    
    @IBOutlet var imageView: UIImageView!{
        didSet{
            imageView.isUserInteractionEnabled = true
            if let img = image {
               imageView.image = img
            }
        }
    }
    @IBOutlet var scrollView: UIScrollView!{
        didSet{
            scrollView.minimumZoomScale = 1.0
            scrollView.maximumZoomScale = 3.0
            scrollView.delegate = self
        }
    }
    
    var image : UIImage?
    
    @IBOutlet var closeButton: UIButton!{
        didSet{
            closeButton.setTitle("close".localized(), for: .normal)
            closeButton.addTarget(self, action: #selector(DetailViewController.close), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Double Tap Gesture for zooming the content
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.zoom))
        tap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func stopLoading(){
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
}

//MARK: ScollViewDelegate
extension DetailViewController : UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

//MARK: Actions
extension DetailViewController {
    @objc private func zoom(sender: UITapGestureRecognizer) {
        if (scrollView.zoomScale < 1.5) {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
    }
    
    @objc private func close(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}
