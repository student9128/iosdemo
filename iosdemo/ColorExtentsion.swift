//
//  ColorExtentsion.swift
//  iosdemo
//
//  Created by Kevin Jing on 2023/4/24.
//

import Foundation
import SwiftUI
extension Color {
    static func random() -> Color {
        return Color(red: Double.random(in: 0...1),
                     green: Double.random(in: 0...1),
                     blue: Double.random(in: 0...1))
    }
}
