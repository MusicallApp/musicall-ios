//
//  ProfileViewModel.swift
//  Musicall
//
//  Created by Lucas Oliveira on 17/11/21.
//

import Foundation
import CloudKit

class ProfileViewModel: ProfileViewDelegate {

    let model: ProfileModel

    var posts: [Post] = [Post]()
    var reloadTableView: (() -> Void)?
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?

    let cloudKit = ModelCloudKit()

    var cellViewModels: [PostListViewModel] = [PostListViewModel]() {
        didSet {
            if cellViewModels.count == posts.count {
                self.reloadTableView?()
            }
        }
    }

    private var cellViewModelsAux: [PostListViewModel] = [PostListViewModel]()

    init(model: ProfileModel) {
        self.model = model
        getPosts()
    }

    @objc
    func getPosts() {

        cloudKit.fetchPost { result in

            switch result {
            case .success(let data):
                self.posts = data
                self.posts = self.posts.filter { $0.authorId.recordID == self.model.authorId }
                self.createCell(posts: self.posts)
            case .failure(let error):
                fatalError("\(error)")
            }
        }
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

}
