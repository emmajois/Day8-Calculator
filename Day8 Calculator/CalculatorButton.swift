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
    let calculatorViewModel: CalculatorViewModel

    var body: some View {
        Button {
            calculatorViewModel.handleButtonTap()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(buttonSpec.type.backgroundColor)
                    .frame(
                        width: buttonSize(for: size, spanWidth: buttonSpec.type.spanWidth),
                        height: buttonSize(for: size, spanWidth: 1)
                    )
                Text(buttonSpec.symbol.rawValue)
                    .foregroundStyle(buttonSpec.type.foregroundColor)
                    .font(displayFont)
            }
        }
    }

    func buttonSize(for size: CGSize, spanWidth: Int) -> CGFloat {
        if spanWidth > 1 {
            return (minimumSize / 2 + Constants.buttonSpacing * 1.5) * Constants.scaleFactor
        }

        return minimumSize / 4 * Constants.scaleFactor
    }

    var cornerRadius: CGFloat {
        minimumSize / Constants.radiusFactor * Constants.scaleFactor
    }

    var displayFont: Font {
        .system(size: minimumSize * Constants.fontScaleFactor, weight: .light)
    }

    var minimumSize: CGFloat {
        min(size.height, size.width)
    }
}

#Preview {
    HStack {
        CalculatorButton(
            buttonSpec: ButtonSpec(symbol: .allClear, type: .utility),
            size: CGSize(width: 400, height: 400),
            calculatorViewModel: CalculatorViewModel()
        )
        CalculatorButton(
            buttonSpec: ButtonSpec(symbol: .add, type: .compute),
            size: CGSize(width: 400, height: 400),
            calculatorViewModel: CalculatorViewModel()
        )
        CalculatorButton(
            buttonSpec: ButtonSpec(symbol: .zero, type: .doubleWide),
            size: CGSize(width: 400, height: 400),
            calculatorViewModel: CalculatorViewModel()
        )
    }
}
