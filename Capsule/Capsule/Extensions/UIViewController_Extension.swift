//
//  UIViewController_Extension.swift
//  Capsule
//
//  Created by Gio Lomsa on 10/23/20.
//  Copyright © 2020 Giorgi Lomsadze. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func showActivity(){
        let overlayView = UIView()
        let activityIndicator: UIActivityIndicatorView!
        
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView(style: .medium)
        } else {
            activityIndicator = UIActivityIndicatorView(style: .gray)
        }
        
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.tag = 998
        overlayView.tag = 999
        overlayView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        self.view.addSubview(overlayView)
        self.view.addSubview(activityIndicator)
        
        overlayView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        overlayView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        overlayView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        overlayView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        activityIndicator.startAnimating()
    }
    
    func stopActivity(){
        if let activityIndicator = self.view.viewWithTag(998) as? UIActivityIndicatorView{
            activityIndicator.removeFromSuperview()
        }
        
        if let activityIndicator = self.view.viewWithTag(999){
            activityIndicator.removeFromSuperview()
        }
    }
    
    func showBuyBookAlert(title: String, message: String, buyLinks: [BuyLink]){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for buyOption in buyLinks{
            
            let action = UIAlertAction(title: buyOption.name, style: .default) { (action) in
                if let vc = self as? ListDetailsViewController{
                    vc.openBuyBookPage(link: buyOption.url)
                }
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showSimpleAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
