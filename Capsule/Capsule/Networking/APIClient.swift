//
//  APIClient.swift
//  Capsule
//
//  Created by Gio Lomsa on 10/20/20.
//  Copyright © 2020 Giorgi Lomsadze. All rights reserved.
//

import UIKit

class APIClient{
    
    let httpLayer: HTTPLayer
    var defaultError: NSError = NSError(domain: "NYTimes API error", code: 1, userInfo: nil)
    
    enum Result<Element>{
        case success(Element)
        case failure(NSError)
    }
    
    init(httpLayer: HTTPLayer){
        self.httpLayer = httpLayer
    }
    
    // MARK: Load list
    func getLists(completion: @escaping (Result<[List]>)-> Void){
        
        self.httpLayer.request(endpoint: .lists) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode.isSuccessHTTPCode,
                let data = data
                else {
                    if let error = error{
                        completion(.failure(error as NSError))
                    }
                    return
            }
            do{
                let decoder = JSONDecoder()
                let listResponse = try decoder.decode(ListResponse.self, from: data)
                completion(.success(listResponse.results))
                //                completion(.success([List]()))
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: Load list
    func getListsDetails(date: String, list: String, completion: @escaping (Result<List>)-> Void){
        
        self.httpLayer.request(endpoint: .listDetails(date, list)) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode.isSuccessHTTPCode,
                let data = data
                else {
                    if let error = error{
                        completion(.failure(error as NSError))
                    }
                    return
            }
            do{
                let decoder = JSONDecoder()
                let listResponse = try decoder.decode(ListDetailsResponse.self, from: data)
                completion(.success(listResponse.results))
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK:- Download image from url
    func downloadImage(urlString: String, completion: @escaping (Result<Data>) -> Void){
        
        self.httpLayer.request(endpoint: .fromUrl(urlString)) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode.isSuccessHTTPCode,
                let data = data
                else {
                    if let error = error{
                        completion(.failure(error as NSError))
                    }
                    return
            }
            completion(.success(data))
        }
    }
    
}
