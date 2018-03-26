//
// Created by yamazhiki on 14/03/2018.
// Copyright (c) 2018 斌王. All rights reserved.
//

import Foundation

protocol CacheType {
}

struct MemoryCache {

    private let cache = NSCache<NSString, AnyObject>()

    init() {
        cache.evictsObjectsWithDiscardedContent = true
    }

    public subscript(key: String) -> Any? {
        get {
            return self.cache.object(forKey: key as NSString)
        }
        set {
            if let newValue = newValue {
                self.cache.setObject(newValue as AnyObject, forKey: key as NSString)
            } else {
                self.cache.removeObject(forKey: key as NSString)
            }
        }
    }

    func clear() {
        cache.removeAllObjects()
    }
}

extension MemoryCache {

}
