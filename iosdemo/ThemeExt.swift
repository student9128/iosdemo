//
//  ThemeExt.swift
//  iosdemo
//
//  Created by Kevin Jing on 3/21/25.
//

import UIKit

extension UIColor {
    /// 通过 16 进制颜色值创建 `UIColor`
    /// - Parameters:
    ///   - hex: 16 进制颜色值 (支持 `#RRGGBB` 和 `#RRGGBBAA`)
    ///   - alpha: 透明度 (可选，默认 1.0)
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()

        // 去掉 #
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        switch hexSanitized.count {
        case 6:  // #RRGGBB
            self.init(
                red: CGFloat((rgb >> 16) & 0xFF) / 255.0,
                green: CGFloat((rgb >> 8) & 0xFF) / 255.0,
                blue: CGFloat(rgb & 0xFF) / 255.0,
                alpha: alpha
            )
        case 8:  // #RRGGBBAA
            self.init(
                red: CGFloat((rgb >> 24) & 0xFF) / 255.0,
                green: CGFloat((rgb >> 16) & 0xFF) / 255.0,
                blue: CGFloat((rgb >> 8) & 0xFF) / 255.0,
                alpha: CGFloat(rgb & 0xFF) / 255.0
            )
        default:
            self.init(red: 1, green: 1, blue: 1, alpha: 1)  // 默认白色，防止解析错误
        }
    }

}
