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
        HStack {
            Button {} label: {
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
                longPressGestureForState($minusState, handler: decrementIfNecessaryByAmount)
            )
            
            Spacer(minLength: 4)
            
            Text(bpm.formatted())
                .frame(maxWidth: .infinity)
                .lineLimit(1)
                .padding(.vertical, 16)
                .onTapGesture {
                    showTempoPicker = true
                }
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
                longPressGestureForState($plusState, handler: incrementIfNecessaryByAmount)
            )
        }
        .sheet(isPresented: $showTempoPicker, onDismiss: { showTempoPicker = false }) {
            TempoEntryView(tempo: $bpm)
        }
    }
    
    private func longPressGestureForState(_ state: GestureState<Bool>, handler: @escaping (_:Int)->()) -> some Gesture {
        LongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity)
            .updating(state, body: { current, gesture, _ in
                gesture = current
            })
            .onChanged({ _ in
                handler(amount)
                
                timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                    handler(amount)
                }
                
                speedUpTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                    amount = 10
                }
            })
            .onEnded({ _ in
                stopChangingTempo()
            })
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

#Preview {
    BPMView(bpm: Binding.constant(100))
}
