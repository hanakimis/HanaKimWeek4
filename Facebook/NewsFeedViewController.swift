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
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var imageThree: UIImageView!
    @IBOutlet weak var imageFour: UIImageView!
    @IBOutlet weak var imageFive: UIImageView!
    
    var isPresenting: Bool = true
    var clickedImage: UIImageView!
    var whichImage = 0
    
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
        
        imageOne.tag = 0
        imageTwo.tag = 1
        imageThree.tag = 2
        imageFour.tag = 3
        imageFive.tag = 4
        
        // Comment out this section so don't have to wait ot test photo stuff
        /* ***********************************************
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
        *********************************************** */

        feedImageView.alpha = 1
        
        scrollView.contentInset.top = 0
        scrollView.contentInset.bottom = 50
        scrollView.scrollIndicatorInsets.top = 0
        scrollView.scrollIndicatorInsets.bottom = 50
    }
    
    
    @IBAction func tapPhotoOpen(tapedImage: UITapGestureRecognizer) {
        clickedImage = tapedImage.view as UIImageView!
        // need to be able to detect which image was tapped....
        whichImage = clickedImage.tag
        
        performSegueWithIdentifier("viewPhotoSegue", sender: self)
    }
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if let id = segue.identifier {
            switch id {
            case "viewPhotoSegue":
                var destinationViewController = segue.destinationViewController as PhotoViewController
                destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
                destinationViewController.transitioningDelegate = self
                
                destinationViewController.image = self.clickedImage.image
                destinationViewController.whichImage = self.whichImage
                
                destinationViewController.imageCount = 5
                destinationViewController.images.append(self.imageOne.image!)
                destinationViewController.images.append(self.imageTwo.image!)
                destinationViewController.images.append(self.imageThree.image!)
                destinationViewController.images.append(self.imageFour.image!)
                destinationViewController.images.append(self.imageFive.image!)
                
            default:
                println("I... am only ready for the segue to the photo detail view")
            }
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
        
        if (isPresenting) {
            var window = UIApplication.sharedApplication().keyWindow
            var thisFrame = window?.convertRect(clickedImage.frame, fromView: scrollView)
            var copyImageView = UIImageView(frame: thisFrame!)
            
            copyImageView.image = clickedImage.image
            copyImageView.clipsToBounds = true
            copyImageView.contentMode = UIViewContentMode.ScaleAspectFill
            window?.addSubview(copyImageView)
            
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                copyImageView.frame.size.width = 320
                copyImageView.frame.size.height = 320 * (copyImageView.image!.size.height / copyImageView.image!.size.width)
                copyImageView.center = window!.center
                
                toViewController.view.alpha = 1
                
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    copyImageView.removeFromSuperview()
            }
            
        } else {
            var window = UIApplication.sharedApplication().keyWindow!
            var photoViewController = fromViewController as PhotoViewController
            var copyImageView: UIImageView!
            var toFrame: CGRect!
            switch photoViewController.whichImage {
            case 0:
                copyImageView = UIImageView(image: imageOne.image)
                toFrame = imageOne.frame
            case 1:
                copyImageView = UIImageView(image: imageTwo.image)
                toFrame = imageTwo.frame
            case 2:
                copyImageView = UIImageView(image: imageThree.image)
                toFrame = imageThree.frame
            case 3:
                copyImageView = UIImageView(image: imageFour.image)
                toFrame = imageFour.frame
            case 4:
                copyImageView = UIImageView(image: imageFive.image)
                toFrame = imageFive.frame
            default:
                copyImageView = UIImageView(image: clickedImage.image)
                println("there is an error... unexpected image number")
            }
            copyImageView.contentMode = UIViewContentMode.ScaleAspectFill
            copyImageView.clipsToBounds = true
            
            copyImageView.frame.size.width = 320
            copyImageView.frame.size.height = 320 * (copyImageView.image!.size.height / copyImageView.image!.size.width)
            copyImageView.center.y = window.center.y - photoViewController.scrollOffset
            window.addSubview(copyImageView)
            
            fromViewController.view.alpha = 0
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                copyImageView.frame = window.convertRect(toFrame, fromView: self.scrollView)

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
