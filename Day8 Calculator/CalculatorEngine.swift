//
//  CalculatorViewModel.swift
//  HW6 Calculator
//
//  Created by Stephen Liddle on 9/26/23.
//

import Foundation

@Observable class CalculatorEngine {
    //MARK: - Constants
    
    private struct Constants {
        static let defaultDisplayText = "0"
        static let errorDisplay = "Error"
    }

    // MARK: - Properties

    var calculator = CalculatorBrain()
    var playSound = true
    private var soundPlayer = SoundPlayer()
    private var textBeingEdited: String?

    // MARK: - Model access
    
    var displayText: String{
        if let text = textBeingEdited{
            text
            // NEEDSWORK : more to do here
        } else {
            Constants.errorDisplay
        }
    }

    // MARK: - User intents

    func handleButtonTap(for buttonSpec: ButtonSpec) {
        if playSound{
            Task {
                await soundPlayer.playSound(named: "Click.mp3")
            }
        }
        switch buttonSpec.type {
        case .compute:
            handleOperationTap(symbol: buttonSpec.symbol)
        case .utility:
            if buttonSpec.symbol == .clear {
                handleClearTap()
            } else {
                handleOperationTap(symbol: buttonSpec.symbol)
            }
        case .number, .doubleWide:
            handleNumericTap(digit: buttonSpec.symbol.rawValue)
        }
    }
    
    //MARK: - Private Helpers
    
    private func handleClearTap() {
        
    }
    
    private func handleNumericTap(digit: String){
        if let text = textBeingEdited {
            textBeingEdited = text + digit
        }
    }
    
    private func handleOperationTap(symbol: OperationSymbol){
        
    }
}
