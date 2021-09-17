//
//  SelectableCard.swift
//  Musicall
//
//  Created by Lucas Oliveira on 16/09/21.
//

import UIKit
import SnapKit

enum SelectableCardStyle {
    case musician
    case company

    func getIcon() -> UIImage? {
        switch self {
        case .musician:
            return .icMic
        case .company:
            return .icHeadphone
        }
    }
}

class SelectableCard: UIView {

    // MARK: PRIVATE PROPERTIES
    public var titleText: String = "" {
        didSet {
            titleLabel.text = titleText
        }
    }

    public var descriptionText: String = "" {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }

    // MARK: PRIVATE PROPERTIES
    private let style: SelectableCardStyle

    // MARK: UI ELEMENTS
    private lazy var iconImage: UIImageView = {
        let imageView = UIImageView(image: style.getIcon())
        imageView.contentMode = .scaleAspectFit

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .MCDesignSystem(font: .title1)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .MCDesignSystem(font: .body)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let stackVerticalRight: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 0

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: LIFE CYCLE
    init(style: SelectableCardStyle) {
        self.style = style
        super.init(frame: .null)

        backgroundColor = .darkestGray
        layer.cornerRadius = 10

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: PRIVATE FUNCS
    private func configureUI() {
        addSubview(iconImage)
        addSubview(stackVerticalRight)

        iconImage.snp.makeConstraints { make in
            make.top.equalTo(stackVerticalRight).inset(4)
            make.left.equalToSuperview().inset(24)
            make.width.equalTo(25)
        }

        stackVerticalRight.addArrangedSubview(titleLabel)
        stackVerticalRight.addArrangedSubview(descriptionLabel)

        stackVerticalRight.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(34)
            make.right.equalToSuperview().inset(24)
            make.left.equalTo(iconImage.snp.right).inset(-16)
        }

    }
}
