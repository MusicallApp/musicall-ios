//
//  FloatActionSheet.swift
//  Musicall
//
//  Created by Elias Ferreira on 15/09/21.
//

import UIKit
import SnapKit

class FloatActionSheet: UIView {

    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .blue
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.MCDesignSystem(font: .body)
        label.textColor = .white
        return label
    }()

    init(imageIcon: UIImage?, title: String) {
        super.init(frame: .zero)
        backgroundColor = .darkestGray
        icon.image = imageIcon
        titleLabel.text = title
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 6
    }

    func addTarget(target: AnyObject, action: Selector?) {
        let gesture = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(gesture)
    }

    private func setupView() {
        addSubview(icon)
        addSubview(titleLabel)

        // Main view default size.
        // Can be changed on superview.
        snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(50)
            make.width.greaterThanOrEqualTo(200)
        }

        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(14)
            make.size.equalTo(20)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(icon.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(14)
        }
    }

}
