//
//  MCTextField.swift
//  Musicall
//
//  Created by Elias Ferreira on 19/09/21.
//

import UIKit

class MCTextField: UIView {

    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.MCDesignSystem(font: .subtitle1)
        label.textColor = .white
        return label
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .darkestGray
        textField.textColor = .lightGray
        textField.setLeftPadding(10)
        textField.font = UIFont.MCDesignSystem(font: .body)
        return textField
    }()

    init(textLabel: String) {
        super.init(frame: .zero)
        backgroundColor = .black
        label.text = textLabel
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        textField.layer.cornerRadius = 5.5
    }

    private func setupView() {
        addSubview(label)
        addSubview(textField)

        label.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }

        textField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(8)
            make.width.equalToSuperview()
            make.height.equalTo(42)
            make.bottom.equalToSuperview()
        }
    }

}
