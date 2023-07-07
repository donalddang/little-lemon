//
//  Extensions.swift
//  Little Lemon Final Project
//
//  Created by Donald Dang on 7/4/23.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String, alpha: Double = 1.0) {
        var hexValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&hexValue)
        
        let red = Double((hexValue & 0xFF0000) >> 16) / 255.0
        let green = Double((hexValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(hexValue & 0x0000FF) / 255.0
        
        self.init(
            .sRGB,
            red: red,
            green: green,
            blue: blue,
            opacity: alpha
        )
    }
}


