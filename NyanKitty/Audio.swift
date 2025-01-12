import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    private var backgroundMusicPlayer: AVAudioPlayer?
    private var effectPlayer: AVAudioPlayer?
    
    func playBackgroundMusic(named fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "m4a") else { return }
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer?.numberOfLoops = -1 // Loop indefinitely
            backgroundMusicPlayer?.play()
        } catch {
            print("Error playing background music: \(error.localizedDescription)")
        }
    }
    
    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
    }
    
    func playEffect(named fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "m4a") else { return }
        do {
            effectPlayer = try AVAudioPlayer(contentsOf: url)
            effectPlayer?.play()
        } catch {
            print("Error playing effect: \(error.localizedDescription)")
        }
    }
}
