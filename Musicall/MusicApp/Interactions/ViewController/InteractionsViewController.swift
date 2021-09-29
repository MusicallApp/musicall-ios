//
//  InteractionsViewController.swift
//  Musicall
//
//  Created by Lucas Oliveira on 20/09/21.
//

import UIKit

class InteractionsViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    let viewModel = InteractionsViewModel()

    private let interactionsView = InteractionsView()

    override func loadView() {
        super.loadView()
        self.view = interactionsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "interações"
        navigationItem.largeTitleDisplayMode = .never

        setUpViewModel()
    }

    private func setUpViewModel() {

        viewModel.showError = {
            DispatchQueue.main.async {
                print("Error")
            }
        }

        viewModel.showLoading = {
            DispatchQueue.main.async {
            }
        }

        viewModel.hideLoading = {
            DispatchQueue.main.async {
            }
        }
    }

}
