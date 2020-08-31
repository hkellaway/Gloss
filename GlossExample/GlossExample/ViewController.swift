//
//  ViewController.swift
//  GlossExample
//
// Copyright (c) 2020 Harlan Kellaway
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

extension JSONDecoder {
    
    // GitHub API uses snake-case
    static func snakeCase() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
}

extension JSONEncoder {
    
    // GitHub API uses snake-case
    static func snakeCase() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repoJSON: JSON = [
            "id" : 40102424,
            "name": "Gloss",
            "description" : "A shiny JSON parsing library in Swift",
            "html_url" : "https://github.com/hkellaway/Gloss",
            "owner" : [
                "id" : 5456481,
                "login" : "hkellaway",
                "html_url" : "https://github.com/hkellaway"
            ],
            "language" : "Swift"
            ]
       
        let decodedRepo: Repo? = .from(decodableJSON: repoJSON,
                                       jsonDecoder: .snakeCase())
        guard let repo = decodedRepo else {
            print("DECODING FAILURE :(")
            return
        }
        
        print(repo.repoId)
        print(repo.name)
        print(repo.desc!)
        print(repo.urlString!)
        print(repo.owner)
        print(repo.primaryLanguage?.rawValue ?? "No language")
        print("")

        print("JSON: \(repo.toEncodableJSON(jsonEncoder: .snakeCase())!)")
        print("")

        guard let repos = [Repo].from(decodableJSONArray: [repoJSON, repoJSON, repoJSON],
                                      jsonDecoder: .snakeCase()) else {
            print("DECODING FAILURE :(")
            return
        }

        print("REPOS: \(repos)")
        print("")

        guard let jsonArray = repos.toEncodableJSONArray(jsonEncoder: .snakeCase()) else {
            print("ENCODING FAILURE :(")
            return
        }

        print("JSON ARRAY: \(jsonArray)")
        
        if let data = GlossJSONSerializer().data(from: repoJSON, options: nil) {
            do {
                let repo = try JSONDecoder.snakeCase().decode(Repo.self, from: data)
                print(repo.name)
            } catch {
                print(error.localizedDescription)
            }
        }

    }
}
