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
    }



}

