//
//  CodableCache.swift
//  FeedStoreChallenge
//
//  Created by Dima Virych on 31.01.2020.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation

public struct CodableCache<Value: Codable>: Codable {
    
    public let timestamp: Date
    public let value: [Value]
    
    public init(timestamp: Date, value: [Value]) {
        
        self.timestamp = timestamp
        self.value = value
    }
}
