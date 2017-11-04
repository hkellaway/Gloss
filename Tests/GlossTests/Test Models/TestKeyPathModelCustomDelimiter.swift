//
//  TestKeyPathModelCustomDelimiter.swift
//  GlossExample
//
//  Created by Maciej Kołek on 10/18/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Foundation
import Gloss

struct TestKeyPathModelCustomDelimiter: Glossy {
    
    let id: Int?
    let url: URL?
    
    init?(json: JSON) {
        self.id = Decoder.decode(key: "nested*id", keyPathDelimiter: "*")(json)
        self.url = Decoder.decode(urlForKey: "nested*url", keyPathDelimiter: "*")(json)
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "nested*id" ~~> self.id,
            "nested*url" ~~> self.url
            ], keyPathDelimiter: "*")
    }
    
}
