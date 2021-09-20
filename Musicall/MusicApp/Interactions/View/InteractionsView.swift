//
//  InteractionsView.swift
//  Musicall
//
//  Created by Lucas Oliveira on 20/09/21.
//

import UIKit
import SnapKit

class InteractionsView: UIView {

    // MARK: UI ELEMENTS
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()

    private let keyboardTextField = KeyboardTexField(placeholder: "Escreva um comentário...")

    private let floatActionSheet = FloatActionSheet(imageIcon: .icContact, title: "Compartilhar meu perfil")

    // MARK: LIFE CYCLE
    init() {
        super.init(frame: .null)
        self.backgroundColor = .black
        configureUI()
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: PRIVATE FUNCS
    private func configureView() {
        floatActionSheet.isHidden = true
        keyboardTextField.addTargetAttachmentButton(target: self,
                                    action: #selector(switchHiddenStateFloatActionSheet))
    }

    private func configureUI() {
        addSubview(keyboardTextField)
        addSubview(tableView)
        addSubview(floatActionSheet)

        keyboardTextField.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(keyboardTextField.snp.top)
        }

        floatActionSheet.snp.makeConstraints { make in
            make.bottom.equalTo(keyboardTextField.snp.top).inset(-8)
            make.left.equalTo(keyboardTextField.snp.left).inset(8)
        }
    }

    // MARK: Objc
    @objc
    func switchHiddenStateFloatActionSheet() {
        floatActionSheet.isHidden.toggle()
    }
}

extension InteractionsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let card = CardCell()
        card.configureView(card: .init(headerInfos: .init(username: "Lucas Oliveira", date: "3 de Janeiro"),
                                       style: .complete(content: "Gostaria de contratar dois musicos, um baterista e um guitarrista, ambos tem que ser sem braço",
                                                        likes: 3,
                                                        interactions: 1)))
        return card
    }

}
