//
//  InteractionsViewController.swift
//  Musicall
//
//  Created by Lucas Oliveira on 20/09/21.
//

import UIKit

class InteractionsViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    
    private let interactionsView = InteractionsView()
    
    private let spinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.color = .white
        return indicator
    }()

    override func loadView() {
        super.loadView()
        interactionsView.delegate = self
        self.view = interactionsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(spinner)
        
        title = "interações"
        navigationItem.largeTitleDisplayMode = .never
        
        setUpSpinner()
    }
    
    func setUpSpinner() {
        spinner.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    func setUpViewModel(post: Post) {
        spinner.startAnimating()
        interactionsView.viewModel.reloadTableView = {
            DispatchQueue.main.async {
                self.interactionsView.tableView.reloadData()
                self.spinner.stopAnimating()
            }
        }

        interactionsView.viewModel.showError = {
            DispatchQueue.main.async {
                print("Error")
            }
        }

        interactionsView.viewModel.showLoading = {
            DispatchQueue.main.async {
            }
        }

        interactionsView.viewModel.hideLoading = {
            DispatchQueue.main.async {
            }
        }

        interactionsView.viewModel.createCells(post: post)
    }

}

extension InteractionsViewController: InteractionViewActionDelegate {
    func dotsAction() {
        AlertHelper.showDeleteActionSheet(on: self, with: self)
    }
}

extension InteractionsViewController: AlertDeleteDelegate {
    func actionSheetDeleteAction() {
        AlertHelper.showConfimAlert(
            on: self,
            title: "Apagar mensagem?",
            message: "Após deletar essa mensagem, não será possível desfazer a ação!"
        )
    }
}
