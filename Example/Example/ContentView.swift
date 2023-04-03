import Combine
import SwiftUI
import ValidatedPropertyKit

final class ContentModel: ObservableObject {
    @PublishedValidated(.range(3...))
    var username = "" {
        didSet {
            usernameInvalid = !_username.isValid
            usernameInvalidAfterChanges = _username.isInvalidAfterChanges
        }
    }

    @Published
    var usernameInvalid = true

    @Published
    var usernameInvalidAfterChanges = false
}

struct ContentView {
    @Validated(!.isEmpty)
    var username = String()

    @ObservedObject
    var model = ContentModel()

    @FocusState var focus
}

extension ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section(
                    header: Text(verbatim: "Username"),
                    footer: Group {
                        Text(
                            verbatim: _username.isInvalidAfterChanges ? "Username is not valid" : ""
                        )
                        .foregroundColor(.red)
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
                ) {}

                Section(
                    header: Text(verbatim: "View Model Username"),
                    footer: Group {
                        Text(
                            verbatim: model.usernameInvalidAfterChanges ? "Username is not valid" : ""
                        )
                        .foregroundColor(.red)
                    }
                ) {
                    TextField(
                        "John Doe",
                        text: $model.username
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
                    .disabled(model.usernameInvalid)
                ) {}
            }
            .navigationTitle("ValidatedPropertyKit")
        }
    }
}
