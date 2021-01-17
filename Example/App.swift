//
//  App.swift
//  Example
//
//  Created by Sven Tiigi on 21.11.2020.
//  Copyright © 2020 Sven Tiigi. All rights reserved.
//

import SwiftUI

// MARK: - App

/// The App
@main
struct App: SwiftUI.App {
    
    /// The content and behavior of the app.
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoginView()
                    .navigationBarTitle("Login")
            }
        }
    }
    
}
