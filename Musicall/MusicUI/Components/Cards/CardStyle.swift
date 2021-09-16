//
//  CardStyle.swift
//  Musicall
//
//  Created by Lucas Oliveira on 15/09/21.
//

import UIKit
import SnapKit

enum CardStyle: Equatable {
    case complete(content: String, likes: Int, interactions: Int)
    case simple(content: String)
    case contact(number: String)
    case editable

    private func buildContentLabel(text: String) -> UILabel {
        let contentLabel = UILabel()
        contentLabel.text = text
        contentLabel.font = .MCDesignSystem(font: .body)
        contentLabel.textColor = .lightGray
        contentLabel.numberOfLines = 0
        return contentLabel
    }

    private func buildCompleteStyle(in mainStack: UIStackView, content: String, likes: Int, interactions: Int) {
        let contentLabel = buildContentLabel(text: content)

        let stackHorizontal = UIStackView()
        stackHorizontal.axis = .horizontal
        stackHorizontal.alignment = .fill
        stackHorizontal.distribution = .fill
        stackHorizontal.spacing = 0

        let likeLabel = UILabel()
        likeLabel.font = .MCDesignSystem(font: .caption1)
        likeLabel.textColor = .white
        likeLabel.text = likes.description

        let interactionsLabel = UILabel()
        interactionsLabel.font = .MCDesignSystem(font: .caption1)
        interactionsLabel.textColor = .white

        let myMutableString = NSMutableAttributedString()
        myMutableString.append(.init(string: "\(interactions.description)",
                                     attributes: [.font: UIFont.MCDesignSystem(font: .caption1)]))
        myMutableString.append(.init(string: " Interações",
                                     attributes: [.font: UIFont.MCDesignSystem(font: .caption2)]))
        interactionsLabel.attributedText = myMutableString

        stackHorizontal.addArrangedSubview(likeLabel)
        stackHorizontal.addArrangedSubview(UIView())
        stackHorizontal.addArrangedSubview(interactionsLabel)

        mainStack.addArrangedSubview(contentLabel)
        mainStack.addArrangedSubview(stackHorizontal)
    }

    private func buildSimpleStyle(in mainStack: UIStackView, content: String) {
        let contentLabel = buildContentLabel(text: content)

        mainStack.addArrangedSubview(contentLabel)
    }

    private func buildContactStyle(in mainStack: UIStackView, content: String) {
        let contentView = UIView()
        contentView.backgroundColor = .darkGray
        contentView.layer.cornerRadius = 4
        contentView.translatesAutoresizingMaskIntoConstraints = false

        contentView.snp.makeConstraints { make in
            make.height.equalTo(38)
        }

        let iconView = UIImageView()
        iconView.backgroundColor = .blue
        iconView.snp.makeConstraints { make in
            make.height.width.equalTo(18)
        }

        let phoneLabel = buildContentLabel(text: content)

        let stackHorizontal = UIStackView()
        stackHorizontal.axis = .horizontal
        stackHorizontal.alignment = .fill
        stackHorizontal.distribution = .fill
        stackHorizontal.spacing = 12

        stackHorizontal.addArrangedSubview(iconView)
        stackHorizontal.addArrangedSubview(phoneLabel)

        contentView.addSubview(stackHorizontal)
        stackHorizontal.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(12)
        }

        mainStack.addArrangedSubview(contentView)
    }

    private func buildEditableStyle(in mainStack: UIStackView) {
        let contentLabel = buildContentLabel(text: "Escreva seu comentário...")
        contentLabel.textColor = .gray

        mainStack.addArrangedSubview(contentLabel)
    }

    func configureStyleView() -> UIStackView {
        let stackVertical = UIStackView()
        stackVertical.axis = .vertical
        stackVertical.alignment = .fill
        stackVertical.distribution = .fill
        stackVertical.spacing = 16

        switch self {
        case .complete(content: let content, likes: let likes, interactions: let interactions):
            buildCompleteStyle(in: stackVertical, content: content, likes: likes, interactions: interactions)

        case .simple(content: let content):
            buildSimpleStyle(in: stackVertical, content: content)

        case .contact(number: let number):
            buildContactStyle(in: stackVertical, content: number)

        case .editable: break
        }

        return stackVertical
    }
}
