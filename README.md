# Gloss

![Swift](https://img.shields.io/badge/language-swift-orange.svg)

A shiny JSON parsing library in Swift

## Features :sparkles:

* Mapping JSON to objects
* Mapping objects to JSON
* Nested Objects
* Custom transformations during mapping

## Communication

- If you **have found a bug**, _and can provide steps to reliably reproduce it_, [open an issue](https://github.com/hkellaway/Gloss/issues/new).
- If you **have a feature request**, [open an issue](https://github.com/hkellaway/Gloss/issues/new).
- If you **want to contribute**, [submit a pull request](https://github.com/hkellaway/Gloss/pulls). Pull request should be made against the _develop_ branch.

## Getting Started

- [Download Gloss](https://github.com/hkellaway/Gloss/archive/master.zip) and try out the included iOS example app
- Check out the [documentation](http://cocoadocs.org/docsets/Gloss/) for a more comprehensive look at the classes available in Gloss

### Swift 2 and Swift 1.2

Gloss was written for use with Swift 2. If you are a Swift 1.2 user, you can utilize the version found on the `swift_1.2` branch. Though, note, this branch may not include improvements made using features specific to Swift 2.

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Swift and Objective-C, which automates and simplifies the process of using 3rd-party libraries like Gloss in your projects. Cocoapods is the preferred way to incorporate Gloss in your project; if you are unfamiliar with how to install Cocoapods or how create a Podfile, there are many tutorials online.

#### Podfile

```ruby
pod "Gloss", "~> 0.1"
```

## Usage

### Deserialization

#### A Simple Model

Let's imagine we had a simple model represented by the following JSON:

``` JSON
{
  "owner" : {
          "id" : 5456481,
          "login" : "hkellaway"
	}
}
```

This model would be represented using Gloss as such:

``` swift
import Gloss

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
    
}
```

This model is characterized by:

* subclassing `Gloss`
* overriding the `decoders` function

#### A Complex Model

Let's imagine we had a more complex model represented by the following JSON:

``` JSON
{
	"id" : 40102424,
	"name": "Gloss",
	"description" : "A shiny JSON parsing library in Swift",
	"url" : "https://api.github.com/repos/hkellaway/Gloss",
	"owner" : [
		"id" : 5456481,
		"login" : "hkellaway"
	],
	"language" : "Swift",
	"created_at" : "2015-08-03T03:03:16Z"
}
```

This model is more complex with a couple reasons

* It's properties are not just simple types - we have an `NSURL`, and enum, and an `NSDate`
* It has a nested model, `owner`

``` swift
class Repo : Gloss {
    
    var repoId: Int?
    var name: String?
    var desc: String?
    var url: NSURL?
    var owner: RepoOwner?
    var primaryLanguage: Language?
    var dateCreated: NSDate?

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
            { self.primaryLanguage = Decoder.decodeEnum("language")($0) },
            { self.dateCreated = Decoder.decodeDate("created_at", dateFormatter:Repo.dateFormatter)($0) }
        ]
    }
    
    // MARK: - Helpers
    
    private static var dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        return dateFormatter
        }()
    
}
```

#### Decoders

At the heart of deserialization with Gloss is the `decoders()` functions.

Decoders take the format: 

`{ self.propertyName = Decoder.decodeFunction(jsonKey)($0) }`

where `propertyName` is one of the model's properties, `jsonKey` is the corresponding JSON key, and `Decoder.decodeFunction` is the function that handles the translation.

#### Gloss Decoders

Gloss automatically handles decoding simple types - as well as Gloss models :tada:

Additionally, Gloss comes with a number of built in decoders for convenience:

* `decodeDate` - for `NSDate`
* `decodeDateISO8601` - for `NSDate` with the ISO8601 format
* `decodeEnum` - for enums
* `decodeURL` - for `NSURL`

#### Custom Decoders


### Serialization

### Initializing Model Objects

We can simply create an object of the `RepoOwner` type as follows:

``` swift
let json = [
	"id" : 5456481,
	"name": "hkellaway"
]

let repoOwner = RepoOwner(json: json)

```

### Translating Model Objects to JSON

We can get the JSON representation of an object as such:

```swift
repoOwner.toJSON()
``` 


## TODO

- [x] Swift 1.2 compatibility on `swift_1.2` branch
- [ ] Tests

## Why Gloss?

The name for Gloss was inspired by the name for a popular Objective-C library, [Mantle](https://github.com/Mantle/Mantle) - both names are a play on the word "layer", in reference to their role in writing the model layer of the application. The particular word "gloss" was chosen as it evokes both being lightweight and adding beauty.

## Credits

Gloss was created by [Harlan Kellaway](http://harlankellaway.com).

## License

Gloss is available under the MIT license. See the [LICENSE](https://raw.githubusercontent.com/hkellaway/Gloss/master/LICENSE) file for more info.
