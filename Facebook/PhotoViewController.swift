//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Hana Kim on 10/2/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage!
    var offset: CGFloat!
    var scale: CGFloat!
    var originalOrigin: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = self.image
        imageView.hidden = true
        
        var scale = 320/self.image.size.width
        imageView.transform = CGAffineTransformMakeScale(scale, scale)
        imageView.center = view.center
        
        scrollView.contentSize = CGSize(width: 320, height: 570)
        scrollView.delegate = self
        view.backgroundColor = UIColor (white: 0.0, alpha: 0.0)
    }

    override func viewDidAppear(animated: Bool) {
        imageView.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        offset = scrollView.contentOffset.y
        scrollView.backgroundColor = UIColor(white: 0, alpha: ((100-abs(offset))/100))
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        originalOrigin = imageView.frame.origin
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!,
        willDecelerate decelerate: Bool) {

    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {

    }

    @IBAction func onTapDone(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
