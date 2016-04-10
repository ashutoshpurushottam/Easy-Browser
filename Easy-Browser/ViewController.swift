//
//  ViewController.swift
//  Easy-Browser
//
//  Created by Ashutosh Purushottam on 4/10/16.
//  Copyright © 2016 Vivid Designs. All rights reserved.
//

import UIKit
import WebKit



class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func loadView()
    {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        let url = NSURL(string: "https://www.hackingwithswift.com")!
        webView.loadRequest(NSURLRequest(URL: url))
        // allows users to swipe from the left or right edge to move backward or forward in their web browsing
        webView.allowsBackForwardNavigationGestures = true
        // add button to the navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .Plain, target: self, action: "openTapped")
    }
    
    func openTapped()
    {
        let uc = UIAlertController(title: "Open Page..", message: nil, preferredStyle: .ActionSheet)
        uc.addAction(UIAlertAction(title: "apple.com", style: .Default, handler: openPage))
        uc.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(uc, animated: true, completion: nil)
    }
    
    func openPage(action: UIAlertAction)
    {
        let url = NSURL(string: "https://" + action.title!)!
        webView.loadRequest(NSURLRequest(URL: url))
    }
    



}

