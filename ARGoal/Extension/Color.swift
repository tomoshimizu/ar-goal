//
//  UIColor.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/10.
//

import Foundation
import SwiftUI

extension Color {
    
    /// hex: 6 charactors
    /// e.g. hex: "FFFFFF"
    init(hex: String) {
        guard hex.count == 6 else { fatalError("hex should be 6 charactors") }
        let hex = hex.map { String($0) }
        let red = CGFloat(Int(hex[0] + hex[1], radix: 16) ?? 0) / 255.0
        let green = CGFloat(Int(hex[2] + hex[3], radix: 16) ?? 0) / 255.0
        let blue = CGFloat(Int(hex[4] + hex[5], radix: 16) ?? 0) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}
