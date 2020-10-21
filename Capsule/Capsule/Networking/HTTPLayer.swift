//
//  HTTPLayer.swift
//  Capsule
//
//  Created by Gio Lomsa on 10/20/20.
//  Copyright © 2020 Giorgi Lomsadze. All rights reserved.
//

import Foundation

class HTTPLayer{
    
    let urlSession = URLSession.shared
    
    enum Endpoint{
        case books
        case fromUrl(String)

        var path: String{
            switch self {
            case .books:
                return Constants.baseUrl
            case .fromUrl(let url):
                return url
            }
        }
    }
    
    func request(at endpoint: Endpoint, completion: @escaping (Data?, URLResponse?, Error?)-> Void){
        
        let urlString = endpoint.path
                
        guard let url = URL(string: urlString) else {return }
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
    }
}
