//
//  ViewController.swift
//  Browser_Using_WebView
//
//  Created by Captain on 13/12/19.
//  Copyright © 2019 Captain. All rights reserved.
// https://www.youtube.com/watch?v=IzNJfMzjOkQ

import UIKit
import WebKit
class ViewController: UIViewController,UISearchBarDelegate,WKNavigationDelegate {
    
    @IBOutlet var browserView: WKWebView!
    @IBOutlet var searchWeb: UISearchBar!
    @IBOutlet var back: UIBarButtonItem!
    @IBOutlet var forward: UIBarButtonItem!
    @IBOutlet var toolsBar: UIToolbar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setToolbarHidden(true, animated: true)
        browserView.load(URLRequest(url: URL(string: "https://www.google.com/")!))
       browserView.navigationDelegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func forwardButton(_ sender: Any) {
        
        if browserView.canGoForward{
            browserView.goForward()       }
    }
    
    @IBAction func refreshButton(_ sender: Any) {
    browserView.reload()
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        if browserView.canGoBack{
            browserView.goBack()
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        browserView.resignFirstResponder() //Resign the the Keyboard
        if let url = URL(string: searchWeb.text!){
          browserView.load(URLRequest(url: url))
            }
        else {
            print("Not valid ")
        }
    }
    
    
    //manage backButotn and Forward Button
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        back.isEnabled = browserView.canGoBack
        forward.isEnabled = browserView.canGoForward
    }
    
    
    //manage loading events

    
    
}

