//
//  ConfirmReportViewController.swift
//  Musicall
//
//  Created by Elias Ferreira on 20/10/21.
//

import UIKit
import SnapKit

class ConfirmReportViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    var delegate: ReportDelegate?

    lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "confirm")
        return imageView
    }()

    lazy var subtitle: UILabel = {
        let label = UILabel()
        label.text = "Sua denúncia foi enviada com sucesso!"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = .MCDesignSystem(font: .subtitle)
        return label
    }()

    lazy var bodyText: UILabel = {
        let label = UILabel()
        label.text = "Obrigado por apoiar o crescimento de nossa comunidade. "
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = .MCDesignSystem(font: .body)
        return label
    }()

    lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continuar", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .MCDesignSystem(font: .subtitle1)
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()

        let closeImage = UIImage(named: "Close")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: closeImage,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(closeAction))
    }

    private func setupNavBar() {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sendButton.layer.cornerRadius = 10
    }

    @objc
    private func closeAction() {
        coordinator?.dismiss(self, completion: nil)
        delegate?.dismissParent()
    }

    private func setupView() {
        view.backgroundColor = .black

        view.addSubview(icon)
        view.addSubview(subtitle)
        view.addSubview(bodyText)
        view.addSubview(sendButton)

        icon.translatesAutoresizingMaskIntoConstraints = false
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        bodyText.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false

        setupConstraints()
    }

    private func setupConstraints() {
        icon.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(50)
            make.centerX.equalToSuperview()
        }

        subtitle.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

        bodyText.snp.makeConstraints { make in
            make.top.equalTo(subtitle.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

        sendButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(32)
        }
    }

}
