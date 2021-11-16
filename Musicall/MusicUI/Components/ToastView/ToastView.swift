//
//  ToastView.swift
//  Musicall
//
//  Created by Lucas Oliveira on 11/11/21.
//

import UIKit
import SnapKit

class ToastView: UIView {
    let mainStackView: UIStackView = {
        let stackview = UIStackView()

        stackview.alignment = .center
        stackview.distribution = .fill
        stackview.axis = .horizontal
        stackview.spacing = 8

        return stackview
    }()

    let iconView: UIImageView = {
        let image = UIImageView(image: .icFace)
        image.contentMode = .scaleAspectFit
        return image
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Dados invalidos, verifique o Apelido e a senha."
        label.textColor = .white
        label.font = .MCDesignSystem(font: .caption2)
        return label
    }()

    init() {
        super.init(frame: .null)
        setupStackView()
        setupConstraints()
        backgroundColor = .red
        layer.cornerRadius = 5
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        addSubview(mainStackView)

        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }

        iconView.snp.makeConstraints { make in
            make.size.equalTo(22)
        }
    }

    private func setupStackView() {
        mainStackView.addArrangedSubview(iconView)
        mainStackView.addArrangedSubview(descriptionLabel)
    }

    public func show(view: UIView) {
        view.addSubview(self)

        self.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.right.equalToSuperview().inset(16)
        }

        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.center = .init(x: view.center.x, y: view.frame.maxY)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                self?.center = .init(x: view.center.x, y: -view.frame.maxY)
            }, completion: { _ in
                self.removeFromSuperview()
            })
        }
    }
}
