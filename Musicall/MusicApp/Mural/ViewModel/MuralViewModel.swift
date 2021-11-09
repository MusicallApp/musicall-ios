//
//  MuralViewModel.swift
//  Musicall
//
//  Created by Vitor Bryan on 21/09/21.
//

import Foundation
import CloudKit

class MuralViewModel {
   
    var posts: [Post] = [Post]()
    var reloadTableView: (() -> Void)?
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    var showError: (() -> Void)?
    
    let cloudKit = ModelCloudKit()
    
    var cellViewModels: [PostListViewModel] = [PostListViewModel]() {
        didSet {
            if cellViewModels.count == posts.count {
                self.reloadTableView?()
            }
        }
    }
    
    private var cellViewModelsAux: [PostListViewModel] = [PostListViewModel]()
    
    @objc
    func getPosts() {
        
        cloudKit.fetchPost { result in
          
            switch result {
            case .success(let data):
                let blockedUsers = UserDefaultHelper.get(field: .blockedUsers) as? [CKRecord.ID]
                self.posts = data
                self.posts = self.posts.filter { !(blockedUsers?.contains($0.authorId.recordID) ?? false) }
                self.createCell(posts: self.posts)
            case .failure(let error):
                fatalError("\(error)")
            }
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> PostListViewModel {
        
        return (cellViewModels.isEmpty ? cellViewModelsAux[indexPath.row] : cellViewModels[indexPath.row])
    }
    
    func createCell(posts: [Post]) {
        self.posts = posts
        var vms = [PostListViewModel]()
        
        let postsIndex = posts.isEmpty ? posts.count : posts.count - 1
        
        if !posts.isEmpty {
        
            for index in 0...postsIndex {
                
                let data = posts[index]
                
                let authorRecordName = data.authorId.recordID
                
                cloudKit.publicDataBase.fetch(withRecordID: authorRecordName, completionHandler: { record, _ in
                    
                    guard let authorName = record?.object(forKey: "nickname") as? String else {
                            assertionFailure(ErrorHelper.howAreYou.rawValue)
                        return
                    }

                    vms.append(PostListViewModel(id: data.id,
                                                 authorName: authorName,
                                                 authorId: data.authorId,
                                                 content: data.content,
                                                 likes: data.likes,
                                                 date: data.createdAt,
                                                 comments: 0))
                    
                    if vms.count == posts.count {
                        let sortedArray = vms.sorted {
                            $0.date > $1.date
                        }
                        
                        self.cellViewModels = sortedArray
                        self.cellViewModelsAux = self.cellViewModels
                    } else {
                        self.cellViewModels = []
                    }
                    
                })
            }
        }
    }
    
    func deleteCell(with recordID: CKRecord.ID) {
        for index in 0...cellViewModels.count where cellViewModels[index].id == recordID {
            cellViewModels.remove(at: index)
            self.reloadTableView?()
        }
    }
    
}

struct PostListViewModel {
    let id: CKRecord.ID
    let authorName: String
    let authorId: CKRecord.Reference
    let content: String
    let likes: Int
    let date: Date
    let comments: Int
}
