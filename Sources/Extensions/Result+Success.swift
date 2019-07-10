//
//  Result+Success.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 05.07.19.
//  Copyright © 2019 Sven Tiigi. All rights reserved.
//

import Foundation

// MARK: - Result+Success

extension Result where Success == Void {
    
    /// The success Result case
    static var success: Result {
        return .success(())
    }
    
}
