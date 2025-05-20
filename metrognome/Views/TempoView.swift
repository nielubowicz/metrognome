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
                ForEach([1, 2, 4, 8, 16, 32, 64], id: \.self) { value in
                    Text(value.formatted()).tag(value)
                }
            }
        }
        .frame(minWidth: 120)
    }
}
