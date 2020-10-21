//
//  Int_Extension.swift
//  Capsule
//
//  Created by Gio Lomsa on 10/20/20.
//  Copyright © 2020 Giorgi Lomsadze. All rights reserved.
//

import Foundation

extension Int{
    
    public var isSuccessHTTPCode: Bool {
        return 200 <= self && self < 300
    }
    
}
