//
//  InteractionsViewModel.swift
//  Musicall
//
//  Created by Lucas Oliveira on 20/09/21.
//

import Foundation
import CloudKit
import UIKit

class InteractionsViewModel {

    var reloadTableView: (() -> Void)?
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    var showError: (() -> Void)?
    var stopMusicLoading: (() -> Void)?

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
    func getComments(id: CKRecord.ID, completion: @escaping () -> Void) {
        
        cloudKit.fetchComment(id) { result in
            completion()
            switch result {
            case .success(let data):
                self.comment = data
                self.createCommentCells(comment: self.comment)
            case .failure(let error):
                fatalError("\(error)")
            }
        }
    }
    
    @objc
    func deleteRecord(id: CKRecord.ID) {
        cloudKit.deleteRecord(withRecord: id)
    }
    
    func createNewComment(postId: CKRecord.ID, authorId: CKRecord.ID, content: String) {
        
        cloudKit.createComment(withPost: postId, content: content, authorId: authorId)
        
    }

    func getViewModel() -> InteractionsListViewModel? {
        return cellViewModels
    }

    func createCells(post: PostListViewModel) {

        let vms = InteractionsListViewModel(id: post.id,
                                            authorName: post.authorName,
                                            authorId: post.authorId,
                                            content: post.content,
                                            likes: post.likes,
                                            date: post.date,
                                            comments: [])
        self.cellViewModels = vms
        
        guard let id = self.cellViewModels?.id else {
            return
        }
        self.getComments(id: id) {
            self.stopMusicLoading?()
        }

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
                   vms.append(ComentListViewModel(id: data.id,
                                                  authorName: authorName,
                                                  authorId: data.authorId,
                                                  content: data.content,
                                                  date: data.createdAt))

                   self.cellViewModels?.comments = vms
               })
           }
        }
    }

}

struct ComentListViewModel {
    let id: CKRecord.ID
    let authorName: String
    let authorId: CKRecord.Reference
    let content: String
    let date: Date
}

struct InteractionsListViewModel {
    let id: CKRecord.ID
    let authorName: String
    let authorId: CKRecord.Reference
    let content: String
    let likes: Int
    let date: Date
    var comments: [ComentListViewModel]
}
