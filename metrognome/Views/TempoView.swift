import SwiftUI

struct TempoView: View {
    @Binding var tempo: Tempo
    
    var body: some View {
        HStack {
            Picker("", selection: $tempo.numerator) {
                ForEach(1..<13) { Text($0.formatted()).tag($0) }
            }
            Text("/")
            Picker("", selection: $tempo.denominator) {
                ForEach(1..<13) { Text($0.formatted()).tag($0) }
            }
        }
        .frame(minWidth: 120)
        .background(.white)
    }
}
