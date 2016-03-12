//
//  TestKeyPathModelCustomDelimiter.swift
//  GlossExample
//
//  Created by Harlan Kellaway on 2/7/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Foundation
import Gloss

struct TestKeyPathModelCustomDelimiter: Glossy {
    
    let id: Int?
    let url: NSURL?
    
    init?(json: JSON) {
        self.id = Decoder.decode("nested*id", keyPathDelimiter: "*")(json)
        self.url = Decoder.decodeURL("nested*url", keyPathDelimiter: "*")(json)
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "nested*id" ~~> self.id,
            "nested*url" ~~> self.url
            ], keyPathDelimiter: "*")
    }
    
}