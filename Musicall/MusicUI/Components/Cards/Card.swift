//
//  Card.swift
//  Musicall
//
//  Created by Lucas Oliveira on 14/09/21.
//

import UIKit
enum CardStyle {
    case complete(content: String, likes: Int, interactions: Int)
    case simple(content: String)
    case contact(number: String)
    case editable

    fileprivate func configureStyle(style: CardStyle) -> UIView {
        let stackVertical = UIStackView()
        stackVertical.axis = .vertical
        stackVertical.alignment = .fill
        stackVertical.distribution = .fill
        stackVertical.spacing = 16

        switch style {
        case .complete(content: let content, likes: let likes, interactions: let interactions):
            let contentLabel = UILabel()
            contentLabel.text = content
            contentLabel.numberOfLines = 0

            let stackHorizontal = UIStackView()
            stackHorizontal.axis = .horizontal
            stackHorizontal.alignment = .fill
            stackHorizontal.distribution = .fill
            stackHorizontal.spacing = 0

            let likeLabel = UILabel()
            likeLabel.text = likes.description

            let interactionsLabel = UILabel()
            interactionsLabel.text = interactions.description

            stackHorizontal.addArrangedSubview(likeLabel)
            stackHorizontal.addArrangedSubview(UIView())
            stackHorizontal.addArrangedSubview(interactionsLabel)

            stackVertical.addArrangedSubview(contentLabel)
            stackVertical.addArrangedSubview(stackHorizontal)

        case .simple(content: let content):
            let contentLabel = UILabel()
            contentLabel.text = content
            contentLabel.numberOfLines = 0

            stackVertical.addArrangedSubview(contentLabel)

        case .contact(number: let number): break

        case .editable: break
            
        }
        return stackVertical
    }
}

struct HeaderInfos {
    let username: String
    let date: String
}

class Card: UIView {

    // MARK: PUBLIC PROPERTIES
    var isHighlighted = false

    // MARK: PRIVATE PROPERTIES
    private var style: CardStyle
    private var headerInfos: HeaderInfos

    // MARK: UI Elements


    // MARK: LIFE CYCLE
    init(headerInfos: HeaderInfos, style: CardStyle) {
        self.style = style
        self.headerInfos = headerInfos
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: PRIVATE FUNCS

    // MARK: PUBLIC FUNCS

}
