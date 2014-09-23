//
//  SettingsViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIActionSheetDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var settingsImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentSize = CGSizeMake(320, settingsImageView.image!.size.height)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentInset.top = 0
        scrollView.contentInset.bottom = 50
        scrollView.scrollIndicatorInsets.top = 0
        scrollView.scrollIndicatorInsets.bottom = 50
    }
    
    @IBAction func didPressLogout(sender: UIButton) {
        
        var actionSheet = UIActionSheet(title: "Log Out",delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: "Log Out")
        actionSheet.addButtonWithTitle("whatever")
        actionSheet.showInView(view)
        
    }
    
    func actionSheet(actionSheet: UIActionSheet!, clickedButtonAtIndex buttonIndex: Int) {
        
        println("booyah!")
        println("Button index is \(buttonIndex)")
        
        if (buttonIndex == 0) {
            
            performSegueWithIdentifier("LogoutSegue", sender: self)
            
        }
        
    // buttonIndex is 1 for Cancel
    // buttonIndex ranges from 1-n for the other buttons.
}
   
}
