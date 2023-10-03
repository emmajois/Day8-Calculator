//
//  CalculatorView.swift
//  HW4 Calculator
//
//  Created by Stephen Liddle on 9/22/23.
//

import SwiftUI

struct CalculatorView: View {
    private struct Constants {
        static let buttonSpacing = 16.0
        static let displayFontSize = 90.0
    }

    let gridItems = Array<GridItem>(repeating: .init(.flexible()), count: 4)

    @Bindable var calculator: CalculatorEngine

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                VStack {
                    accumulatorBody
                    buttonGrid(for: geometry)
                }
                .padding([.horizontal, .bottom])
            }
        }
        .background(.black)
    }
    
    private var accumulatorBody: some View {
        GeometryReader { geometry in
            VStack(alignment: .trailing, spacing: Constants.buttonSpacing) {
                Toggle(isOn: $calculator.playSound, label: {
                    Text("Use sound Effects")
                        .foregroundStyle(.white)
                })
                Spacer()
                Text(calculator.displayText)
                    .font(systemFont(
                        for: calculator.displayText,
                        thatFits: geometry.size.width - Constants.buttonSpacing * 2,
                        desiredSize: Constants.displayFontSize))
                    .foregroundStyle(.white)
                    .padding(.trailing, Constants.buttonSpacing * 2)
            }
        }
    }
        
    private func buttonGrid(for geometry: GeometryProxy) -> some View {
        LazyVGrid(columns: gridItems, alignment: .leading, spacing: Constants.buttonSpacing) {
            ForEach(buttonSpecs, id: \.symbol) { buttonSpec in
                if buttonSpec.symbol.rawValue.isEmpty {
                    Text("")
                } else {
                    CalculatorButton(buttonSpec: buttonSpec, size: geometry.size, calculator: calculator)
                }
            }
        }
    }
}

#Preview {
    CalculatorView(calculator: CalculatorEngine())
}
