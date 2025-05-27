import SwiftUI

extension Binding where Value == Int {
    var nonNegative: Binding<Int> {
        Binding(
            get: { self.wrappedValue },
            set: { self.wrappedValue = $0 > 0 ? $0 : 0 }
        )
    }
}
