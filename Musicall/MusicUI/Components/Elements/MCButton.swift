//
//  MCButton.swift
//  Musicall
//
//  Created by Elias Ferreira on 17/09/21.
//

import UIKit

// MARK: Styleable Protocol
protocol Styleable {
    associatedtype Styles: RawRepresentable

    func applyStyle(_ style: Styles)
}

extension MCButton: Styleable {
    typealias Styles = ButtonStyle

    enum ButtonStyle: Int {
        case primary
        case ghost
    }

    enum Size {
        case medium
        case large

        func getSize() -> CGSize {
            switch self {
            case .medium:
                return CGSize(width: 38, height: 38)
            case .large:
                return CGSize(width: 40, height: 40)
            }
        }
    }

    func applyStyle(_ style: ButtonStyle) {
        switch style {
        case .ghost:
            backgroundColor = .clear
            layer.cornerRadius = 5.5
        case .primary:
            backgroundColor = .blue
            layer.cornerRadius = 5.5
        }
    }
}

class MCButton: UIButton {
    let size: Size
    let style: MCButton.ButtonStyle

    init(style: MCButton.ButtonStyle, size: Size) {
        self.style = style
        self.size = size
        super.init(frame: CGRect())
        contentMode = .center
        configureSize(size)
        applyStyle(style)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureSize(_ size: Size) {
        snp.makeConstraints { make in
            make.height.equalTo(size.getSize().height)
            make.width.equalTo(size.getSize().width)
        }
    }
}
