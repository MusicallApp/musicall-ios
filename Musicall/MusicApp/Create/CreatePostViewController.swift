//
//  CreatePostViewController.swift
//  Musicall
//
//  Created by Lucas Fernandes on 20/09/21.
//

import UIKit
import CloudKit

class CreatePostViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?

    let editableCard = Card(headerInfos: .init(username: UserDefaultHelper.get(field: .userNickName) as? String ?? "",
                                               date: Date().getFormattedDate(format: .dayMonth)),
                            style: .editable)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Criar um post"
        view.backgroundColor = .black
        
        setupEditableCard()
        setupNavigationController()
    }

    func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                                                  style: .done,
                                                                                  target: self,
                                                                                  action: #selector(createPost))
//        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.Style.subtitle1]
        navigationController?.navigationBar.largeTitleTextAttributes = [
                    NSAttributedString.Key.font: UIFont.MCDesignSystem(font: .heading1),
                    NSAttributedString.Key.foregroundColor: UIColor.white
                ]
        
        let image = UIImage(systemName: "arrow.left")
        navigationController?.navigationBar.backIndicatorImage = image
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = image

        navigationController?.navigationBar.tintColor = .blue
        navigationController?.navigationBar.barTintColor = .clear
    }

    func setupEditableCard() {
        view.addSubview(editableCard)
        editableCard.translatesAutoresizingMaskIntoConstraints = false

        editableCard.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().inset(24)
            make.left.right.equalToSuperview().inset(16)
        }
    }

    // MARK: Actions
    @objc func createPost() {
        if let userID = UserDefaultHelper.get(field: .userID) as? CKRecord.ID {
            ModelCloudKit().createPost(withAuthor: userID, content: editableCard.currentText ?? "", likes: 0) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.navigationController?.popViewController(animated: true)

                }
            }
        }
    }
}
