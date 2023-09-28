//
//  Day8_CalculatorApp.swift
//  Day8 Calculator
//
//  Created by Stephen Liddle on 9/27/23.
//

import SwiftUI

@main
struct Day8_CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorView(calculatorViewModel: CalculatorViewModel())
        }
    }
}
