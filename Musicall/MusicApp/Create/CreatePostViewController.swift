//
//  CreatePostViewController.swift
//  Musicall
//
//  Created by Lucas Fernandes on 20/09/21.
//

import UIKit

class CreatePostViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?

    let editableCard = Card(headerInfos: .init(username: "John", date: "26 de Janeiro"), style: .editable)

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
                                                                                  action: nil)
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
}
