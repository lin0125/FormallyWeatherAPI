//
//  Encodable+Extension.swift
//  FormallyAPI
//
//  Created by imac-2437 on 2023/8/21.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        
        guard let dictionary = try JSONSerialization.jsonObject(with: data,
                                                                options: .allowFragments) as? [String: Any] else {
            throw NSError()
            
        }
        return dictionary
    }
}
