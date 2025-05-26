import SwiftUI

struct TempoButton: ViewModifier {
    var tapGesture: AnyGesture<Void>
    var longPressGesture: AnyGesture<Bool>
    
    func body(content: Content) -> some View {
        return content
            .buttonStyle(TempoButtonStyle())
            .contentShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)
            .highPriorityGesture(tapGesture)
            .simultaneousGesture(longPressGesture)
            .background(Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

extension Button {
    func tempoButton(
        tapGesture: AnyGesture<Void>,
        longPressGesture: AnyGesture<Bool>
    ) -> some View {
        modifier(
            TempoButton(tapGesture: tapGesture, longPressGesture: longPressGesture)
        )
    }
}
