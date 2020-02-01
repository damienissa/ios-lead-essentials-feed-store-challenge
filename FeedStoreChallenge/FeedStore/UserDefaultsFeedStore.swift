//
//  UserDefaultsFeedStore.swift
//  FeedStoreChallenge
//
//  Created by Dima Virych on 01.02.2020.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation

public class UserDefaultsFeedStore<Defaults: UserDefaults> {
    
    typealias Cache = CodableCache<CodableRepresentationLocalFeedImage>
    
    @UDProperty(defaults: Defaults()) var cache: Cache?
    
    public init() { }
}


// MARK: - FeedStore

extension UserDefaultsFeedStore: FeedStore {
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        
        cache = nil
        completion(nil)
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        
        cache = Cache(timestamp: timestamp, value: feed.codable)
        completion(nil)
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        
        completion(cache == nil ? .empty : .found(feed: cache!.value.local, timestamp: cache!.timestamp))
    }
}
