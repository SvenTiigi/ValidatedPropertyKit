import SwiftUI
import ValidatedPropertyKit

struct ContentView {
    
    @Validated(!.isEmpty)
    var username = String()
    
}

extension ContentView: View {
    
    var body: some View {
        NavigationView {
            List {
                Section(
                    header: Text(verbatim: "Username"),
                    footer: Group {
                        if self._username.isInvalidAfterChanges {
                            Text(
                                verbatim: "Username is not valid"
                            )
                            .foregroundColor(.red)
                        }
                    }
                ) {
                    TextField(
                        "John Doe",
                        text: self.$username
                    )
                }
                Section(
                    footer: Button(
                        action: {
                            print("Login")
                        }
                    ) {
                        Text(verbatim: "Login")
                    }
                    .buttonStyle(.borderedProminent)
                    .validated(self._username)
                ) {
                    
                }
            }
            .navigationTitle("ValidatedPropertyKit")
        }
    }
    
}
