//
//  UIFont.swift
//  Musicall
//
//  Created by Lucas Fernandes on 14/09/21.
//

import UIKit

// MC = Musicall
extension UIFont {
    private enum FontName: String {
        // Font: OpenSans
        case openSansRegular = "OpenSans-Regular"
        case openSansSemiBold = "OpenSans-SemiBold"
        case openSansBold = "OpenSans-Bold"

        // Font: Overlock
        case overLockBold = "Overlock-Bold"

    }

    enum Style {
        case heading1
        case title1
        case subtitle
        case subtitle1
        case subtitle2
        case body
        case body2
        case caption1
        case caption2
    }

    static func MCDesignSystem(font: Style) -> UIFont {
        switch font {
        case .heading1:
            return UIFont(name: FontName.overLockBold.rawValue, size: 32)!
        case .title1:
            return UIFont(name: FontName.overLockBold.rawValue, size: 20)!
        case .subtitle:
            return UIFont(name: FontName.openSansRegular.rawValue, size: 18)!
        case .subtitle1:
            return UIFont(name: FontName.overLockBold.rawValue, size: 16)!
        case .subtitle2:
            return UIFont(name: FontName.openSansSemiBold.rawValue, size: 14)!
        case .body:
            return UIFont(name: FontName.openSansRegular.rawValue, size: 14)!
        case .body2:
            return UIFont(name: FontName.openSansRegular.rawValue, size: 20)!
        case .caption1:
            return UIFont(name: FontName.openSansBold.rawValue, size: 12)!
        case .caption2:
            return UIFont(name: FontName.openSansSemiBold.rawValue, size: 12)!
      }
   }
}
