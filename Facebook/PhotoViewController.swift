//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Hana Kim on 10/2/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = self.image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func onTapDone(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
