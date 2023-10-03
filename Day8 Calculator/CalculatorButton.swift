//
//  CalculatorButton.swift
//  HW4 Calculator
//
//  Created by Stephen Liddle on 9/22/23.
//

import SwiftUI

struct CalculatorButton: View {
    private struct Constants {
        static let buttonSpacing = 16.0
        static let fontScaleFactor = 0.1
        static let radiusFactor = 8.0
        static let scaleFactor = 0.8
    }

    let buttonSpec: ButtonSpec
    let size: CGSize
    let calculator: CalculatorEngine

    var body: some View {
        Button {
            calculator.handleButtonTap(for: buttonSpec)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                    .frame(
                        width: buttonSize(for: size, spanWidth: buttonSpec.type.spanWidth),
                        height: buttonSize(for: size, spanWidth: 1)
                    )
                Text(symbolString)
                    .foregroundStyle(foregroundColor)
                    .font(displayFont)
            }
        }
    }
    
    private var backgroundColor: Color {
        buttonSpec.symbol == calculator.activeSymbol
            ? buttonSpec.type.foregroundColor
            : buttonSpec.type.backgroundColor
    }

    private func buttonSize(for size: CGSize, spanWidth: Int) -> CGFloat {
        if spanWidth > 1 {
            return (minimumSize / 2 + Constants.buttonSpacing * 1.5) * Constants.scaleFactor
        }

        return minimumSize / 4 * Constants.scaleFactor
    }

    private var cornerRadius: CGFloat {
        minimumSize / Constants.radiusFactor * Constants.scaleFactor
    }

    private var displayFont: Font {
        .system(size: minimumSize * Constants.fontScaleFactor, weight: .light)
    }
    
    private var foregroundColor: Color {
        buttonSpec.symbol == calculator.activeSymbol
            ? buttonSpec.type.backgroundColor
            : buttonSpec.type.foregroundColor
    }

    private var minimumSize: CGFloat {
        min(size.height, size.width)
    }
    
    private var symbolString: String {
        if buttonSpec.symbol == .clear{
            calculator.clearSymbol
        } else {
            buttonSpec.symbol.rawValue
        }
    }
}

#Preview {
    HStack {
        CalculatorButton(
            buttonSpec: ButtonSpec(symbol: .allClear, type: .utility),
            size: CGSize(width: 400, height: 400),
            calculator: CalculatorEngine()
        )
        CalculatorButton(
            buttonSpec: ButtonSpec(symbol: .add, type: .compute),
            size: CGSize(width: 400, height: 400),
            calculator: CalculatorEngine()
        )
        CalculatorButton(
            buttonSpec: ButtonSpec(symbol: .zero, type: .doubleWide),
            size: CGSize(width: 400, height: 400),
            calculator: CalculatorEngine()
        )
    }
}
