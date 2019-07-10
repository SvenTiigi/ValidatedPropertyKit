//
//  Result+isSuccess.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 05.07.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

import Foundation

extension Result {
    
    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
}
