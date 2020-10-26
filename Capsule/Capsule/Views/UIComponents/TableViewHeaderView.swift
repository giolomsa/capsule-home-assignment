//
//  TableViewHeaderView.swift
//  Capsule
//
//  Created by Gio Lomsa on 10/25/20.
//  Copyright © 2020 Giorgi Lomsadze. All rights reserved.
//

import UIKit

class TableViewHeaderView: UIView {
    
    private var list: List
    private var width: CGFloat
    
    private let titleLabel = UILabel()
    private let updatedLabel = UILabel()
    private let numberOfBooksLabel = UILabel()
    
    init(list: List, width: CGFloat){
        self.list = list
        self.width = width
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: self.width).isActive = true
        backgroundColor = .white
        layer.borderColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        layer.borderWidth = 2
        
        for element in [titleLabel, updatedLabel, numberOfBooksLabel]{
            element.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(element)
        }
        
        titleLabel.text = self.list.displayName
        titleLabel.font = .systemFont(ofSize: 24)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        
        updatedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        updatedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        updatedLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        
        updatedLabel.text = "Publish date: \(list.publishedDate ?? "")"
        updatedLabel.font = .systemFont(ofSize: 16)
        
        numberOfBooksLabel.topAnchor.constraint(equalTo: updatedLabel.bottomAnchor, constant: 10).isActive = true
        numberOfBooksLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        numberOfBooksLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        numberOfBooksLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        numberOfBooksLabel.text = String("Number of books: \(self.list.books?.count ?? 0)")
        numberOfBooksLabel.font = .systemFont(ofSize: 16)
        
    }
}
