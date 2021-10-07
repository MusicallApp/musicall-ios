//
//  InteractionsViewModel.swift
//  Musicall
//
//  Created by Lucas Oliveira on 20/09/21.
//

import Foundation
import CloudKit

class InteractionsViewModel {

    var reloadTableView: (() -> Void)?
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    var showError: (() -> Void)?

    let cloudKit = ModelCloudKit()

    var cellViewModels: InteractionsListViewModel? {
        didSet {
            self.reloadTableView?()
        }
    }
    
    private var comment: [Comment] = []
    
    var numberOfCells: Int {
        return (cellViewModels?.comments.count ?? 0) + 1
    }
    
    @objc
    func getComments(id: CKRecord.ID) {
        
        cloudKit.fetchComment(id) { result in
            switch result {
            case .success(let data):
                self.comment = data
                self.createCommentCells(comment: self.comment)
            case .failure(let error):
                fatalError("\(error)")
            }
        }
    }
    
    func createNewComment(postId: CKRecord.ID, authorId: CKRecord.ID, content: String) {
        
        cloudKit.createComment(withPost: postId, content: content, authorId: authorId)
        
    }

    func getViewModel() -> InteractionsListViewModel? {
        return cellViewModels
    }

    func createCells(post: Post) {

        cloudKit.publicDataBase.fetch(withRecordID: post.authorId.recordID, completionHandler: { record, _ in
            guard let authorName = record?.object(forKey: "nickname") as? String else {
                return
            }

            let vms = InteractionsListViewModel(id: post.id,
                                                authorName: authorName,
                                                content: post.content,
                                                likes: post.likes,
                                                date: post.createdAt,
                                                comments: [])
            self.cellViewModels = vms
            
            guard let id = self.cellViewModels?.id else {
                return
            }
            self.getComments(id: id)
        })

    }
    
    func createCommentCells(comment: [Comment]) {
        self.comment = comment
        var vms = [ComentListViewModel]()

        let commentIndex = comment.isEmpty ? comment.count : comment.count - 1

        if !comment.isEmpty {

           for index in 0...commentIndex {

               let data = comment[index]

               let authorRecordName = data.authorId.recordID

               cloudKit.publicDataBase.fetch(withRecordID: authorRecordName, completionHandler: { record, _ in

                   guard let authorName = record?.object(forKey: "nickname") as? String else {
                       return
                   }
                   vms.append(ComentListViewModel(authorName: authorName,
                                                  content: data.content,
                                                  date: data.createdAt))

                   self.cellViewModels?.comments = vms
               })
           }
        }
    }

}

struct ComentListViewModel {
    let authorName: String
    let content: String
    let date: Date
}

struct InteractionsListViewModel {
    let id: CKRecord.ID
    let authorName: String
    let content: String
    let likes: Int
    let date: Date
    var comments: [ComentListViewModel]
}
