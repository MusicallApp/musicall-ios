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
    
    private var cellViewModels: [PostListViewModel] = [PostListViewModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    func getPosts() {
        cloudKit.fetchPost { result in
            switch result {
            case .success(let data):
                self.posts = data
                self.createCell(posts: self.posts)
                self.reloadTableView?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> PostListViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCell(posts: [Post]) {
        self.posts = posts
        var vms = [PostListViewModel]()
        for data in posts {
            
            let authorRecordName = data.authorId.recordID
            
            cloudKit.publicDataBase.fetch(withRecordID: authorRecordName, completionHandler: { record, _ in
                
                guard let authorName = record?.object(forKey: "nickname") as? String else {
                    return
                }
                vms.append(PostListViewModel(authorName: authorName,
                                             content: data.content,
                                             likes: data.likes,
                                             date: data.createdAt))
                self.cellViewModels = vms
            })
        }
    }
    
}

struct PostListViewModel {
    let authorName: String
    let content: String
    let likes: Int
    let date: Date
}
