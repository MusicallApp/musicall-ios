//
//  LoginViewController.swift
//  Musicall
//
//  Created by Vitor Bryan on 11/11/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: UI
    
    private let coverImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "CoverPhoto")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Musicall")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Conecte-se para conhecer novas oportunidades e impulsionar sua carreira!"
        label.font = .MCDesignSystem(font: .subtitle1)
        label.textColor = .lightGray
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let mainTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 32
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let signUpButton = MCButton(style: .primary, size: .custom(width: 0, height: 50))
    private let signInButton = UIButton(type: .system)
    
    // MARK: Control Variables
    
    var coordinator: Coordinator?
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
        setUpUI()

        signInButton.isHidden = true
        
    }
    
    private func setUpButtons() {
        signUpButton.setTitle("Minha primeira vez", for: .normal)
        signUpButton.titleLabel?.font = .MCDesignSystem(font: .subtitle1)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.addTarget(self, action: #selector(goToSignUp), for: .touchUpInside)
        
        signInButton.setTitle("Já sou cadastrado", for: .normal)
        signInButton.titleLabel?.font = .MCDesignSystem(font: .subtitle1)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.addTarget(self, action: #selector(goToSignIn), for: .touchUpInside)
    }
    
    private func setUpUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .black
        view.addSubview(coverImageView)
        
        mainTitleStackView.addArrangedSubview(titleImageView)
        mainTitleStackView.addArrangedSubview(descriptionLabel)
        
        buttonsStackView.addArrangedSubview(signUpButton)
        buttonsStackView.addArrangedSubview(signInButton)
        
        view.addSubview(mainTitleStackView)
        view.addSubview(buttonsStackView)
        
        coverImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 2)

        }
        
        mainTitleStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(40)
            make.centerY.equalToSuperview().inset(-30)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(40)
            make.top.equalTo(mainTitleStackView.snp.bottomMargin).inset(-50)
        }
        
    }
    
    @objc
    func goToSignUp() {
        coordinator?.navigate(.toSignUp, with: nil)
    }
    
    @objc
    func goToSignIn() {
        coordinator?.navigate(.toSignIn, with: nil)
    }
    
}
