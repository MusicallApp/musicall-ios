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
    let tableView: UITableView = {
        let tableView = UITableView()

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
            make.topMargin.left.right.equalToSuperview()
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
