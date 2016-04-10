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
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]
    
    override func loadView()
    {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        let url = NSURL(string: "https://" + websites[0])!
        webView.loadRequest(NSURLRequest(URL: url))
        // allows users to swipe from the left or right edge to move backward or forward in their web browsing
        webView.allowsBackForwardNavigationGestures = true
        // add button to the navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .Plain, target: self, action: "openTapped")
        progressView = UIProgressView(progressViewStyle: .Default)
        progressView.sizeToFit()
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
    
    func openTapped()
    {
        let uc = UIAlertController(title: "Open Page..", message: nil, preferredStyle: .ActionSheet)
        for website in websites
        {
            uc.addAction(UIAlertAction(title: website, style: .Default, handler: openPage))
        }
        presentViewController(uc, animated: true, completion: nil)
    }
    
    func openPage(action: UIAlertAction)
    {
        let url = NSURL(string: "https://" + action.title!)!
        webView.loadRequest(NSURLRequest(URL: url))
    }
    
    func refreshTapped()
    {
        webView.reload()
    }
    
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void)
    {
        let url = navigationAction.request.URL
        if let host = url!.host
        {
            for website in websites
            {
                if host.rangeOfString(website) != nil
                {
                    decisionHandler(.Allow)
                    return
                }
            }

        }
        
        decisionHandler(.Cancel)
    }
    



}

