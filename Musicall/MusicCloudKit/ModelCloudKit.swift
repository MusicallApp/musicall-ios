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
        container = CKContainer(identifier: "iCloud.MusicallApp")
        publicDataBase = container.publicCloudDatabase
    }
    
    // MARK: Utils
    
    func getDate() -> Date {
        let formatter = DateFormatter()
        let date = Date()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let dateString = formatter.string(from: date)
        guard let createdAt = formatter.date(from: dateString) else {
            return date
        }
        
        return createdAt
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
    
    // MARK: POST functions
    
    func createAuthor(withNickname nickname: String, number: String, type: Int) {
        
        let record = CKRecord(recordType: "Author")

        let date = getDate()
        
        record.setValue(nickname, forKey: "nickname")
        record.setValue(number, forKey: "number")
        record.setValue(type, forKey: "type")
        record.setValue(date, forKey: "createdAt")
        
        publicDataBase.save(record) { record, errors in
            
            if let error = errors {
                DispatchQueue.main.async {
                    fatalError("\(error)")
                }
            }
            
            guard record != nil else {
                return
            }

            UserDefaultHelper.set(record!.recordID.recordName, for: .userID)
            // Saved
        }
        
    }
    
    func createPost(withAuthor authorId: CKRecord.ID, content: String, likes: Int, completionHandler: (() -> Void)? = nil) {
       
        let record = CKRecord(recordType: "Post")
        
        let date = getDate()
        
        let authorReference = CKRecord.Reference(recordID: authorId, action: .deleteSelf)
        
        record.setValue(authorReference, forKey: "author_id")
        record.setValue(content, forKey: "content")
        record.setValue(likes, forKey: "likes")
        record.setValue(date, forKey: "createdAt")
        
        publicDataBase.save(record) { record, errors in
            
            if let error = errors {
                DispatchQueue.main.async {
                    fatalError("\(error)")
                }
            }
            
            guard record != nil else {
                return
            }
            
            completionHandler?()
            // Saved
        }
    }
    
    func createComment(withPost postId: CKRecord.ID, content: String, authorId: CKRecord.ID) {
        
        let record = CKRecord(recordType: "Comment")
        
        let date = getDate()
        
        let authorReference = CKRecord.Reference(recordID: authorId, action: .deleteSelf)
        let postReference = CKRecord.Reference(recordID: postId, action: .deleteSelf)
        
        record.setValue(authorReference, forKey: "author_id")
        record.setValue(content, forKey: "content")
        record.setValue(postReference, forKey: "post_id")
        record.setValue(date, forKey: "createdAt")
        
        publicDataBase.save(record) { record, errors in
            
            if let error = errors {
                DispatchQueue.main.async {
                    fatalError("\(error)")
                }
            }
            
            guard record != nil else {
                return
            }
            // Saved
        }
        
    }
}
