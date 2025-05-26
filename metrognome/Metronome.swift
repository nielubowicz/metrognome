import AVKit

class Metronome: ObservableObject {
    var beat: Beat
    @Published private(set) var isPlaying: Bool = false
    @Published var beatCount = 0
        
    private var audioPlayer: AVPlayer
    
    init(beat: Beat) {
        self.beat = beat
        audioPlayer = AVPlayer()
        
        do {
            // Set up AVAudioSession
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(routeChange(_:)),
            name: AVAudioSession.routeChangeNotification,
            object: nil
        )
    }
        
    private var tickTimer: Timer?
    
    @objc
    private func routeChange(_ notification: Notification) {
        guard isPlaying == false else { return }
        pause()
        play()
    }
    
    func play() {
        isPlaying = true
        let timer = Timer(
            timeInterval: 60.0 / Double(beat.bpm),
            repeats: true
        ) { _ in
            self.beatCount = (self.beatCount % self.beat.tempo.numerator) + 1
            let sound = self.beatCount == 1 ? self.tockPlayerItem : self.tickPlayerItem
            self.audioPlayer.replaceCurrentItem(with: sound)
            self.audioPlayer.play()
        }
        self.tickTimer = timer
        RunLoop.current.add(timer, forMode: .common)
    }
    
    func pause() {
        tickTimer?.invalidate()
        tickTimer = nil
        isPlaying = false
        beatCount = 0
    }
    
    private var tickPlayerItem: AVPlayerItem {
        AVPlayerItem(url: tickURL)
    }
    
    private var tickURL: URL {
        Bundle.main.url(forResource: "tick", withExtension: "aiff")!
    }
    
    private var tockPlayerItem: AVPlayerItem {
        AVPlayerItem(url: tockURL)
    }
    
    private var tockURL: URL {
        Bundle.main.url(forResource: "tock", withExtension: "aiff")!
    }
}
