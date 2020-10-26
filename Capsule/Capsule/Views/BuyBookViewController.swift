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
        
        if #available(iOS 13, *){
            //We don't need the close button, iOS 13 uses popover modal presentation 
        }else{
            setupCloseButton()
        }
        
    }
    
    
    private func setupCloseButton(){
        let closeButton = RoundButton(title: "Close")
        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        closeButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
    }
    
    @objc private func dismissSelf(){
        self.dismiss(animated: true, completion: nil)
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
