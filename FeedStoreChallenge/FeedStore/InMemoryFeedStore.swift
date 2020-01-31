//
//  InMemoryFeedStore.swift
//  FeedStoreChallenge
//
//  Created by Dima Virych on 31.01.2020.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation

fileprivate struct Cache<Value> {
    let timeStamp: Date
    let value: [Value]
}

public final class InMemoryFeedStore {
    
    private var cache: Cache<LocalFeedImage>?
    
    public init() { }
}


// MARK: - FeedStore

extension InMemoryFeedStore: FeedStore {
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        
        cache = nil
        completion(nil)
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        
        cache = Cache(timeStamp: timestamp, value: feed)
        completion(nil)
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        
        completion(cache == nil ? .empty : .found(feed: cache!.value, timestamp: cache!.timeStamp))
    }
}
