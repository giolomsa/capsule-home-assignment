//
//  List.swift
//  Capsule
//
//  Created by Gio Lomsa on 10/23/20.
//  Copyright © 2020 Giorgi Lomsadze. All rights reserved.
//

import Foundation

class ListResponse: Codable{
    var status: String
    var results: [List]
    
    init(status: String, results: [List]) {
        self.status = status
        self.results = results
    }
}

class ListDetailsResponse: Codable{
    var status: String
    var results: List
    
    init(status: String, results: List) {
        self.status = status
        self.results = results
    }
}

class List: Codable{
    
    enum ListUpdated: String, Codable{
        case weekly = "WEEKLY"
        case monthly = "MONTHLY"
    }
    
    var name: String
    var displayName: String
    var encodedName: String
    var publishedDate: String?
    var oldestPublishedDate: String?
    var newestPublishDate: String?
    var updated: ListUpdated
    var books: [Book]?

    init(name: String, displayName: String, encodedName: String, publishedDate: String, oldestPublishedDate: String, newestPublishDate: String, updated: ListUpdated) {
        
        self.name = name
        self.displayName = displayName
        self.encodedName = encodedName
        self.publishedDate = publishedDate
        self.oldestPublishedDate = oldestPublishedDate
        self.newestPublishDate = newestPublishDate
        self.updated = updated
    }
    
    enum TopLevelCodingKeys: CodingKey{
        case results
        case status
    }
    
    enum CodingKeys: String, CodingKey{
        case name = "list_name"
        case displayName = "display_name"
        case encodedName = "list_name_encoded"
        case publishedDate = "published_date"
        case oldestPublishedDate = "oldest_published_date"
        case newestPublishDate = "newest_published_date"
        case updated = "updated"
        case books = "books"
    }
    
    required init(from decoder: Decoder) throws {
        let mainContainer =  try decoder.container(keyedBy: CodingKeys.self)
        self.name = try mainContainer.decode(String.self, forKey: .name)
        self.displayName = try mainContainer.decode(String.self, forKey: .displayName)
        self.encodedName = try mainContainer.decode(String.self, forKey: .encodedName)
        self.publishedDate = try? mainContainer.decode(String.self, forKey: .publishedDate)
        self.oldestPublishedDate = try? mainContainer.decode(String.self, forKey: .oldestPublishedDate)
        self.newestPublishDate = try? mainContainer.decode(String.self, forKey: .newestPublishDate)
        let updatedString = try mainContainer.decode(String.self, forKey: .updated)
        self.updated = ListUpdated(rawValue: updatedString) ?? ListUpdated.monthly
        self.books = try? mainContainer.decode([Book].self, forKey: .books)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
}
