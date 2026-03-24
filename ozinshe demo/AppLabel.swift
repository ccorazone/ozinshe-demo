//
//  AppLabel.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 18.12.2025.
//

import UIKit

extension UILabel {
    static func createLabel(text: String = "" ,font: UIFont, color: UIColor, textAlignment: NSTextAlignment = .left, numberOfLines: Int = 0) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = numberOfLines
        label.font = font
        label.textAlignment = textAlignment
        label.textColor = color
        return label
    }
}
