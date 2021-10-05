//
//  InteractionsView.swift
//  Musicall
//
//  Created by Lucas Oliveira on 20/09/21.
//

import UIKit
import SnapKit
import CloudKit

class InteractionsView: UIView {

    // MARK: PRIVATE PROPERTIES
    private var isKeyboardAppearing = false
    private var keyboardHeight: CGFloat = 0.0
    private var keyboardBottomConstraint: ConstraintMakerEditable?
    let viewModel = InteractionsViewModel()

    // MARK: UI ELEMENTS
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()

    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkestGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let keyboardTextField = KeyboardTextField(placeholder: "Escreva um comentário...", size: .reduced)
    
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
        addActionDismissKeyboard()
        keyboardTextField.delegate = self

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)

    }

    private func configureUI() {
        addSubview(bottomView)
        addSubview(keyboardTextField)
        addSubview(tableView)
        addSubview(floatActionSheet)

        bottomView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(snp.bottomMargin)
        }

        keyboardTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            keyboardBottomConstraint = make.bottom.equalTo(bottomView.snp.top)
        }

        tableView.snp.makeConstraints { make in
            make.topMargin.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(keyboardTextField.snp.top)
        }

        floatActionSheet.snp.makeConstraints { make in
            make.bottom.equalTo(keyboardTextField.snp.top).inset(-8)
            make.left.equalTo(keyboardTextField.snp.left).inset(8)
        }
    }

    private func addActionDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tableView.addGestureRecognizer(tapGesture)
    }

    // MARK: Objc
    @objc func dismissKeyboard() {
        endEditing(true)
    }

    @objc func switchHiddenStateFloatActionSheet() {
        floatActionSheet.isHidden.toggle()
    }

    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            if !isKeyboardAppearing {
                isKeyboardAppearing = true
                let inset = -1 * (keyboardHeight - bottomView.frame.height)
                keyboardBottomConstraint?.constraint.update(inset: inset)
            }
        }

    }

    @objc func keyboardWillHide(notification: Notification) {
        if isKeyboardAppearing {
            isKeyboardAppearing = false
            keyboardBottomConstraint?.constraint.update(inset: 0)
        
        }
    }
}

extension InteractionsView: KeyboardTextFieldDelegate {
    func sendAction() {
        guard let userID = UserDefaultHelper.get(field: .userID) as? CKRecord.ID,
        let postID = viewModel.cellViewModels?.id,
        let content = keyboardTextField.commentTextField.text else {
            return
        }
        viewModel.createNewComment(postId: postID, authorId: userID, content: content)
    }

}

// MARK: UITableView Delegate & DataSource
extension InteractionsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let interactionCell = viewModel.getViewModel() else {
            return UITableViewCell()
        }

        switch indexPath.row {
        case 0:
            let cardCell = CardCell()

            let content = interactionCell.content
            let cardView = Card(headerInfos: .init(username: interactionCell.authorName,
                                                   date: interactionCell.date.description),
                                style: .complete(content: content,
                                                 likes: interactionCell.likes,
                                                 interactions: 1))

            cardCell.configureView(card: cardView, bottomSpacing: 16)

            return cardCell

        default:
            let cardCell = CardCell()
            let comment = interactionCell.comments[indexPath.row - 1]

            let content = comment.content
            let cardView = Card(headerInfos: .init(username: comment.authorName, date: comment.date.description),
                                style: .simple(content: content))
            cardCell.configureView(card: cardView, bottomSpacing: 16)

            return cardCell
        }

    }

}
