//
//  NewsFeedViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var isPresenting: Bool = true
    var clickedImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedImageView.alpha = 0
        scrollView.contentSize = CGSizeMake(320, feedImageView.image!.size.height)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var defaults = NSUserDefaults.standardUserDefaults()
        var initalVal = defaults.integerForKey("first_time")
        
     /*
        // Comment out this section so don't have to wait ot test photo stuff
        
        if (initalVal == 0) {
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
    
    
    @IBAction func tapPhotoOpen(tapedImage: UITapGestureRecognizer) {
        clickedImage = tapedImage.view as UIImageView!
        performSegueWithIdentifier("viewPhotoSegue", sender: self)
    }
    
    
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        switch segue.identifier {
        case "viewPhotoSegue":
            var destinationViewController = segue.destinationViewController as PhotoViewController
            destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
            destinationViewController.transitioningDelegate = self
            destinationViewController.image = self.clickedImage.image
        default:
            println()
        }
    }
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        //var tempImage =
        
        if (isPresenting) {
            var window = UIApplication.sharedApplication().keyWindow
            var thisFrame = window.convertRect(clickedImage.frame, fromView: scrollView)
            var copyImageView = UIImageView(frame: thisFrame)
            copyImageView.image = clickedImage.image
            
            
            window.addSubview(copyImageView)
            
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                var scale = 320/copyImageView.frame.width

                
                /*

                Ideally, we should have an if statment here that if the image is too wide, then scale it correctly with the width at 320, and have the y position centered with the window.
                
                Otherwise, if the image is too tall, we will center and scroll
                
                if the image is too narrow (thinner than 320), then I guess we can stretch it out to 320?
                
                */
                
                
                
                copyImageView.transform = CGAffineTransformMakeScale(scale, scale)
                copyImageView.center = window.center
                toViewController.view.alpha = 1
                
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    copyImageView.removeFromSuperview()
            }
            
        } else {
            var window = UIApplication.sharedApplication().keyWindow
            var copyImageView = UIImageView(image: clickedImage.image)
            
            copyImageView.frame.origin = CGPoint(x: 0.0, y: 55.0)
            copyImageView.frame.size = CGSize(width: 320, height: 476)
            
            window.addSubview(copyImageView)
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                copyImageView.frame.size = CGSize(width: self.clickedImage.frame.width, height: self.clickedImage.frame.height)
                copyImageView.frame = window.convertRect(self.clickedImage.frame, fromView: self.scrollView)
                fromViewController.view.alpha = 0
                
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
                    copyImageView.removeFromSuperview()
            }
        }
    }
    
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
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
