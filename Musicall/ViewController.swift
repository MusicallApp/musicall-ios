//
//  ViewController.swift
//  Musicall
//
//  Created by Vitor Bryan on 09/09/21.
//

import UIKit

class ViewController: UIViewController {

    private let stackVertical: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 0

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(stackVertical)
        stackVertical.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }

        let card = SelectableCard(style: .musician)
        card.titleText = "Contratante"
        card.descriptionText = "Busca encontrar locais para tocar e quer fazer networking."
        stackVertical.addArrangedSubview(card)
        // Do any additional setup after loading the view.
    }

}
