import SwiftUI

struct BPMView: View {
    @Binding var bpm: Int
    @State private var timer: Timer?
    
    var body: some View {
        HStack {
            Button("", systemImage: "minus.circle") {
                bpm = bpm - 1
            }
            .padding(24)
            .gesture(
                LongPressGesture(minimumDuration: 0.1)
                    .onChanged { _ in
                        startDecreasingTempo()
                    }
                    .onEnded { _ in
                        stopChangingTempo()
                    }
            )
            Spacer(minLength: 4)
            Text(bpm.formatted())
            Spacer(minLength: 4)
            Button("", systemImage: "plus.circle") {
                bpm = bpm + 1
            }
            .padding(24)
            .gesture(
                LongPressGesture(minimumDuration: 0.1)
                    .onChanged { _ in
                        startIncreasingTempo()
                    }
                    .onEnded { _ in
                        stopChangingTempo()
                    }
            )
        }
    }
    
    private func startIncreasingTempo() {
        stopChangingTempo()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            bpm += 1
        }
    }
    
    private func startDecreasingTempo() {
        stopChangingTempo()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            bpm -= 1
        }
    }
    
    private func stopChangingTempo() {
        timer?.invalidate()
        timer = nil
    }
}
