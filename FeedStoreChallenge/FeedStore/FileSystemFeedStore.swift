//
//  FileSystemFeedStore.swift
//  FeedStoreChallenge
//
//  Created by Dima Virych on 31.01.2020.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation

public class FileSystemFeedStore {
    
    typealias Cache = CodableCache<CodableRepresentationLocalFeedImage>
    
    private let localURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("\(FileSystemFeedStore.self).db")
    
    private var insertCompletion: InsertionCompletion?
    private var deleteCompletion: DeletionCompletion?
    private var retrieveCompletion: RetrievalCompletion?
    
    private var cache: Cache? {
        get {
            getCache()
        }
        set {
            save(newValue)
        }
    }
    
    public init() { }
    
    private func save(_ cache: Cache?) {
        
        if cache == nil {
            return deleteCache()
        }
        
        do {
            let data = try JSONEncoder().encode(cache!)
            try data.write(to: localURL)
        } catch {
            
            insertCompletion?(error)
        }
        
        insertCompletion?(nil)
    }
    
    private func getCache() -> Cache? {
        
        do {
            let data = try Data(contentsOf: localURL)
            let cache = try JSONDecoder().decode(Cache.self, from: data)
            retrieveCompletion?(.found(feed: cache.value.local, timestamp: cache.timestamp))
            
            return cache
        } catch {
            retrieveCompletion?(.empty)
            return nil
        }
    }
    
    private func deleteCache() {
        
        do {
            try FileManager.default.removeItem(at: localURL)
        } catch {
            print(error)
        }
        
        deleteCompletion?(nil)
    }
}


// MARK: - FeedStore

extension FileSystemFeedStore: FeedStore {
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        
        deleteCompletion = completion
        cache = nil
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        
        insertCompletion = completion
        cache = CodableCache(timestamp: timestamp, value: feed.codable)
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        
        retrieveCompletion = completion
        _ = cache
    }
}
