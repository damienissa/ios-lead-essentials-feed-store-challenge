//
//  RealmFeedStore.swift
//  FeedStoreChallenge
//
//  Created by Dima Virych on 01.02.2020.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation

public class RealmFeedStore {
    
    var realm: RealmDecorator!
    
    public init(store: RealmDecorator) {
        realm = store
    }
}


// MARK: - FeedStore

extension RealmFeedStore: FeedStore {
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        
        do {
            try realm.write { [weak self] in
                guard let self = self else { return }
                self.realm.delete(realm.objects(RealmCache.self))
                completion(nil)
            }
        } catch {
            completion(error)
        }
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        
        do {
            try realm.write { [weak self] in
                
                guard let self = self else { return }
                
                self.realm.add(RealmCache(feed, timestamp: timestamp))
                completion(nil)
            }
            
        } catch {
            completion(error)
        }
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        
        if let cache = realm.objects(RealmCache.self).first {
            completion(.found(feed: cache.values.map { $0.local }, timestamp: cache.timestamp))
        } else {
            completion(.empty)
        }
    }
}
