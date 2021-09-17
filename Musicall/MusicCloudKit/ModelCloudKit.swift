//
//  ModelCloudKit.swift
//  Musicall
//
//  Created by Vitor Bryan on 16/09/21.
//

import Foundation
import CloudKit

class ModelCloudKit {
    
    // MARK: Control variables
    
    let container: CKContainer
    let publicDataBase: CKDatabase
    static var currentModel = ModelCloudKit()
    
    // MARK: Setup Container
    
    init() {
        container = CKContainer(identifier: "iCloud.Musicall")
        publicDataBase = container.publicCloudDatabase
    }
    
    // MARK: GET functions 
    
    func fetchPost(_ completion: @escaping (Result<[Post], Error>) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Post", predicate: predicate)
        
        publicDataBase.perform(query, inZoneWith: CKRecordZone.default().zoneID) { results, errors in
            
            if let error = errors {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
            guard let result = results else { return }
            let data = result.compactMap {
                Post.init(record: $0)
            }
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
    }
    
    func fetchAuthor(_ completion: @escaping (Result<[Author], Error>) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Author", predicate: predicate)
        
        publicDataBase.perform(query, inZoneWith: CKRecordZone.default().zoneID) { results, errors in
            
            if let error = errors {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
            guard let result = results else { return }
            let data = result.compactMap {
                Author.init(record: $0)
            }
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
    }
    
    func fetchComment(_ completion: @escaping (Result<[Comment], Error>) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Comment", predicate: predicate)
        
        publicDataBase.perform(query, inZoneWith: CKRecordZone.default().zoneID) { results, errors in
            
            if let error = errors {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
            guard let result = results else { return }
            let data = result.compactMap {
                Comment.init(record: $0)
            }
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
    }
}
