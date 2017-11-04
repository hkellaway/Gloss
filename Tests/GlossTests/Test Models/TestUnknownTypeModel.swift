//
//  TestUnknownTypeModel.swift
//  Gloss
//
//  Created by Harlan Kellaway on 3/27/17.
//  Copyright © 2017 Harlan Kellaway. All rights reserved.
//

import Foundation
import Gloss

protocol UnknownType {
    
    var name: String { get }
    
}

struct TestUnknownTypeModel: Gloss.JSONDecodable {
    
    var value: UnknownType?
    
    init?(json: JSON) {
        self.value = "value" <~~ json
    }
    
}

// Since Swift Package Manager doesn't support fixtures (i.e. stored JSON), we have to access the JSON using this method rather than reading file from Bundle.
#if SWIFT_PACKAGE
    
extension TestUnknownTypeModel {
        
    static var testJSON: JSON {
        return ["value" : "abc"]
    }

}
#endif
