//
//  GlossTests.swift
//  GlossExample
//
// Copyright (c) 2015 Harlan Kellaway
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Gloss
import UIKit
import XCTest

class GlossTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testJsonifyTurnsArrayOfJsonDictsToSingleJsonDict() {
        let jsonDict1: JSON? = ["a" : true, "b" : false]
        let jsonDict2: JSON? = ["d" : "e", "f" : "g"]
        let jsonDict3: JSON? = ["j" : 1, "k" : 2]
        
        let result = jsonify([jsonDict1, jsonDict2, jsonDict3])
        
        XCTAssertTrue((result!.count == 6), "jsonify should turn array of JSON dictionaries to a single JSON dictionary")
        XCTAssertTrue((result!["a"] as! Bool == true), "jsonify should turn array of JSON dictionaries to a single JSON dictionary")
        XCTAssertTrue((result!["b"] as! Bool == false), "jsonify should turn array of JSON dictionaries to a single JSON dictionary")
        XCTAssertTrue((result!["d"] as! String == "e"), "jsonify should turn array of JSON dictionaries to a single JSON dictionary")
        XCTAssertTrue((result!["f"] as! String == "g"), "jsonify should turn array of JSON dictionaries to a single JSON dictionary")
        XCTAssertTrue((result!["j"] as! Int == 1), "jsonify should turn array of JSON dictionaries to a single JSON dictionary")
        XCTAssertTrue((result!["k"] as! Int == 2), "jsonify should turn array of JSON dictionaries to a single JSON dictionary")
    }
    
}
