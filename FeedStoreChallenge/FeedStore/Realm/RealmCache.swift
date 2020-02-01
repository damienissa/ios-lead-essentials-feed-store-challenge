//
//  RealmCache.swift
//  FeedStoreChallenge
//
//  Created by Dima Virych on 01.02.2020.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCache: Object {
    
    @objc dynamic var id = 0
    
    @objc dynamic var timestamp: Date = .init()
    let values = List<RealmRepresentationOfLocalFeedImage>()
    
    convenience init(_ images: [LocalFeedImage], timestamp: Date) {
        self.init()
        
        self.timestamp = timestamp
        values.append(objectsIn: images.map(RealmRepresentationOfLocalFeedImage.init))
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
}

class RealmRepresentationOfLocalFeedImage: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var objDescription: String? = nil
    @objc dynamic var location: String? = nil
    @objc dynamic var url: String = ""
    
    convenience init(_ image: LocalFeedImage) {
        self.init()
        
        self.id = image.id.uuidString
        self.objDescription = image.description
        self.location = image.location
        self.url = image.url.absoluteString
    }
    
    var local: LocalFeedImage {
        LocalFeedImage(self)
    }
}

fileprivate extension LocalFeedImage {
    
    init(_ object: RealmRepresentationOfLocalFeedImage) {
        
        self.id = UUID(uuidString: object.id)!
        self.description = object.objDescription
        self.location = object.location
        self.url = URL(string: object.url)!
    }
}
