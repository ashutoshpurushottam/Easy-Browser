//
//  WebViewController.swift
//  Easy-Browser
//
//  Created by Ashutosh Purushottam on 4/10/16.
//  Copyright © 2016 Vivid Designs. All rights reserved.
//

import UIKit
import WebKit



class WebViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var progressView: UIProgressView!
    var webSite: String!
    
    override func loadView()
    {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        let url = NSURL(string: "https://" + webSite)!
        webView.loadRequest(NSURLRequest(URL: url))
        // allows users to swipe from the left or right edge to move backward or forward in their web browsing
        webView.allowsBackForwardNavigationGestures = true
        // add button to the navigation bar
        progressView = UIProgressView(progressViewStyle: .Default)
        progressView.sizeToFit()
        
        // navigation bar item
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "backTapped")
        
        // set toolbar at the bottom of the scree
        let progressButton = UIBarButtonItem(customView: progressView)
        let spacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .Refresh, target: webView, action: "reload")
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.toolbarHidden = false
        
        // watch for estimated progress 
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
        
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>)
    {
        progressView.progress = Float(webView.estimatedProgress)
    }
    
    
    func refreshTapped()
    {
        webView.reload()
    }
    
    func backTapped()
    {
        webView.removeObserver(self, forKeyPath: "estimatedProgress", context: nil)
        dismissViewControllerAnimated(true, completion: nil)
    }
    

}

