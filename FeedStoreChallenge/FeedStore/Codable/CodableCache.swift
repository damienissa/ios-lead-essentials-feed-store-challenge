//
//  CodableCache.swift
//  FeedStoreChallenge
//
//  Created by Dima Virych on 31.01.2020.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation

struct CodableCache<Value: Codable>: Codable {
    
    let timestamp: Date
    let value: [Value]
}
