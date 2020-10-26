//
//  BookCell.swift
//  Capsule
//
//  Created by Gio Lomsa on 10/25/20.
//  Copyright © 2020 Giorgi Lomsadze. All rights reserved.
//

import UIKit

protocol BookCellDelegate: class{
    func didSelectBuyBook(book: Book)
}

class BookCell: UITableViewCell {

    weak var delegate: BookCellDelegate?
    
    private var titleLabel = UILabel()
    private var authorLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var coverImageView = UIImageView()
    private var buyBookButton = PrimaryButton(title: "Buy Book")
    private var currentBook: Book!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(book: Book){
        setupUI()
        self.currentBook = book
        titleLabel.text = "\(book.title)"
        authorLabel.text = "By \(book.author)"
        descriptionLabel.text = "\(book.description)"
        
        let viewModel = ListsViewModel()
        DispatchQueue.global(qos: .background).async {
            viewModel.loadImageFromUrl(urlString: book.bookImage) { (image) in
                DispatchQueue.main.async {
                    self.coverImageView.image = image
                }
            }
    }
}
    
    private func setupUI(){
        
        for element in [titleLabel, authorLabel, descriptionLabel, coverImageView, buyBookButton]{
            element.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(element)
        }
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 16)
        
        authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        authorLabel.numberOfLines = 0
        authorLabel.font = .systemFont(ofSize: 14)
                        
        coverImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10).isActive = true
        coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        coverImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        coverImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        coverImageView.layer.cornerRadius = 5
        
        descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 14)
        
        buyBookButton.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 10).isActive = true
        buyBookButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        buyBookButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        buyBookButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        buyBookButton.setTitleColor(.black, for: .normal)
        buyBookButton.addTarget(self, action: #selector(didPressBuyBook), for: .touchUpInside)
        
    }
    
    @objc private func didPressBuyBook(){
        delegate?.didSelectBuyBook(book: self.currentBook)
    }
    
}
