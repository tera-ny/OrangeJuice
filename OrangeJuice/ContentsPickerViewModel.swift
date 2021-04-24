//
//  ContentsPickerViewModel.swift
//  OrangeJuice
//
//  Created by Haruta Yamada on 2021/04/23.
//

import Foundation
import AVFoundation
import Combine
import FirebaseAuth

class ContentsPickerViewModel: NSObject, ObservableObject {
    var player: AVAudioPlayer? = .init()
    let audioSession: AVAudioSession = .sharedInstance()
    override init() {
        try? audioSession.setCategory(.playback)
    }
    @Published var currentURL: URL? = nil
    func isPlaying(url: URL) -> Bool {
        currentURL == url && player?.isPlaying ?? false
    }
    func play(url: URL) {
        defer {
            player?.prepareToPlay()
            player?.play()
            self.objectWillChange.send()
        }
        guard currentURL != url else { return }
        player?.stop()
        player = try? .init(contentsOf: url)
        player?.delegate = self
        currentURL = url
    }
    func pause() {
        player?.pause()
        self.objectWillChange.send()
    }
    func stop() {
        player?.stop()
        player = nil
        currentURL = nil
    }
}

extension ContentsPickerViewModel: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        stop()
    }
}
