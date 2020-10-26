//
//  BuyBookViewController.swift
//  Capsule
//
//  Created by Gio Lomsa on 10/25/20.
//  Copyright © 2020 Giorgi Lomsadze. All rights reserved.
//

import UIKit
import WebKit

class BuyBookViewController: UIViewController {
    
    var webView: WKWebView!
    var urlString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivity()
        if let url = URL(string: urlString){
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webView = nil
    }
}

extension BuyBookViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.stopActivity()
    }
}
