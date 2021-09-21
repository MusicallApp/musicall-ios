//
//  PreSettingsViewController.swift
//  Musicall
//
//  Created by Elias Ferreira on 20/09/21.
//

import UIKit
import SnapKit

class PreSettingsViewController: UIViewController, Coordinating {

    // MARK: UI.

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Para personalizarmos sua experiência, precisamos saber quem você é."
        label.font = .MCDesignSystem(font: .title1)
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 32
        return stackView
    }()

    private let nicknameTextField = MCTextField(textLabel: "Apelido")
    private let phoneTextField = MCTextField(textLabel: "Telefone")
    private let selectableCardCompany = SelectableCard(style: .company)
    private let selectableCardMusician = SelectableCard(style: .musician)
    private let nextButton = MCButton(style: .primary, size: .larger)

    // MARK: Control Variables.

    var coordinator: Coordinator?
    var user: User?

    // MARK: Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupCards()
        setupNavBar()
        setupView()
    }

    // MARK: Actions.
    @objc
    private func nextButtonTapped() {
        if let nickname = nicknameTextField.getText(),
           let phoneNumber = phoneTextField.getText() {
            user = User(nickName: nickname, phoneNumber: phoneNumber)
            animatoToSelectType()
        }
    }

    // MARK: Functions.

    private func setupNavBar() {
        title = "Quem é você?"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.MCDesignSystem(font: .heading1),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }

    private func animatoToSelectType() {
        UIView.transition(with: stackView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.stackView.removeAllArrangedSubviews()
            self.stackView.addArrangedSubview(self.selectableCardMusician)
            self.stackView.addArrangedSubview(self.selectableCardCompany)
            self.nextButton.isHidden = true
        }, completion: nil)
    }

    private func setupButton() {
        nextButton.setImage(.icArrowDown, for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }

    private func setupCards() {
        selectableCardCompany.titleText = UserType.company.description
        selectableCardCompany.descriptionText = "Procura por músicos para se apresentar em eventos."
        selectableCardMusician.titleText = UserType.musician.description
        selectableCardMusician.descriptionText = "Busca encontrar locais para tocar e quer fazer networking."

        selectableCardMusician.delegate = self
        selectableCardCompany.delegate = self
    }

    private func setupView() {
        view.backgroundColor = .black
        view.addSubview(subtitleLabel)
        stackView.addArrangedSubview(nicknameTextField)
        stackView.addArrangedSubview(phoneTextField)
        view.addSubview(stackView)
        view.addSubview(nextButton)

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(12)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(20)
        }

        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(66)
            make.trailing.equalToSuperview().inset(20)
        }
    }
}

extension PreSettingsViewController: SelectableCardDelegate {
    func selectCard(of type: SelectableCardStyle) {
        switch type {
        case .musician:
            user?.type = .musician
        case .company:
            user?.type = .company
        }

        coordinator?.eventOcurred(with: .goToMural, data: user)
    }
}
