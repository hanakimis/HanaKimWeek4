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
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var controlsImageView: UIImageView!
    
    var imageViews = [UIImageView]()
    
    var image: UIImage!
    var images = [UIImage]()
    var imageCount: Int = 0
    var whichImage: Int = 0
    var scrollOffset: CGFloat!
    var scale: CGFloat!
    var originalOrigin: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = self.image
        imageView.hidden = true
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.center = view.center
        
        for i in 0...(imageCount-1) {
            imageViews.append(UIImageView(image: images[i]))
            imageViews[i].hidden = true
            imageViews[i].contentMode = UIViewContentMode.ScaleAspectFit
            
            imageViews[i].frame.size.width = 320
            imageViews[i].frame.size.height = 320 * (imageViews[i].image!.size.height / imageViews[i].image!.size.width)
            imageViews[i].center.x = view.center.x + CGFloat(320.0 * Double(i))
            imageViews[i].center.y = view.center.y
            scrollView.addSubview(imageViews[i])
        }
        
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3
        scrollView.pagingEnabled = true
        scrollView.contentSize = CGSize(width: 320*imageCount, height: 570)
        scrollView.contentOffset = CGPoint(x: 320*whichImage, y: 0)

        view.backgroundColor = UIColor (white: 0.0, alpha: 0.0)
        scrollOffset = 0
    }
    
    override func viewDidAppear(animated: Bool) {
        imageView.hidden = false
        for i in 0...(imageCount-1) {
            imageViews[i].hidden = false
        }
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return imageView
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        scrollOffset = scrollView.contentOffset.y
        scrollView.backgroundColor = UIColor(white: 0, alpha: ((100-abs(scrollOffset))/100))
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        originalOrigin = imageView.frame.origin
        
        doneButton.hidden = true
        controlsImageView.hidden = true
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!,
        willDecelerate decelerate: Bool) {
            if (abs(scrollOffset) > 100) {
                dismissViewControllerAnimated(true, completion: nil)
            }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        doneButton.hidden = false
        controlsImageView.hidden = false
        
        switch scrollView.contentOffset.x {
        case 0.0:
            whichImage = 0
        case 320.0:
            whichImage = 1
        case 640.0:
            whichImage = 2
        case 960.0:
            whichImage = 3
        case 1280.0:
            whichImage = 4
        default:
            whichImage = 0
        }
    }

    @IBAction func onTapDone(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
