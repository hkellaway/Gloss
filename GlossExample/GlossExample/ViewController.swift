//
//  ViewController.swift
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

class Repo : Gloss {
    
    var repoId: Int?
    var name: String?
    var desc: String?
    var url: NSURL?
    var owner: RepoOwner?
    var array: [ [String : String] ]?
    var primaryLanguage: Language?
    var dateCreated: NSDate?
    var uppercaseName: String?
    var uppercaseDesc: String?
    
    enum Language: String {
        case Swift = "Swift"
        case ObjectiveC = "Objective-C"
    }
    
    // MARK: - Deserialization
    
    override func decoders() -> [JSON -> ()] {
        return [
            { self.repoId = decode("id")($0) },
            { self.name = decode("name")($0)},
            { self.desc = decode("description")($0) },
            { self.url = Decoder.decodeURL("url")($0) },
            { self.owner = decode("owner")($0) },
            { self.array = Decoder.decodeArray("array")($0) },
            { self.primaryLanguage = Decoder.decodeEnum("language")($0) },
            { self.dateCreated = Decoder.decodeDate("created_at", dateFormatter:Repo.dateFormatter)($0) },
            { self.uppercaseName = self.decodeStringUpperCase("name")($0) },
            { self.uppercaseDesc = self.decodeStringUpperCase("description")($0) }
        ]
    }
    
    func decodeStringUpperCase(key: String) -> JSON -> String? {
        return {
            json in
            
            if let str = json[key] as? String {
                return str.uppercaseString
            }
            
            return nil
        }
    }
    
    // MARK - Serialization
    
    override func encoders() -> [JSON?] {
        return [
            encode("id")(self.repoId),
            encode("name")(self.name),
            encode("description")(self.desc),
            Encoder.encodeURL("url")(self.url),
            encode("owner")(self.owner),
            encode("array")(self.array),
            Encoder.encodeDate("created_at", dateFormatter: Repo.dateFormatter)(self.dateCreated)
        ]
    }
    
    static var dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        return dateFormatter
        }()
    
}

class RepoOwner: Gloss {
    
    var ownerId: Int?
    var username: String?
    
    // MARK: - Deserialization
    
    override func decoders() -> [JSON -> ()] {
        return [
            { self.ownerId = decode("id")($0) },
            { self.username = decode("login")($0) }
        ]
    }
    
    // MARK: - Serialization
    
    override func encoders() -> [JSON?] {
        return [
            encode("id")(self.ownerId),
            encode("login")(self.username)
        ]
    }
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repo = Repo(json: [
            "id" : 38541958,
            "name": "swift-json-comparison",
            "description" : "Comparison of Swift JSON libraries",
            "url" : "https://api.github.com/repos/hkellaway/swift-json-comparison",
            "owner" : [
                "id" : 5456481,
                "login" : "hkellaway"
            ],
            "array" : [ ["a" : "test1"], ["b" : "test2"] ],
            "language" : "Swift",
            "created_at" : "2015-07-04T17:28:37Z"
            ])
        
        print(repo.repoId, appendNewline: true)
        print(repo.name, appendNewline: true)
        print(repo.desc, appendNewline: true)
        print(repo.url, appendNewline: true)
        print(repo.owner, appendNewline: true)
        print(repo.array, appendNewline: true)
        print(repo.dateCreated, appendNewline: true)
        print(repo.primaryLanguage, appendNewline: true)
        print(repo.uppercaseName, appendNewline: true)
        print(repo.uppercaseDesc, appendNewline: true)
        print("", appendNewline: false)
        
        print("JSON: \(repo.toJSON())", appendNewline: false)
    }
}

