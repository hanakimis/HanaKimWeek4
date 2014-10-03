//
//  NewsFeedViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        feedImageView.alpha = 0

        // Configure the content size of the scroll view
        scrollView.contentSize = CGSizeMake(320, feedImageView.image!.size.height)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var defaults = NSUserDefaults.standardUserDefaults()
        var initalVal = defaults.integerForKey("first_time")
        
     /*   if (initalVal == 0) {
            defaults.setInteger(1, forKey: "first_time")
            defaults.synchronize()
            
            feedImageView.image = UIImage(named: "empty_feed")
            scrollView.contentSize = CGSizeMake(320, feedImageView.image!.size.height)

        } else {
            feedImageView.image = UIImage(named: "home_feed")
            scrollView.contentSize = CGSizeMake(320, feedImageView.image!.size.height)
        }
        
        feedImageView.alpha = 0
        activityIndicator.startAnimating()
        
        
        delay(2) {
            self.activityIndicator.stopAnimating()
            UIView.animateWithDuration(0.5, animations: {
                self.feedImageView.alpha = 1

            })
        }
        */
        
        feedImageView.alpha = 1
        
        scrollView.contentInset.top = 0
        scrollView.contentInset.bottom = 50
        scrollView.scrollIndicatorInsets.top = 0
        scrollView.scrollIndicatorInsets.bottom = 50
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}
