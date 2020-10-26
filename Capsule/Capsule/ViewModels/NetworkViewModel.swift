//
//  NetworkViewModel.swift
//  Capsule
//
//  Created by Gio Lomsa on 10/23/20.
//  Copyright © 2020 Giorgi Lomsadze. All rights reserved.
//

import Foundation

class NetworkViewModel{
    let httpLayer = HTTPLayer()
    let apiClient: APIClient!
    
    init(){
        self.apiClient = APIClient(httpLayer: httpLayer)
    }
}
