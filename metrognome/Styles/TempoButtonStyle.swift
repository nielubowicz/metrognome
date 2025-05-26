import SwiftUI

struct TempoButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .font(.title)
            .foregroundStyle(.white)
    }
    
}

