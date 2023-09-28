//
//  SoundPlayer.swift
//  HW6 Calculator
//
//  Created by Stephen Liddle on 9/26/23.
//

import Foundation
import AVFoundation

struct SoundPlayer {
    var player: AVAudioPlayer?

    mutating func playSound(named soundName: String) async {
        guard let path = Bundle.main.path(forResource: soundName, ofType: nil) else {
            // If path not found, just don't try to play it
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: URL(filePath: path))
            player?.play()
        } catch {
            // Ignore -- just don't try to play the sound
        }
    }
}
