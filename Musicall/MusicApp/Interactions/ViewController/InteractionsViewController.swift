//
//  InteractionsViewController.swift
//  Musicall
//
//  Created by Lucas Oliveira on 20/09/21.
//

import UIKit
import CloudKit

class InteractionsViewController: UIViewController, Coordinating {

    var coordinator: Coordinator?
    
    private let interactionsView = InteractionsView()
    private let muralView = MuralViewController()
    
    private let spinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.color = .white
        return indicator
    }()
    
    private var recordId = CKRecord.ID()
    private var cellIndex = Int()
    private var auhtorId = CKRecord.ID()

    override func loadView() {
        super.loadView()
        interactionsView.delegate = self
        self.view = interactionsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(spinner)
        
        title = "Interações"
        navigationItem.largeTitleDisplayMode = .never
        
        setUpSpinner()
    }
    
    func setUpSpinner() {
        spinner.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    func setUpViewModel(post: PostListViewModel) {
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
    func dotsAction(with recordID: CKRecord.ID, indexPath: Int, authorId: CKRecord.ID) {

        var message: UIAlertController.Style

        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            message = .actionSheet
        case .pad:
            message = .alert
        @unknown default:
            return
        }

        if let userID = UserDefaultHelper.get(field: .userID) as? CKRecord.ID, userID == authorId {
            AlertHelper.showDeleteActionSheet(on: self, with: self, preferredStyle: message)
        } else {
            AlertHelper.showReportActionSheet(on: self, with: self, preferredStyle: message)
        }

        self.recordId = recordID
        self.cellIndex = indexPath
        self.auhtorId = authorId
    }
}

extension InteractionsViewController: AlertDelegate {
    func actionSheetReportAction() {
        if let user = UserDefaultHelper.getUser() {
            let report = Report(authorName: user.nickName, authorId: auhtorId, postId: recordId)
            coordinator?.navigate(.toReport, with: report)
        }
    }

    func actionConfirmDelete() {
        if cellIndex == 0 {
            interactionsView.viewModel.deleteRecord(id: self.recordId)
            coordinator?.pop(self)
            muralView.viewModel.getPosts()

        } else {
            interactionsView.viewModel.deleteRecord(id: self.recordId)
            interactionsView.viewModel.cellViewModels?.comments.remove(at: cellIndex - 1)
            interactionsView.tableView.deleteRows(at: [IndexPath(row: self.cellIndex, section: 0)], with: .left)
        }
    }
    
    func actionSheetDeleteAction() {
        AlertHelper.showConfimAlert(
            on: self,
            title: "Apagar mensagem?",
            message: "Após deletar essa mensagem, não será possível desfazer a ação!",
            with: self
        )
    }
}
