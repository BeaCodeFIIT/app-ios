//
//  Queue.swift
//  BeaCodeApp
//
//  Created by Marek Bruchatý on 24/04/2017.
//  Copyright © 2017 Peter Augustín. All rights reserved.
//

import Foundation

public struct Queue<T> {
    private var array: [T]
    
    public init() {
        array = []
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func enqueue(element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    public func peek() -> T? {
        return array.first
    }
}
