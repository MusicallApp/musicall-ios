//
//  KeyboardTexField.swift
//  Musicall
//
//  Created by Elias Ferreira on 19/09/21.
//

import UIKit
import SnapKit

enum TextFieldSize: CGFloat {
    case normal = 96
    case reduced = 62
}

class KeyboardTexField: UIView {

    private let attachmentButton: MCButton = {
        let button = MCButton(style: .ghost, size: .medium)
        button.setImage(.icPaperclip, for: .normal)
        return button
    }()

    private let commentTextField: UITextField = {
        let textField = UITextField()
        let image = UIImageView(image: UIImage(named: "Telegram_spaced"))
        textField.backgroundColor = .black
        textField.textColor = .lightGray
        textField.rightView = image
        textField.setLeftPadding(10)
        textField.rightViewMode = .always
        textField.font = UIFont.MCDesignSystem(font: .body)
        return textField
    }()

    init(placeholder: String, size: TextFieldSize = .normal) {
        super.init(frame: .zero)
        backgroundColor = .darkestGray
        commentTextField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        setupView()
        setSize(with: size)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        commentTextField.layer.cornerRadius = 5.5
    }

    func setSize(with size: TextFieldSize) {
        snp.makeConstraints { make in
            make.height.equalTo(size.rawValue)
        }
    }

    private func setupView() {
        addSubview(attachmentButton)
        addSubview(commentTextField)

        attachmentButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(10)
        }

        commentTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.height.equalTo(38)
            make.leading.equalTo(attachmentButton.snp.trailing).offset(6)
            make.trailing.equalToSuperview().inset(16)
        }
    }

    func addTargetAttachmentButton(target: AnyObject, action: Selector) {
        attachmentButton.addTarget(target, action: action, for: .touchDown)
    }
}
