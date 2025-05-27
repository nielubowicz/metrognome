import Foundation

struct Beat: Equatable, Codable {
    var bpm: Int
    var tempo: Tempo
}

extension Beat: Identifiable {
    var id: UUID {
        UUID()
    }
}
