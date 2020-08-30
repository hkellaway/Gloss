//
//  TestKeyPathModel.swift
//  GlossExample
//
//  Created by Maciej Kołek on 10/18/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Foundation
import Gloss

struct TestKeyPathModel: Glossy {
    
    let id: Int?
    let name: String?
    let url: URL?
    
    init?(json: JSON) {
        self.id = "id" <~~ json
        self.name = "args.name" <~~ json
        self.url = "args.url" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> self.id,
            "args.name" ~~> self.name,
            "args.url" ~~> self.url
            ])
    }
    
}

// MARK: - Codable Migration

extension TestKeyPathModel: Decodable {
    
    init(from decoder: Swift.Decoder) throws {
        throw GlossError.decodableMigrationUnimplemented(context: "TestKeyPathModel")
    }
    
}

extension TestKeyPathModel: Encodable {
    
    func encode(to encoder: Swift.Encoder) throws {
        // Remove GlossError to see Codable error in console
        throw GlossError.encodableMigrationUnimplemented(context: "TestKeyPathModel")
    }
    
}
