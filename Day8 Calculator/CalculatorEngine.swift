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
        static let decimal = OperationSymbol.decimal.rawValue
        static let defaultDisplayText = OperationSymbol.zero.rawValue
        static let errorDisplay = "Error"
        static let maximumFractionDigits = 8
    }

    // MARK: - Properties

    var calculator = CalculatorBrain()
    var playSound = true
    
    private var decimalFormatter = NumberFormatter()
    private var soundPlayer = SoundPlayer()
    private var textBeingEdited: String? = Constants.defaultDisplayText
    
    // MARK: - Initialization
    init () {
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.maximumFractionDigits = Constants.maximumFractionDigits
    }
    // MARK: - Model access
    
    var displayText: String {
        if let text = textBeingEdited {
            text
        } else if let value = calculator.accumulator {
            formatted(number:value)
        } else if let value = calculator.pendingLeftOperand {
            formatted(number:value)
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
    
    private func formatted(number: Double) -> String {
        decimalFormatter.string(from: NSNumber(value: number)) ?? Constants.errorDisplay
    }
    private func handleClearTap() {
        
    }
    
    private func handleNumericTap(digit: String){
        if let text = textBeingEdited {
            if digit == Constants.decimal && text.contains(digit){
                //Ignore extra tap on decimal button
                return
            }
            
            if digit != Constants.decimal && text == Constants.defaultDisplayText {
                textBeingEdited = digit
            } else {
                textBeingEdited = text + digit
            }
        } else {
                textBeingEdited = digit
        }
        
        if let updatedText = textBeingEdited {
            if updatedText.hasPrefix(Constants.decimal) {
                textBeingEdited = Constants.defaultDisplayText + updatedText
            }
            calculator.setAccumulator(Double(updatedText))
        }
        
    }
    
    private func handleOperationTap(symbol: OperationSymbol){
        if calculator.accumulator != nil {
            calculator.performOperation(symbol: symbol)
            textBeingEdited = nil
        }
    }
}
