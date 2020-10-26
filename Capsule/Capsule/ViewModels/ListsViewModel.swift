//
//  HomeViewModel.swift
//  Capsule
//
//  Created by Gio Lomsa on 10/23/20.
//  Copyright © 2020 Giorgi Lomsadze. All rights reserved.
//

import UIKit

class ListsViewModel: NetworkViewModel{
    
    // MARK: static Notifications
    static let listsSetNotification = Notification.Name.init(rawValue: "gio.lomsa.listsSetNotification")
    static let listDetailsSetNotification = Notification.Name.init(rawValue: "gio.lomsa.listDetailsSetNotification")
    
    // MARK: local variables/constants
    private let imageCache = NSCache<NSString, UIImage>()
    
    var lists: [List] = []{
        didSet{
            NotificationCenter.default.post(name: ListsViewModel.listsSetNotification, object: nil)
        }
    }
    
    var selectedList: List?{
        didSet{
            NotificationCenter.default.post(name: ListsViewModel.listDetailsSetNotification, object: nil)
        }
    }
    
    // MARK: Load best seller lists
    func getBestSellerLists(){
        apiClient.getLists {[weak self] (result) in
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let lists):
                self?.lists = lists
            }
        }
    }
    
    // MARK: Load list details
    func getListDetails(date: String, list: String){
        apiClient.getListsDetails(date: date, list: list) {[weak self] (result) in
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let list):
                self?.selectedList = list
            }
        }
    }
    
    // MARK: Load image from URL
    func loadImageFromUrl(urlString: String, completion: @escaping(UIImage)->Void){
                    
            if let cachedImage = self.imageCache.object(forKey: NSString(string: urlString )){
                print("Image From Cach")
                completion(cachedImage)
            }else{
                apiClient.downloadImage(urlString: urlString, completion: { (result) in
                    switch result{
                    case .success(let imageData):
                       let image = UIImage(data: imageData) ?? UIImage()
                       self.imageCache.setObject(image, forKey: NSString(string: urlString))
                        print("Image From URL")
                        completion(image)
                    case .failure(let error):
                        print(error)
                        //TODO:- Show error alert
                        return
                }
            })
        }
    }
}
