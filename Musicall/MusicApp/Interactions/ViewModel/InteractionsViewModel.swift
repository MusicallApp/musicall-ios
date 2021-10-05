//
//  InteractionsViewModel.swift
//  Musicall
//
//  Created by Lucas Oliveira on 20/09/21.
//

import Foundation

class InteractionsViewModel {

    var reloadTableView: (() -> Void)?
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    var showError: (() -> Void)?

    let cloudKit = ModelCloudKit()

    private var cellViewModels: InteractionsListViewModel? {
        didSet {
            self.reloadTableView?()
        }
    }

    var numberOfCells: Int {
        return (cellViewModels?.comments.count ?? 0) + 1
    }

    func getViewModel() -> InteractionsListViewModel? {
        return cellViewModels
    }

    func createCells(post: Post) {

        cloudKit.publicDataBase.fetch(withRecordID: post.authorId.recordID, completionHandler: { record, _ in
            guard let authorName = record?.object(forKey: "nickname") as? String else {
                return
            }

            // TODO: Load Commets.

            let vms = InteractionsListViewModel(authorName: authorName,
                                            content: post.content,
                                            likes: post.likes,
                                            date: post.createdAt,
                                            comments: [])
            self.cellViewModels = vms
        })

    }

}

struct ComentListViewModel {
    let authorName: String
    let content: String
    let date: Date
}

struct InteractionsListViewModel {
    let authorName: String
    let content: String
    let likes: Int
    let date: Date
    var comments: [ComentListViewModel]
}
