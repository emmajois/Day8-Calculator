//
//  SystemFortForSize.swift
//  Day8 Calculator
//
//  Created by IS 543 on 10/2/23.
//

import SwiftUI

func systemFont(for string: String, thatFits width: Double, desiredSize: Double) -> Font {
    var fontSize = desiredSize
    var uiFont = UIFont.systemFont(ofSize: fontSize)
    
    while (string as NSString).size(withAttributes: [.font: uiFont]).width > width 
            && fontSize >= desiredSize / 3 {
        fontSize *= 0.9
        uiFont = UIFont.systemFont(ofSize: fontSize)
    }
    
    return Font.system(size: fontSize)
}
