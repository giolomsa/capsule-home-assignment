//
//  SceneDelegate.swift
//  Capsule
//
//  Created by Gio Lomsa on 10/20/20.
//  Copyright © 2020 Giorgi Lomsadze. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    //Blur view for security
    var blurView: UIVisualEffectView?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        blurView?.removeFromSuperview()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        
        //Create blur view and add it to the top view controller every time app goes into background mode
        //to keep private information safe
        blurView?.removeFromSuperview()
        
        if blurView == nil{
            let blurEffect = UIBlurEffect(style: .light)
            blurView = UIVisualEffectView(effect: blurEffect)
        }
        let topViewController = UIApplication.shared.topViewController()
        blurView!.translatesAutoresizingMaskIntoConstraints = false
        topViewController.view.addSubview(blurView!)
        
        blurView!.topAnchor.constraint(equalTo: topViewController.view.topAnchor).isActive = true
        blurView!.leadingAnchor.constraint(equalTo: topViewController.view.leadingAnchor).isActive = true
        blurView!.trailingAnchor.constraint(equalTo: topViewController.view.trailingAnchor).isActive = true
        blurView!.bottomAnchor.constraint(equalTo: topViewController.view.bottomAnchor).isActive = true
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        blurView?.removeFromSuperview()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

