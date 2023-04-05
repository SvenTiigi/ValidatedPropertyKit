import Combine
import RegexBuilder
import SwiftUI
import ValidatedPropertyKit

final class ContentModel: ObservableObject {
    @PublishedValidated(
        .range(3..., error: "Username is too short")
            && .regex(Regex { OneOrMore(.digit) }, error: "Requires 1+ digits")
    )
    var username = "" {
        didSet {
            usernameInvalid = !_username.isValid
            usernameError = _username.errorAfterChanges
        }
    }

    @Published
    var usernameInvalid = true

    @Published
    var usernameError: String? = nil
}

struct ContentView {
    @Validated(!.isEmpty(error: "Username is not valid"))
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
                            verbatim: model.usernameError ?? ""
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

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
