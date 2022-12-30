import SwiftUI

// MARK: - View+validated

public extension View {
    
    /// Adds a condition that controls whether users can interact with this view
    /// if all given `Validatable` instances are valid
    /// - Parameter validatable: A varadic sequence of Validatable instances
    func validated(
        _ validatables: Validatable...
    ) -> some View {
        self.disabled(
            validatables.contains { !$0.isValid }
        )
    }
    
}
