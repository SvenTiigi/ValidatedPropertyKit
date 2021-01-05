//
//  LoginView.swift
//  Example
//
//  Created by Sven Tiigi on 05.01.21.
//  Copyright © 2021 Sven Tiigi. All rights reserved.
//

import SwiftUI
import ValidatedPropertyKit

struct LoginView: View {
    
    @Validated(!.isEmpty && .contains("@"))
    var mailAddress = String()
    
    @Validated(!.isEmpty)
    var password = String()
    
    var body: some View {
        List {
            TextField("E-Mail", text: self.$mailAddress)
            TextField("Password", text: self.$password)
            Button(
                action: {
                    print("Login \(self.mailAddress):\(self.password)")
                },
                label: {
                    Text("Submit")
                }
            )
            .validated(self._mailAddress, self._password)
        }
        .listStyle(InsetGroupedListStyle())
    }
    
}
