![Gloss](http://hkellaway.github.io/Gloss/images/gloss_logo_tagline.png)

## :rotating_light: Deprecation Notice :rotating_light:

Gloss has been deprecated in favor of Swift's [Codable](https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types) framework.

The existing Gloss source is not going away, however updates will only be made to support migration to Codable. Read the [MIGRATION GUIDE](GLOSS_CODABLE_MIGRATION_GUIDE.md) now to get started.

*If you do not yet have any Gloss models in your project* yet are considering it for JSON parsing, turn around now! Select Swift's Codable framework instead.

## I understand, I'm Using Gloss Anyway

![Swift version](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![CocoaPods](https://img.shields.io/cocoapods/v/Gloss.svg)](http://cocoapods.org/pods/Gloss) 
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage) 
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager) 
[![CocoaPods](https://img.shields.io/cocoapods/p/Gloss.svg)](http://cocoapods.org/pods/Gloss)
[![Build Status](https://travis-ci.org/hkellaway/Gloss.svg?branch=production)](https://travis-ci.org/hkellaway/Gloss)

See the [former README.md](README_ARCHIVE.md) on instructions for using Gloss pre-Codable migration.

### Credits

Gloss was created by [Harlan Kellaway](http://hkellaway.github.io) 

Thank you to all [contributors](https://github.com/hkellaway/Gloss/contributors) and the Swift community for 5 years of Gloss! :sparkling_heart:

### License [![License](https://img.shields.io/cocoapods/l/Gloss.svg)](https://raw.githubusercontent.com/hkellaway/Gloss/production/LICENSE)

See the [LICENSE](https://raw.githubusercontent.com/hkellaway/Gloss/production/LICENSE) file for more info.

## Codable Migration Quick Reference

The following is a reference for what your Gloss models and call-sites should look like after preparing to migrate to Codable.

See the [MIGRATION GUIDE](GLOSS_CODABLE_MIGRATION_GUIDE.md) for more detail.

### Version

Use version `3.2.0` or higher to take advantage of migration helpers.

### Deserialization

Given a Gloss model that conforms to `JSONDecodable`, add conformance to `Decodable`. A model that looks like this:

``` swift
import Gloss

struct MyModel: JSONDecodable {
    let id: Int?
    
    init?(json: JSON) {
        self.id = "id" <~~ json
    }
}
```

adds

``` swift
extension MyModel: Decodable {

    init(from decoder: Swift.Decoder) throws {
        // Proper Decodable definition or throw GlossError.decodableMigrationUnimplemented
        // Remove this method if Codable can synthesize decoding for you
    }

}
```

### Initializing a Model from JSON

Where initializing that model currently looks like:

``` swift
let myModel = MyModel(json: someJSON)
```

it becomes:

``` swift
let myModel: MyModel = .from(decodableJSON: someJSON)
```

### Serialization

Given a Gloss model that conforms to `JSONEncodable`, add conformance to `Encodable`. A model that looks like this:

``` swift
import Gloss

struct MyModel: JSONEncodable {
    let id: Int?
    
    func toJSON() -> JSON? {
        return jsonify(["id" ~~> self.id])
    }
}
```

adds

``` swift
extension MyModel: Encodable {

    func encode(to encoder: Swift.Encoder) throws {
        // Proper Encodable defintion or throw GlossError.encodableMigrationUnimplemented
        // Remove this method if Codable can synthesize encoding for you
    }

}
```

### Translating Model Objects to JSON

Where translating to JSON currently looks like this:


``` swift
let json: JSON? = myModel.toJSON()
```
it becomes:

``` swift
let json: JSON? = myModel.toEncodableJSON()
```

### JSON Arrays

Similar usage applies to arrays of `Decodable` and `Encodable` models, with `from(decodableJSONArray:)` and `toEncodableJSONArray()` respectively.

### Configuring `JSONDecoder` and `JSONEncoder`

If your Codable definitions are sound but you're encountering Codable errors, make sure your `JSONDecoder` or `JSONEncoder` instances are configured properly and pass them at call-sites:

``` swift
let mySharedJSONDecoder: JSONDecoder = ...
let myModel: MyModel = .from(decodableJSON: someJSON, jsonDecoder: mySharedJSONDecoder)
```

``` swift
let mySharedJSONEncoder: JSONEncoder = ...
let json: JSON? = myModel.toEncodableJSON(jsonEncoder: mySharedJSONEncoder)
```

### Using `Data` Instead of `JSON` to Create Models

In the places where you've come to rely on Gloss's `JSON` type, you'll eventually need to pass `Data`, as that is what Codable uses. To get a jump using `decode(:)`, one option is use the same method Gloss uses to do `Data` transformation:


``` swift
import Gloss

let sharedGlossSerializer: GlossJSONSErializer = ...
let json: JSON = ...
if let data: Data? = sharedGlossSerializer.data(from: json, options: nil) {
    let myModel: MyModel = try? myJSONDecoder.decode(MyModel.self, from : data)
    ...
}
```

Take the opportunity with this migration to pare your models down to the slim amount of code Codable needs to work its magic and detangle your networking code from the details of JSON serialization. Future you will be grateful! :crystal_ball:

:sparkles::sparkles::sparkles:`EOF`:sparkles::sparkles::sparkles:

