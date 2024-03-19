import SwiftUI

struct ContentView: View {
    @State private var displayText = ""
    let buttons: [[CalculatorButton]] = [
        [.digit(7), .digit(8), .digit(9), .op(.divide)],
        [.digit(4), .digit(5), .digit(6), .op(.multiply)],
        [.digit(1), .digit(2), .digit(3), .op(.subtract)],
        [.digit(0), .dot, .op(.add), .equals]
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Spacer()
                Text(displayText)
                    .font(.system(size: 64))
            }
            .padding()
            
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { button in
                        CalculatorButtonView(button: button, displayText: $displayText)
                    }
                }
            }
        }
        .padding()
    }
}

struct CalculatorButtonView: View {
    let button: CalculatorButton
    @Binding var displayText: String
    
    var body: some View {
        Button(action: {
            self.handleButtonTapped()
        }) {
            Text(button.title)
                .font(.system(size: 32))
                .frame(width: self.buttonWidth(button: button), height: self.buttonHeight(button: button))
                .foregroundColor(.white)
                .background(button.backgroundColor)
                .cornerRadius(self.buttonWidth(button: button))
        }
    }
    
    private func handleButtonTapped() {
        switch button {
        case .digit(let value):
            if displayText.count < 9 {
                displayText += "\(value)"
            }
        case .dot:
            if !displayText.contains(".") {
                displayText += "."
            }
        case .op(let op):
            switch op {
            case .add, .subtract, .multiply, .divide:
                if !displayText.isEmpty && !displayText.hasSuffix("+") && !displayText.hasSuffix("-") && !displayText.hasSuffix("*") && !displayText.hasSuffix("/") {
                    displayText += op.rawValue
                }
            }
        case .equals:
            if let result = evaluateExpression(expression: displayText) {
                displayText = result
            }
        }
    }
    
    private func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .digit(0) {
            return ((UIScreen.main.bounds.width - 5 * 12) / 4) * 2 + 12
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    private func buttonHeight(button: CalculatorButton) -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    private func evaluateExpression(expression: String) -> String? {
        let expressionToEvaluate = NSExpression(format: expression)
        if let result = expressionToEvaluate.expressionValue(with: nil, context: nil) as? Double {
            return "\(result)"
        }
        return nil
    }
}

enum CalculatorButton: Hashable {
    case digit(Int)
    case dot
    case op(Operation)
    case equals
    
    var title: String {
        switch self {
        case .digit(let value):
            return "\(value)"
        case .dot:
            return "."
        case .op(let op):
            return op.rawValue
        case .equals:
            return "="
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .digit, .dot, .equals:
            return Color.gray
        case .op:
            return Color.orange
        }
    }
}

enum Operation: String {
    case add = "+"
    case subtract = "-"
    case multiply = "*"
    case divide = "/"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
