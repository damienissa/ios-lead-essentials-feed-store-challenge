//
//  RealmDecorator.swift
//  FeedStoreChallenge
//
//  Created by Dima Virych on 01.02.2020.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation

import RealmSwift

public typealias Realm = RealmSwift.Realm

public protocol RealmDecorator {
    
    typealias Object = RealmSwift.Object
    typealias Results<Element: Object> = RealmSwift.Results<Element>
    
    func write(_ block: (() throws -> Void)) throws
    func add(_ object: Object)
    func objects<Element: Object>(_ type: Element.Type) -> Results<Element>
    func delete<Element: Object>(_ objects: Results<Element>)
}

extension Realm: RealmDecorator {

    public func write(_ block: (() throws -> Void)) throws {
 
        try  write(withoutNotifying: [], block)
    }
    
    public func add(_ object: Object) {
        
        add(object, update: .all)
    }
}
