//
//  UIStackView.swift
//  Musicall
//
//  Created by Elias Ferreira on 21/09/21.
//

import UIKit

extension UIStackView {
    func removeAllArrangedSubviews() {
        self.subviews.forEach({ $0.removeFromSuperview() })
    }
}
