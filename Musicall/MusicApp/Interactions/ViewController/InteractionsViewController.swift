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

    override func loadView() {
        super.loadView()
        self.view = interactionsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "interações"
        navigationItem.largeTitleDisplayMode = .never
    }

    func setUpViewModel(post: Post) {

        interactionsView.viewModel.reloadTableView = {
            DispatchQueue.main.async {
                self.interactionsView.tableView.reloadData()
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
