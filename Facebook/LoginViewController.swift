//
//  LoginViewController.swift
//  Facebook
//
//  Created by Hana Kim on 9/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var defaults = NSUserDefaults.standardUserDefaults()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

        enableLogin()
        
        defaults.setInteger(0, forKey: "first_time")
        defaults.synchronize()
    }

    @IBAction func changedPasswordTextField(sender: UITextField) {
        enableLogin()
    }
    
    @IBAction func changedEmailTextField(sender: UITextField) {
        enableLogin()
    }
    
    func enableLogin () {
        if (emailTextField.text == "") || (passwordTextField.text == "") {
            loginButton.enabled = false
        } else {
            loginButton.enabled = true
        }
    }
    
    
    
    @IBAction func didpressLoginButton(sender: UIButton) {
        
        activityIndicator.startAnimating()
        loginButton.selected = true
        
        delay(2) {
            
            self.activityIndicator.stopAnimating()
            self.loginButton.selected = false
            
            if (self.emailTextField.text == "Name") && (self.passwordTextField.text == "Pass") {
            
                self.performSegueWithIdentifier("LoginSegue", sender: self)
            } else {
                
                var alertView = UIAlertView(title: "Nope", message: "You Shall not Pass!", delegate: self, cancelButtonTitle: "OK")
                
                alertView.show()
                
            }
            
        }
    }
    
    
    
    
    func keyboardWillShow(notification: NSNotification!) {
        
        var userInfo = notification.userInfo!
        
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(rawValue: UInt(animationCurve << 16)), animations: {
            
            println("Show")
            
            self.loginView.frame.origin = CGPoint(x: 0,y: 40)
            
            // Set view properties in here that you want to match with the animation of the keyboard
            // If you need it, you can use the kbSize property above to get the keyboard width and height.
            }, completion: nil)
        
    }
    
    @IBAction func onTapView(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        
        var userInfo = notification.userInfo!
        
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(rawValue: UInt(animationCurve << 16)), animations: {
            
            println("Hide")
            
            self.loginView.frame.origin = CGPoint(x: 0,y: 130)
            
            // Set view properties in here that you want to match with the animation of the keyboard
            // If you need it, you can use the kbSize property above to get the keyboard width and height.
            }, completion: nil)
        
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






