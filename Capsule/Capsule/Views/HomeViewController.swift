//
//  HomeViewController.swift
//  Capsule
//
//  Created by Gio Lomsa on 10/23/20.
//  Copyright © 2020 Giorgi Lomsadze. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: local variables/constants
    private let backgroundImageView = UIImageView(image: UIImage(named: "bg"))
    private let openListsButton = PrimaryButton(title: "Best Seller Lists")
    
    // MARK: lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        setupUIElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: local methods
    private func setupBackgroundImage(){
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    private func setupUIElements(){
        openListsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(openListsButton)
        
        openListsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        openListsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        openListsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        openListsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        openListsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        openListsButton.addTarget(self, action: #selector(openListsTapped), for: .touchUpInside)
    }
    
    @objc private func openListsTapped(){
        let listsViewController = ListsViewController()
        self.navigationController?.pushViewController(listsViewController, animated: true)
    }
}
