import SwiftUI

struct BPMView: View {
    @Binding var bpm: Int
    @State private var timer: Timer?
    @GestureState private var minusState = false
    @GestureState private var plusState = false
    
    var body: some View {
        HStack {
            Button {}
            label: {
                Label("", systemImage: "minus.circle")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.title)
            }
            .contentShape(Rectangle())
            .padding(.horizontal)
            .highPriorityGesture(
                TapGesture().onEnded({
                    bpm = bpm - 1
                })
            )
            .simultaneousGesture(
                LongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity)
                    .updating($minusState, body: { current, gesture, _ in
                        gesture = current
                    })
                    .onChanged({ pressed in
                        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                            checkMinusState()
                        }
                    })
                    .onEnded({ pressed in
                        stopChangingTempo()
                    })
            )
            
            Spacer(minLength: 4)
            Text(bpm.formatted())
                .font(.title)
                .fontWeight(.medium)
            Spacer(minLength: 4)
            
            Button {} label: {
                Label("", systemImage: "plus.circle")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.title)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .padding(.horizontal)
            .highPriorityGesture(
                TapGesture().onEnded({
                    bpm = bpm + 1
                })
            )
            .simultaneousGesture(
                LongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity)
                    .updating($plusState, body: { current, gesture, _ in
                        gesture = current
                    })
                    .onChanged({ pressed in
                        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                            checkPlusState()
                        }
                    })
                    .onEnded({ pressed in
                        stopChangingTempo()
                    })
            )
        }
    }
    
    private func checkMinusState() {
        if minusState {
            bpm -= 1
        } else {
            stopChangingTempo()
        }
    }
    
    private func checkPlusState() {
        if plusState {
            bpm += 1
        } else {
            stopChangingTempo()
        }
    }
    
    private func stopChangingTempo() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    BPMView(bpm: Binding.constant(100))
}
