//
//  UDProperty.swift
//  FeedStoreChallenge
//
//  Created by Dima Virych on 01.02.2020.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation

@propertyWrapper
public struct UDProperty<Value: Codable> {
    
    private let defaults: UserDefaults
    
    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    public var wrappedValue: Value? {
        get { getValue() }
        set { set(newValue)}
    }
    
    private func getValue() -> Value? {
        
        guard let data = defaults.data(forKey: String(describing: Value.self)) else {
            return nil
        }
        
        return try? JSONDecoder().decode(Value.self, from: data)
    }
    
    private func set(_ value: Value?) {
        defaults.set(try? JSONEncoder().encode(value), forKey: String(describing: Value.self))
    }
}
