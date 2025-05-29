import SwiftUI

    struct TempoEntryView: View {
        @Environment(\.dismiss) var dismiss
        
        @Binding var tempo: Int
        @State private var localTempo: String = ""
        
        @FocusState private var textFieldFocused
        
        var body: some View {
            VStack {
                Text(L10n.enterTempo)
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
                TextField(L10n.tempoBpm, text: $localTempo)
                    .focused($textFieldFocused)
                    .padding(8)
                    .overlay {
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.secondary, lineWidth: 1)
                    }
                    .padding()

                Button(L10n.done) {
                    tempo = Int(localTempo) ?? 0
                    textFieldFocused = false
                    dismiss()
                }
                .disabled(localTempo.isEmpty)
            }
            .padding(48)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .onAppear {
                localTempo = tempo.formatted()
                textFieldFocused = true
            }
        }
    }

#Preview {
    @Previewable
    @State var tempo = 120
    TempoEntryView(tempo: $tempo)
}
