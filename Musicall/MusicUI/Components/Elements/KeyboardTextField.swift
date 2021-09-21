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

protocol KeyboardTextFieldDelegate: AnyObject {
    func sendAction()
}

class KeyboardTextField: UIView {

    // MARK: PUBLIC PROPERTIES
    public weak var delegate: KeyboardTextFieldDelegate?

    // MARK: PRIVATE PROPERTIES
    private var heightConstraint: SnapKit.ConstraintMakerEditable?

    // MARK: UI ELEMENTS
    private let attachmentButton: MCButton = {
        let button = MCButton(style: .ghost, size: .medium)
        button.setImage(.icPaperclip, for: .normal)
        return button
    }()

    private let commentTextField: UITextField = {
        let textField = UITextField()

        let imageView = UIImageView(image: UIImage(named: "Telegram_spaced"))
        imageView.addGestureRecognizer(.init(target: self, action: #selector(sendAction)))

        textField.backgroundColor = .black
        textField.textColor = .lightGray
        textField.rightView = imageView
        textField.setLeftPadding(10)
        textField.rightViewMode = .always
        textField.font = UIFont.MCDesignSystem(font: .body)
        return textField
    }()

    // MARK: LIFE CYCLE
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

    // MARK: PRIVATE FUNCS
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

    // MARK: Action
    @objc func sendAction() {
        delegate?.sendAction()
    }

    // MARK: PUBLIC FUNCS
    func setSize(with size: TextFieldSize) {
        snp.makeConstraints { make in
            make.height.equalTo(size.rawValue)
        }
    }

    func addTargetAttachmentButton(target: AnyObject, action: Selector) {
        attachmentButton.addTarget(target, action: action, for: .touchDown)
    }
}
