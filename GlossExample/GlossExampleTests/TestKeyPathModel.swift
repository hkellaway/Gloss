//
//  TestKeyPathModel.swift
//  GlossExample
//
//  Created by Rahul Katariya on 2/1/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Foundation
import Gloss

struct TestKeyPathModel: Glossy {
    
    let id: String?
    let name: String?
    let email: String?
    
    init?(json: JSON) {
        self.id = "id" <~~ json
        self.name = "args.name" <~~ json
        self.email = "args.email" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> self.id,
            "args.name" ~~> self.name,
            "args.email" ~~> self.email
            ])
    }
    
}
