import SwiftUI

struct TempoButton: ViewModifier {
    var longPressGesture: AnyGesture<Bool>
    
    func body(content: Content) -> some View {
        return content
            .buttonStyle(TempoButtonStyle())
            .contentShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)
            .simultaneousGesture(longPressGesture)
            .background(Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

extension Button {
    func tempoButton(
        longPressGesture: AnyGesture<Bool>
    ) -> some View {
        modifier(
            TempoButton(longPressGesture: longPressGesture)
        )
    }
}
