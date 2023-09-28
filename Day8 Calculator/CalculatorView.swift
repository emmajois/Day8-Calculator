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

    @Bindable var calculatorViewModel: CalculatorViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(.black)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .trailing, spacing: Constants.buttonSpacing) {
                    Toggle(isOn: $calculatorViewModel.playSound, label: {
                        Text("Annoy the user")
                            .foregroundStyle(.white)
                    })
                    Spacer()
                    Text("1,000")
                        .font(.system(size: Constants.displayFontSize, weight: .light))
                        .foregroundStyle(.white)
                        .padding(.trailing, Constants.buttonSpacing * 2)
                    LazyVGrid(columns: gridItems, alignment: .leading, spacing: Constants.buttonSpacing) {
                        ForEach(buttonSpecs, id: \.symbol) { buttonSpec in
                            if buttonSpec.symbol.rawValue.isEmpty {
                                Text("")
                            } else {
                                CalculatorButton(buttonSpec: buttonSpec, size: geometry.size, calculatorViewModel: calculatorViewModel)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    CalculatorView(calculatorViewModel: CalculatorViewModel())
}
