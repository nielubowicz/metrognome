import SwiftUI

struct BPMView: View {
    @Binding var bpm: Int
    
    @State private var timer: Timer?
    @State private var speedUpTimer: Timer?
    @State private var amount = 1
    @State private var showTempoPicker = false
    @GestureState private var minusState = false
    @GestureState private var plusState = false
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button {} label: { Label("", systemImage: "minus.circle") }
                    .tempoButton(
                        tapGesture: AnyGesture(TapGesture().onEnded { bpm = bpm - 1 }),
                        longPressGesture: longPressGestureForState($minusState, handler: decrementIfNecessaryByAmount)
                    )
                
                Spacer(minLength: 4)
                VStack {
                    Text(bpm.formatted())
                        .frame(maxWidth: .infinity)
                        .lineLimit(1)
                        .padding(.vertical, 16)
                        .font(.title)
                        .fontWeight(.medium)
                }
                .frame(maxHeight: .infinity)
                .background(UIColor.tertiarySystemBackground.color)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(UIColor.separator.color, lineWidth: 2)
                )
                .onTapGesture {
                    showTempoPicker = true
                }
                
                Spacer(minLength: 4)
                
                Button {} label: { Label("", systemImage: "plus.circle") }
                    .tempoButton(
                        tapGesture: AnyGesture(TapGesture().onEnded { bpm = bpm + 1 }),
                        longPressGesture: longPressGestureForState($plusState, handler: incrementIfNecessaryByAmount)
                    )
            }
        }
        .sheet(isPresented: $showTempoPicker, onDismiss: { showTempoPicker = false }) {
            TempoEntryView(tempo: $bpm)
        }
    }
    
    private func longPressGestureForState(
        _ state: GestureState<Bool>,
        handler: @escaping (_:Int)->()
    ) -> AnyGesture<Bool> {
        AnyGesture(
            LongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity)
                .updating(state, body: { current, gesture, _ in
                    gesture = current
                })
                .onChanged { _ in
                    handler(amount)
                    
                    timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                        handler(amount)
                    }
                    
                    speedUpTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                        amount = 10
                    }
                }
                .onEnded { _ in
                    stopChangingTempo()
                }
            
        )
    }
    
    private func decrementIfNecessaryByAmount(_ amount: Int) {
        if minusState {
            bpm -= amount
        } else {
            stopChangingTempo()
        }
    }
    
    private func incrementIfNecessaryByAmount(_ amount: Int) {
        if plusState {
            bpm += amount
        } else {
            stopChangingTempo()
        }
    }
    
    private func stopChangingTempo() {
        speedUpTimer?.invalidate()
        speedUpTimer = nil
        timer?.invalidate()
        timer = nil
        amount = 1
    }
}

#Preview("Light Mode") {
    BPMView(bpm: Binding.constant(100))
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    BPMView(bpm: Binding.constant(100))
        .preferredColorScheme(.dark)
}

extension UIColor {
    var color: Color {
        Color(self)
    }
}
