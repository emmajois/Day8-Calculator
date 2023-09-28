//
//  CalculatorViewModel.swift
//  HW6 Calculator
//
//  Created by Stephen Liddle on 9/26/23.
//

import Foundation

@Observable class CalculatorViewModel {

    // MARK: - Properties

    var playSound = true
    var soundPlayer = SoundPlayer()

    // MARK: - Model access

    // MARK: - User intents

    func handleButtonTap() {
        Task {
            await soundPlayer.playSound(named: "Click.mp3")
        }
    }
}
