//
//  PrimaryButton.swift
//  Capsule
//
//  Created by Gio Lomsa on 10/23/20.
//  Copyright © 2020 Giorgi Lomsadze. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
   
    private var title: String
    init(title: String){
        self.title = title
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(self.title, for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 18)
        backgroundColor = .white
        layer.cornerRadius = 30
        layer.borderColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        layer.borderWidth = 2
        
        widthAnchor.constraint(equalToConstant: 60).isActive = true
        heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
