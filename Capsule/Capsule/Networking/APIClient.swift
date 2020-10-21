//
//  APIClient.swift
//  Capsule
//
//  Created by Gio Lomsa on 10/20/20.
//  Copyright © 2020 Giorgi Lomsadze. All rights reserved.
//

import Foundation

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
    
    //load list
    func getBooksObjects(completion: @escaping (Result<[String]>)-> Void){
        
        self.httpLayer.request(at: .books) { (data, response, error) in
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
                let rootItems = try decoder.decode([String].self, from: data)
                completion(.success(rootItems))
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
}
