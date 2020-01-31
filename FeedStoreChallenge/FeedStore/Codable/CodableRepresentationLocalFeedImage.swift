//
//  CodableRepresentationLocalFeedImage.swift
//  FeedStoreChallenge
//
//  Created by Dima Virych on 31.01.2020.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation

struct CodableRepresentationLocalFeedImage: Codable {
    
    public let id: UUID
    public let description: String?
    public let location: String?
    public let url: URL
    
    init(_ image: LocalFeedImage) {
        
        self.id = image.id
        self.description = image.description
        self.location = image.location
        self.url = image.url
    }
    
    var image: LocalFeedImage {
        LocalFeedImage(id: id, description: description, location: location, url: url)
    }
}

// MARK: - Helper

extension Array where Element == LocalFeedImage {
    
    var codable: [CodableRepresentationLocalFeedImage] {
        map(CodableRepresentationLocalFeedImage.init)
    }
}

extension Array where Element == CodableRepresentationLocalFeedImage {
    
    var local: [LocalFeedImage] {
        map { $0.image }
    }
}
