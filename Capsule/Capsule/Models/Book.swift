//
//  Book.swift
//  Capsule
//
//  Created by Gio Lomsa on 10/23/20.
//  Copyright © 2020 Giorgi Lomsadze. All rights reserved.
//

import Foundation

class BuyLink: Codable{
    var name: String
    var url: String
}

class Book: Codable{
    
    var title: String
    var rank: Int
    var publisher: String
    var description: String
    var price: Int
    var author: String
    var contributor: String
    var bookImage: String
    var bookImageWidth: Int
    var bookImageHeight: Int
    var amazonProductUrl: String
    var ageGroup: String
    var buyLinks: [BuyLink]
    
    enum CodingKeys: String, CodingKey{
        case title = "title"
        case rank = "rank"
        case publisher = "publisher"
        case description = "description"
        case price = "price"
        case author = "author"
        case contributor = "contributor"
        case bookImage = "book_image"
        case bookImageWidth = "book_image_width"
        case bookImageHeight = "book_image_height"
        case amazonProductUrl = "amazon_product_url"
        case ageGroup = "age_group"
        case buyLinks = "buy_links"
    }
}
