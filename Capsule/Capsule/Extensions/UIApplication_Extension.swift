//
//  UIApplication_Extension.swift
//  Capsule
//
//  Created by Gio Lomsa on 10/26/20.
//  Copyright © 2020 Giorgi Lomsadze. All rights reserved.
//

import UIKit

extension UIApplication{
    
    func topViewController()-> UIViewController{
        let keyWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first!
        var topViewController = keyWindow.rootViewController!
        while let presentedViewController = topViewController.presentingViewController{
            topViewController = presentedViewController
        }
        return topViewController
    }
}
