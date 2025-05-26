import SwiftUI

struct TempoView: View {
    @Binding var tempo: Tempo
    
    var body: some View {
        HStack {
            Menu {
                Picker(selection: $tempo.numerator) {
                    ForEach(1..<13) {
                        Text($0.formatted()).tag($0)
                    }
                } label: {}
            } label: {
                Text("\(tempo.numerator.formatted()) \(Image(systemName: "chevron.up.chevron.down"))")
                    .font(.title)
            }
            .id(tempo.numerator)
            .menuOrder(.fixed)
            
            Text("/")
                .font(.title)
            
            Menu {
                Picker(selection: $tempo.denominator) {
                    ForEach([1, 2, 4, 8, 16, 32, 64], id: \.self) { value in
                        Text(value.formatted()).tag(value)
                    }
                } label: {}
            } label: {
                Text("\(tempo.denominator.formatted()) \(Image(systemName: "chevron.up.chevron.down"))")
                    .font(.title)
            }
            .id(tempo.denominator)
            .menuOrder(.fixed)
        }
        .frame(minWidth: 120)
    }
}
