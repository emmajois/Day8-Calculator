//
//  CalculatorBrain.swift
//  Day8 Calculator
//
//  Created by Stephen Liddle on 9/28/23.
//

import Foundation

struct CalculatorBrain {

    // MARK: - Nested types

    private enum Operation {
        case binary((Double, Double) -> Double)
        case unary((Double) -> Double)
        case calculate
    }

    private struct PendingBinaryOperation {
        let calculate: (Double, Double) -> Double
        let leftOperand: Double
        let symbol: OperationSymbol

        func perform(with rightOperand: Double) -> Double {
            calculate(leftOperand, rightOperand)
        }
    }

    // MARK: - Constants

    private var operations: [OperationSymbol : Operation] = [
        .divide:     .binary({ $0 / $1 }),
        .multiply:   .binary({ $0 * $1 }),
        .subtract:   .binary({ $0 - $1 }),
        .add:        .binary({ $0 + $1 }),
        .changeSign: .unary({ -$0 }),
        .percent:    .unary({ $0 / 100 }),
        .calculate:  .calculate
    ]

    // MARK: - Properties

    var accumulator: Double? = 0
    private var pendingOperation: PendingBinaryOperation?

    // MARK: - Helpers

    mutating func clearAccumulator() {
        accumulator = nil
    }

    mutating func clearAll() {
        pendingOperation = nil
        clearAccumulator()
    }

    mutating func performOperation(symbol: OperationSymbol) {
        guard let operation = operations[symbol] else {
            // Ignore attempt to perform unknown operation
            return
        }

        switch operation {
            case .binary(let function):
                break
            case .unary(let function):
                break
            case .calculate:
                performPendingOperation()
        }
    }

    // MARK: - Private helpers

    private mutating func performPendingOperation() {
        if let pendingOperation, let accumulator {
            self.accumulator = pendingOperation.perform(with: accumulator)
            self.pendingOperation = nil
        }
    }
}
