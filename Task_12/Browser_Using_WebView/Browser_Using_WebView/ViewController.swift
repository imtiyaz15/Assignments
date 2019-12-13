//
//  ViewController.swift
//  Browser_Using_WebView
//
//  Created by Captain on 13/12/19.
//  Copyright © 2019 Captain. All rights reserved.
// https://www.youtube.com/watch?v=IzNJfMzjOkQ

import UIKit
import WebKit
class ViewController: UIViewController {
    
    @IBOutlet var searchBrowser: UISearchBar!
    @IBOutlet var browserView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        browserView.loadRequest(URLRequest(url: URL(string: "https://www.google.com/")!))
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func forwardButton(_ sender: Any) {
    }
    
    @IBAction func refreshButton(_ sender: Any) {
    }
    @IBAction func backButton(_ sender: Any) {
    }
    
}

