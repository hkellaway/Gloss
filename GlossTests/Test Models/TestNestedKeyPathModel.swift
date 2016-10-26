//
//  TestNestedKeyPathModel.swift
//  Gloss
//
//  Created by Maciej Kołek on 10/18/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Foundation
import Gloss

struct TestNestedKeyPathModel: Glossy {
    
    let keyPathModel: TestKeyPathModel?
    let flag: Bool
    
    init?(json: JSON) {
        self.keyPathModel = "keyPath" <~~ json
        self.flag = "keyPath.args.flag" <~~ json ?? false
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "keyPath" ~~> self.keyPathModel,
            "keyPath.args.flag" ~~> self.flag
            ])
    }
    
}
