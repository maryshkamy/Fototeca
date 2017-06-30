//
//  PhotoViewController.swift
//  Fototeca
//
//  Created by Mariana Rios Silveira Carvalho on 29/06/17.
//  Copyright © 2017 Mariana Rios Silveira Carvalho. All rights reserved.
//

import Foundation
import UIKit

class PhotoViewController: UIViewController {
    
    var imageURL: URL? {
        didSet {
            image = nil
            
            if view.window != nil {
                loadImage()
            }
        }
    }
    
    private func loadImage() {
        if let url = imageURL {
            let data = try? Data(contentsOf: url)
            
            if let imageData = data {
                image = UIImage(data: imageData)
            }
        }
    }
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 0.02
            scrollView.maximumZoomScale = 10.0
            
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
            scrollView.delegate = self
        }
    }
    
    fileprivate var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageURL = URL(string: "http://www.news1130.com/wp-content/blogs.dir/sites/9/2015/12/26/iStock_000051500010_Double.jpg")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if image == nil {
            loadImage()
        }
    }
    
}

extension PhotoViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
