//
//  FakeLogger.swift
//  Gloss
//
//  Created by Harlan Kellaway on 3/27/17.
//  Copyright © 2017 Harlan Kellaway. All rights reserved.
//

import Foundation

@testable import Gloss
class FakeLogger: Logger {

    var wasMessageLogged: Bool = false
    
    func log(message: String) {
        wasMessageLogged = true
    }
    
}
