//
//  HTTPLayer.swift
//  Capsule
//
//  Created by Gio Lomsa on 10/20/20.
//  Copyright © 2020 Giorgi Lomsadze. All rights reserved.
//

import Foundation

class HTTPLayer{
    
    private let urlSession = URLSession.shared
    
    enum Endpoint{
        
        case lists
        case listDetails(String, String)
        case fromUrl(String)

        var path: String{
            switch self {
            case .lists:
                return Constants.baseUrl + Constants.listsUrl
            case .listDetails(let date, let list):
                return Constants.baseUrl + Constants.listDetails + "\(date)/" + "\(list).json"
            case .fromUrl(let url):
                return url
            }
        }
        
        var apiKeyRequired: Bool{
            switch self {
            case .fromUrl(_):
                return false
            default:
                return true
            }
        }
    }

    // MARK: Add api key to URL if required
    private func addApiKeyIfnecessary(endpoint: Endpoint, urlComponents: URLComponents)-> URLComponents{
        if endpoint.apiKeyRequired{
            var updatedUrlComponents = urlComponents
            let apiKey = [URLQueryItem(name: "api-key", value: Constants.apiKey)]
            var queryItems = updatedUrlComponents.queryItems ?? []
            queryItems.append(contentsOf: apiKey)
            updatedUrlComponents.queryItems = queryItems
            return updatedUrlComponents
        }else{
            return urlComponents
        }
    }

    // MARK: UrlSession main method
    func request(endpoint: Endpoint, completion: @escaping (Data?, URLResponse?, Error?)-> Void){
        
        let baseUrlComponents = addApiKeyIfnecessary(endpoint: endpoint, urlComponents: URLComponents(string: endpoint.path) ?? URLComponents())
        guard let url = baseUrlComponents.url else {return }
        print(url.absoluteString)
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            //temp for debuging
            if let _response  = response as? HTTPURLResponse{
                print(_response.statusCode)
            }
            //
            completion(data, response, error)
        }
        task.resume()
    }
}
