//
//  Card.swift
//  Musicall
//
//  Created by Lucas Oliveira on 14/09/21.
//

import UIKit
import SnapKit

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
    private var contentView: UIView
    
    // MARK: UI Elements

    let photoImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        image.layer.cornerRadius = 10
        return image
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = headerInfos.username
        label.font = .MCDesignSystem(font: .subtitle1)
        label.textColor = .white

        return label
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = headerInfos.date
        label.font = .MCDesignSystem(font: .body)
        label.textColor = .gray

        return label
    }()

    lazy var editableLabel: UITextField = {
        let label = UITextField()
        label.attributedPlaceholder = NSAttributedString(string: "Escreva seu comentário...",
                                                         attributes: [.font: UIFont.MCDesignSystem(font: .body),
                                                                      .foregroundColor: UIColor.lightGray])
        label.font = .MCDesignSystem(font: .body)
        label.keyboardType = .default

        return label
    }()

    let stackVertical: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 0

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let stackHorizontal: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 12

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: LIFE CYCLE
    init(headerInfos: HeaderInfos, style: CardStyle) {
        self.style = style
        self.headerInfos = headerInfos
        self.contentView = style.configureStyleView()
        super.init(frame: .zero)
        editableConfiguration()
        backgroundColor = .darkestGray
        layer.cornerRadius = 10

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: PRIVATE FUNCS

    private func editableConfiguration() {
        guard let stack = contentView as? UIStackView,
              style == .editable else {
            return
        }
        stack.addArrangedSubview(editableLabel)
    }

    private func configureUI() {
        addSubview(stackHorizontal)

        stackHorizontal.addArrangedSubview(photoImageView)
        stackHorizontal.addArrangedSubview(stackVertical)

        stackVertical.addArrangedSubview(nameLabel)
        stackVertical.addArrangedSubview(dateLabel)

        addSubview(contentView)
        photoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(37)
        }

        stackHorizontal.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(14)
        }

        contentView.snp.makeConstraints { make in
            make.top.equalTo(stackHorizontal.snp.bottom).inset(-12)
            make.left.right.bottom.equalToSuperview().inset(16)
        }
    }

    // MARK: PUBLIC FUNCS

    public func setText(text: String) {
        guard style == .editable else {
            return
        }
        editableLabel.text = text
    }
}
