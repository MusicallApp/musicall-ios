//
//  ReportViewController.swift
//  Musicall
//
//  Created by Elias Ferreira on 20/10/21.
//

import UIKit
import SnapKit

protocol ReportDelegate: AnyObject {
    func dismissParent()
}

class ReportViewController: UIViewController, Coordinating {

    lazy var subtitle: UILabel = {
        let label = UILabel()
        label.text = "O que te levou a denunciar essa publicação?"
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.font = .MCDesignSystem(font: .subtitle)
        return label
    }()

    lazy var commentTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Escreva seu comentário..."
        textView.backgroundColor = .darkestGray
        textView.textColor = .gray
        textView.font = .MCDesignSystem(font: .body)
        return textView
    }()

    lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Enviar", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .MCDesignSystem(font: .subtitle1)
        button.addTarget(self, action: #selector(sendButtonAction), for: .touchUpInside)
        return button
    }()

    var coordinator: Coordinator?
    var report: Report?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc
    private func dismissKeyboard() {
        commentTextView.endEditing(true)
    }

    @objc
    private func sendButtonAction() {
        if let comment = commentTextView.text, let rep = self.report {
            let telegramReport = TelegramReport(author: rep.authorName,
                                                authorID: rep.authorId.recordName, postID: rep.postId.recordName,
                                                message: comment)
            BotProvider().sendMessage(telegramReport) { result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        UserDefaultHelper.setBlockedUser(userId: rep.authorId)
                        self.coordinator?.navigate(.toConfirmReport, with: self)
                    }
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }
        }
    }

    private func setupNavBar() {
        title = "Denunciar"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.MCDesignSystem(font: .heading1),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        commentTextView.layer.cornerRadius = 10
        sendButton.layer.cornerRadius = 10
    }

    private func setupView() {
        view.backgroundColor = .black
        view.addSubview(subtitle)
        view.addSubview(commentTextView)
        view.addSubview(sendButton)

        subtitle.translatesAutoresizingMaskIntoConstraints = false
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false

        commentTextView.delegate = self

        setupConstraints()
    }

    private func setupConstraints() {
        subtitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

        commentTextView.snp.makeConstraints { make in
            make.top.equalTo(subtitle.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(150)
        }

        sendButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).inset(32)
        }
    }

}

extension ReportViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray {
            textView.text = nil
            textView.textColor = .lightGray
        }
    }
}

extension ReportViewController: ReportDelegate {
    func dismissParent() {
        coordinator?.pop(self)
    }
}
