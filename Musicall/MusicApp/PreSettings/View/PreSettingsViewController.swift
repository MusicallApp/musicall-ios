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

    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let interactableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .trailing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let nicknameTextField = MCTextField(textLabel: "Apelido")
    private let phoneTextField = MCTextField(textLabel: "Telefone")
    private let selectableCardCompany = SelectableCard(style: .company)
    private let selectableCardMusician = SelectableCard(style: .musician)
    private let nextButton = MCButton(style: .primary, size: .larger)
    private let spaceView = UIView()

    // MARK: Control Variables.

    var coordinator: Coordinator?
    private let phoneFormatter = PhoneFormatter()

    // MARK: Life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTextField.textField.keyboardType = .phonePad
        phoneTextField.textField.delegate = self
        setupButton()
        setupCards()
        setupNavBar()
        setupView()
        addActionDismissKeyboard()
    }

    // MARK: Actions.

    @objc
    private func nextButtonTapped() {
        if let nickname = nicknameTextField.getText(),
           let phoneNumber = phoneTextField.getText(),
           validadeField(nickname),
           validadeField(phoneNumber) {
            UserDefaultHelper.setUser(User(nickName: nickname, phoneNumber: phoneNumber))
            animatoToSelectType()
        }
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: Functions.

    private func addActionDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        mainStackView.addGestureRecognizer(tapGesture)
    }

    private func validadeField(_ field: String) -> Bool {
        return
            !field.isEmpty &&
            !field.trimmingCharacters(in: .whitespaces).isEmpty
    }

    private func setupNavBar() {
        title = "Quem é você?"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.MCDesignSystem(font: .heading1),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }

    private func animatoToSelectType() {
        UIView.transition(with: interactableStackView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.interactableStackView.removeAllArrangedSubviews()
            self.interactableStackView.addArrangedSubview(self.selectableCardMusician)
            self.interactableStackView.addArrangedSubview(self.selectableCardCompany)
            self.mainStackView.insertArrangedSubview(UIView(), at: 1)
            self.spaceView.isHidden = true
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
        selectableCardCompany.delegate = self
        
        selectableCardMusician.titleText = UserType.musician.description
        selectableCardMusician.descriptionText = "Busca encontrar locais para tocar e quer fazer networking."
        selectableCardMusician.delegate = self
    }

    private func setupView() {
        view.backgroundColor = .black
        interactableStackView.addArrangedSubview(nicknameTextField)
        interactableStackView.addArrangedSubview(phoneTextField)
        buttonsStackView.addArrangedSubview(UIView())
        buttonsStackView.addArrangedSubview(nextButton)

        mainStackView.addArrangedSubview(subtitleLabel)
        mainStackView.addArrangedSubview(interactableStackView)
        mainStackView.addArrangedSubview(spaceView)
        mainStackView.addArrangedSubview(buttonsStackView)

        view.addSubview(mainStackView)

        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).inset(12)
            make.bottom.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(20)
        }

    }
}

// MARK: - Selectable Card Delegate Implementation.

extension PreSettingsViewController: SelectableCardDelegate {
    func selectCard(of type: SelectableCardStyle) {
        switch type {
        case .musician:
            UserDefaultHelper.set(UserType.musician.rawValue, for: .userType)
        case .company:
            UserDefaultHelper.set(UserType.company.rawValue, for: .userType)
        }

        if let user = UserDefaultHelper.getUser() {
            ModelCloudKit().createAuthor(withNickname: user.nickName,
                                         number: user.phoneNumber,
                                         type: user.type.rawValue)
        }
        coordinator?.navigate(.toMural, with: nil)
    }
}

// MARK: - TextField Delegate.

extension PreSettingsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        return phoneFormatter.mask(textField, range: range, replacementString: string)
    }
}
