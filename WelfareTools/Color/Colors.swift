//
//  Colors.swift
//  FunctionalIndependenceMeasure
//
//  Created by 村中令 on 2022/01/05.
//

import UIKit

enum Colors {
    static let baseColor = UIColor(hex: "F6F5F5")
    static let mainColor = UIColor(hex: "459acc")
    static let complementaryColor = UIColor(hex: "d89987")

    static let lightbule = UIColor(hex: "56C1FF")
    static let darkbule = UIColor(hex: "0076BA")
}

// hex値　を　rgb値　に変換するメソッド
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let conversion = Int("000000" + hex, radix: 16) ?? 0
        let red = CGFloat(conversion / Int(powf(256, 2)) % 256) / 255
        let green = CGFloat(conversion / Int(powf(256, 1)) % 256) / 255
        let blue = CGFloat(conversion / Int(powf(256, 0)) % 256) / 255
        self.init(red: red, green: green, blue: blue, alpha: min(max(alpha, 0), 1))
    }
}
