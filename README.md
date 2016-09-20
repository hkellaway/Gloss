![Gloss](http://hkellaway.github.io/Gloss/images/gloss_logo_tagline.png)

## Features :sparkles:  
[![CocoaPods](https://img.shields.io/cocoapods/v/Gloss.svg)](http://cocoapods.org/pods/Gloss) 
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/Carthage/Carthage) 
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![License](https://img.shields.io/cocoapods/l/Gloss.svg)](https://raw.githubusercontent.com/hkellaway/Gloss/master/LICENSE) 
[![CocoaPods](https://img.shields.io/cocoapods/p/Gloss.svg)](http://cocoapods.org/pods/Gloss)
[![Reference Status](https://www.versioneye.com/objective-c/gloss/reference_badge.svg)](https://www.versioneye.com/objective-c/gloss/references)
[![Build Status](https://travis-ci.org/hkellaway/Gloss.svg?branch=develop)](https://travis-ci.org/hkellaway/Gloss)

* Mapping JSON to objects
* Mapping objects to JSON
* Nested objects
* Custom transformations

## Getting Started

- [Download Gloss](https://github.com/hkellaway/Gloss/archive/master.zip) and do a `pod install` on the included `GlossExample` app to see Gloss in action
- Check out the [documentation](http://cocoadocs.org/docsets/Gloss/) for a more comprehensive look at the classes available in Gloss

### Swift 2.x

Use the `swift_2.3` branch for a compatible version of Gloss plus Example project.

The Gloss source currently available via CocoaPods and Carthage is compatible with Swift 3.0.

### Deprecations

:warning: "Nested keypaths" have been deprecated as of version `0.8.0` ([Read more](#nested-keypaths-deprecation))

### Installation with CocoaPods

```ruby
pod 'Gloss', '~> 1.0'
```

### Installation with Carthage

```
github "hkellaway/Gloss"
```

### Installation with Swift Package Manager

To use Gloss as a [Swift Package Manager](https://swift.org/package-manager/) package just add the following in your Package.swift file.

``` swift
import PackageDescription

let package = Package(
    name: "HelloWorld",
    dependencies: [
        .Package(url: "https://github.com/hkellaway/Gloss.git", majorVersion: 1)
    ]
)
```

## Usage

### Deserialization

#### A Simple Model

Let's imagine we have a simple model represented by the following JSON:

``` JSON
{
  "id" : 5456481,
  "login" : "hkellaway"
}
```

Our Gloss model would look as such:

``` swift
import Gloss

struct RepoOwner: Decodable {

    let ownerId: Int?
    let username: String?

    // MARK: - Deserialization

    init?(json: JSON) {
        self.ownerId = "id" <~~ json
        self.username = "login" <~~ json
    }

}
```

This model:

* Imports `Gloss`
* Adopts the `Decodable` protocol
* Implements the `init?(json:)` initializer

(Note: If using custom operators like `<~~` is not desired, see [On Not Using Gloss Operators](#on-not-using-gloss-operators).)

#### A Simple Model with Non-Optional Properties

The prior example depicted the model with only Optional properties - i.e. all properties end with a `?`. If you are certain that the JSON being used to create your models will always have the values for your properties, you can represent those properties as non-Optional.

Non-Optional properties require additional use of the `guard` statement within `init?(json:)` to make sure the values are available at runtime. If values are unavailable, `nil` should be returned.

Let's imagine we know that the value for our `RepoOwner` property `ownerId` will always be available:

``` swift
import Gloss

struct RepoOwner: Decodable {

    let ownerId: Int
    let username: String?

    // MARK: - Deserialization

    init?(json: JSON) {
        guard let ownerId: Int = "id" <~~ json else { 
            return nil 
        }

        self.ownerId = ownerId
        self.username = "login" <~~ json
    }
}

```

This model has changed in two ways:

* The `ownerId` property is no longer an Optional
* The `init?(json:)` initializer now has a `guard` statement checking only non-Optional property(s)

#### A More Complex Model

Let's imagine we had a more complex model represented by the following JSON:

``` JSON
{
	"id" : 40102424,
	"name": "Gloss",
	"description" : "A shiny JSON parsing library in Swift",
	"html_url" : "https://github.com/hkellaway/Gloss",
	"owner" : {
		"id" : 5456481,
		"login" : "hkellaway"
	},
	"language" : "Swift"
}
```

This model is more complex for a couple reasons:

* Its properties are not just simple types
* It has a nested model, `owner`

Our Gloss model would look as such:

``` swift
import Gloss

struct Repo: Decodable {

    let repoId: Int?
    let name: String?
    let desc: String?
    let url: NSURL?
    let owner: RepoOwner?
    let primaryLanguage: Language?

    enum Language: String {
        case Swift = "Swift"
        case ObjectiveC = "Objective-C"
    }

    // MARK: - Deserialization

    init?(json: JSON) {
        self.repoId = "id" <~~ json
        self.name = "name" <~~ json
        self.desc = "description" <~~ json
        self.url = "html_url" <~~ json
        self.owner = "owner" <~~ json
        self.primaryLanguage = "language" <~~ json
    }

}
```

Despite being more complex, this model is just as simple to compose - common types such as an `NSURL`, an `enum` value, and another Gloss model, `RepoOwner`, are handled without extra overhead! :tada:

### Serialization

Next, how would we allow models to be translated _to_ JSON? Let's take a look again at the `RepoOwner` model:

``` swift
import Gloss

struct RepoOwner: Glossy {

    let ownerId: Int?
    let username: String?

    // MARK: - Deserialization
    // ...

    // MARK: - Serialization

    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> self.ownerId,
            "login" ~~> self.username
        ])
    }

}
```

This model now:

* Adopts the `Glossy` protocol
* Implements `toJSON()` which calls the `jsonify(_:)` function

(Note: If using custom operators like `~~>` is not desired, see [On Not Using Gloss Operators](#on-not-using-gloss-operators).)


### Initializing Model Objects and Arrays

Instances of `Decodable` Gloss models are made by calling `init?(json:)`.

For example, we can create a `RepoOwner` as follows:

``` swift
let repoOwnerJSON = [
        "id" : 5456481,
        "name": "hkellaway"
]

guard let repoOwner = RepoOwner(json: repoOwnerJSON) else { 
    // handle decoding failure here
}

print(repoOwner.repoId)
print(repoOwner.name)
```

Or, using `if let` syntax: 

``` swift
if let repoOwner = RepoOwner(json: repoOwnerJSON) {
    print(repoOwner.repoId)
    print(repoOwner.name)
}

```

#### Model Objects from JSON Arrays

Gloss also supports creating models from JSON arrays. The `from(jsonArray:)` function can be called on a Gloss model array type to produce an array of objects of that type from a JSON array passed in.

For example, let's consider the following array of JSON representing repo owners:

``` swift
let repoOwnersJSON = [
    [
        "id" : 5456481,
        "name": "hkellaway"
    ],
    [
        "id" : 1234567,
        "name": "user2"
    ]
]
```
An array of `RepoOwner` objects could be obtained via the following:

``` swift
guard let repoOwners = [RepoOwner].from(jsonArray: repoOwnersJSON) else {
    // handle decoding failure here
}

print(repoOwners)
```

### Translating Model Objects to JSON

The JSON representation of an `Encodable` Gloss model is retrieved via `toJSON()`:

``` swift
repoOwner.toJSON()

```
#### JSON Arrays from Model Objects

An array of JSON from an array of `Encodable` models is retrieved via `toJSONArray()`:

``` swift
guard let jsonArray = repoOwners.toJSONArray() else {
    // handle encoding failure here
}

print(jsonArray)
```

## Additonal Topics

### Gloss Transformations

Gloss comes with a number of transformations built in for convenience (See: [Gloss Operators](#gloss-operators)).

#### Date Transformations

`NSDate`s require an additional `dateFormatter` parameter, and thus cannot be retrieved via binary operators (`<~~` and `~~>`).

Translating from and to JSON is handled via:

`Decoder.decode(dateFromKey:, dateFormatter:)` and `Decode.decode(dateArrayFromKey:, dateFormatter:)` where `key` is the JSON key and `dateFormatter` is the `DateFormatter` used to translate the date(s). e.g. `self.date = Decoder.decode(dateFromKey: "dateKey", dateFormatter: myDateFormatter)(json)`

`Encoder.encode(dateFromKey:, dateFormatter:)` and `Encode.encode(dateFromKey:, dateFormatter:)` where `key` is the JSON key and `dateFormatter` is the `DateFormatter` used to translate the date(s). e.g. `Encoder.encode(dateFromKey: "dateKey", dateFormatter: myDateFormatter)(self.date)`

#### Custom Transformations

##### From JSON

You can write your own functions to enact custom transformations during model creation.

Let's imagine the `username` property on our `RepoOwner` model was to be an uppercase string. We could update as follows:

``` swift
import Gloss

struct RepoOwner: Decodable {

    let ownerId: Int?
    let username: String?

    // MARK: - Deserialization

    init?(json: JSON) {
        self.ownerId = "id" <~~ json
        self.username = Decoder.decodeStringUppercase(key: "login", json: json)
    }

}

extension Decoder {

    static func decodeStringUppercase(key: String, json: JSON) -> String? {
            
        if let string = json[key] as? String {
            return string.uppercaseString
        }

        return nil
    }

}
```

We've created an extension on `Decoder` and written our own decode function, `decodeStringUppercase`.

What's important to note is that the return type for `decodeStringUppercase` is the desired type -- in this case, `String?`. The value you're working with will be accessible via `json[key]` and will need to be cast to the desired type using `as?`. Then, manipulation can be done - for example, uppercasing. The transformed value should be returned; in the case that the cast failed, `nil` should be returned.

Though depicted here as being in the same file,  the `Decoder` extension is not required to be. Additionally, representing the custom decoding function as a member of `Decoder` is not required, but simply stays true to the semantics of Gloss.

##### To JSON

You can also write your own functions to enact custom transformations during JSON translation.

Let's imagine the `username` property on our `RepoOwner` model was to be a lowercase string. We could update as follows:

``` swift
import Gloss

struct RepoOwner: Glossy {

    let ownerId: Int?
    let username: String?

    // MARK: - Deserialization
    // ...

   // MARK: - Serialization

    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> self.ownerId,
            Encoder.encodeStringLowercase(key: "login", value: self.username)
        ])
    }


}

extension Encoder {

    static func encodeStringLowercase(key: String, value: String?) -> JSON? {
            
        if let value = value {
            return [key : value.lowercaseString as AnyObject]
        }

        return nil
    }

}
```

We've created an extension on `Encoder` and written our own encode function, `encodeStringLowercase`.

What's important to note is that `encodeStringLowercase` takes in a `value` whose type is what it's translating from (`String?`) and returns `JSON?`. The value you're working with will be accessible via the `if let` statement. Then, manipulation can be done - for example, lowercasing. What should be returned is a dictionary with `key` as the key and the manipulated value as its value. In the case that the `if let` failed, `nil` should be returned.

Though depicted here as being in the same file, the `Encoder` extension is not required to be. Additionally, representing the custom encoding function as a member of `Encoder` is not required, but simply stays true to the semantics of Gloss.

### Gloss Operators

#### On Not Using Gloss Operators

Gloss offers custom operators as a way to make your models less visually cluttered. However, some choose not to use custom operators for good reason - custom operators do not always clearly communicate what they are doing (See [this discussion](http://programmers.stackexchange.com/questions/180948/why-arent-user-defined-operators-more-common)).

If you wish to not use the `<~~` or `~~>` operators, their `Decoder.decode` and `Encoder.encode` complements can be used instead.

For example,

`self.url = "html_url" <~~ json` would become `self.url = Decoder.decodeURL("html_url")(json)`

and

`"html_url" ~~> self.url` would become `Encoder.encodeURL("html_url")(self.url)`

#### On Using Gloss Operators

##### The Decode Operator: `<~~`

The `<~~` operator is simply syntactic sugar for a set of `Decoder.decode` functions:

* Simple types (`Decoder.decode(key:)`)
* `Decodable` models (`Decoder.decode(decodableForKey:)`)
* Simple arrays (`Decoder.decode(key:)`)
* Arrays of `Decodable` models (`Decoder.decode(decodableArray:)`)
* Dictionaries of `Decodable` models (`Decoder.decode(decodableDictionary:)`)
* Enum types (`Decoder.decode(enum:)`)
* Enum arrays (`Decoder.decode(enumArray:)`)
* Int32 types (`Decoder.decode(int32:)`)
* Int32 arrays (`Decoder.decode(int32Array:)`)
* UInt32 types (`Decoder.decode(uint32:)`)
* UInt32 arrays (`Decoder.decode(uint32Array:)`)
* Int64 types (`Decoder.decode(int64:)`)
* Int64 array (`Decoder.decode(int64Array:)`)
* UInt64 types (`Decoder.decode(uint64:)`)
* UInt64 array (`Decoder.decode(uint64Array:)`)
* NSURL types (`Decoder.decode(url:)`)
* NSURL arrays (`Decode.decode(urlArray:)`)

##### The Encode Operator: `~~>`

The `~~>` operator is simply syntactic sugar for a set of `Encoder.encode` functions:

* Simple types (`Encoder.encode(key:)`)
* `Encodable` models (`Encoder.encode(encodable:)`)
* Simple arrays (`Encoder.encode(array:)`)
* Arrays of `Encodable` models (`Encoder.encode(encodableArray:)`)
* Dictionaries of `Encodable` models (`Encoder.encode(encodableDictionary:)`)
* Enum types (`Encoder.encode(enum:)`)
* Enum arrays (`Encoder.encode(enumArray:)`)
* Int32 types (`Encoder.encode(int32:)`)
* Int32 arrays (`Encoder.encode(int32Array:)`)
* UInt32 types (`Encoder.encode(uint32:)`)
* UInt32 arrays (`Encoder.encode(uint32Array:)`)
* Int64 types (`Encoder.encode(int64:)`)
* Int64 arrays (`Encoder.encode(int64Array:)`)
* UInt64 types (`Encoder.encode(uint64:)`)
* UInt64 arrays (`Encoder.encode(uint64Array:)`)
* NSURL types (`Encoder.encode(url:)`)

### Gloss Protocols

Models that are to be created from JSON _must_ adopt the `Decodable` protocol.

Models that are to be transformed to JSON _must_ adopt the `Encodable` protocol.

The `Glossy` protocol depicted in the examples is simply a convenience for defining models that can translated to _and_ from JSON. `Glossy` can be replaced by `Decodable, Encodable` for more preciseness, if desired.

## Deprecation Details

### Nested Keypaths Deprecation

This feature has been removed as of version `0.8.0`.

Version `0.7.0` introduced "nested keypaths" - this allowed values nested deep in a JSON structure to be accessed via a period-delimited key. For example, given a JSON structure:

```
[ "outer" : [
        "inner" : 123
    ]
]
```

the value of `123` could be accessed via the key `outer.inner`.

While this was a handy feature, it caused a runtime crash when using a Release configuration (see [Issue #135](https://github.com/hkellaway/Gloss/issues/135)).

For those using nested keypaths or those who have deeply nested values, these can be handled by creating nested models or creating [Custom Transformations](#custom-transformations). See the Example project for illustrations of each.

The tag `deprecation-nested-keypaths` marks the last merge that included nested keypaths and can be pointed to while models are updated.

## Why "Gloss"?

The name for Gloss was inspired by the name for a popular Objective-C library, [Mantle](https://github.com/Mantle/Mantle) - both names are a play on the word "layer", in reference to their role in supporting the model layer of the application.

The particular word "gloss" was chosen as it evokes both being lightweight and adding beauty.

## Credits

Gloss was created by [Harlan Kellaway](http://harlankellaway.com).

Inspiration was gathered from other great JSON parsing libraries like [Argo](https://github.com/thoughtbot/Argo). Read more about why Gloss was made [here](http://harlankellaway.com/blog/2015/08/16/introducing-gloss-json-parsing-swift).

Special thanks to all [contributors](https://github.com/hkellaway/Gloss/contributors)! :sparkling_heart:

### Featured

Check out Gloss in these cool places!

#### Posts

* [Ray Wenderlich | Swift Tutorial: Working with JSON](http://www.raywenderlich.com/120442/swift-json-tutorial)

#### Libraries

* [Alamofire-Gloss](https://github.com/spxrogers/Alamofire-Gloss)
* [CRUD](https://github.com/MetalheadSanya/CRUD)
* [Moya-Gloss](https://github.com/spxrogers/Moya-Gloss)
* [Restofire-Gloss](https://github.com/Restofire/Restofire-Gloss)

#### SDKs/Products

* [AniList](http://anilist.co) ([iOS SDK](https://github.com/CodeEagle/AniList))
* [Drift](http://www.drift.com) ([iOS SDK](https://github.com/Driftt/drift-sdk-ios))
* [Phillips Hue](http://www2.meethue.com/en-US) ([iOS SDK](https://github.com/Spriter/SwiftyHue))
* [Skiplagged](http://skiplagged.com) ([iOS SDK] (https://github.com/bulusoy/Skiplagged))

#### Apps

* [Ether Tracker](https://itunes.apple.com/us/app/ether-tracker/id1118248702?mt=8)

#### Tools

* [JSON Export](https://github.com/Ahmed-Ali/JSONExport) - generate Gloss models from JSON

#### Newsletters

* [The iOS Times](http://theiostimes.com/year-01-issue-12.html)
* [Swift Sandbox](http://swiftsandbox.io/issues/3#b1RJwo2)
* [iOS Goodies](http://ios-goodies.com/post/127166753231/week-93)

Using Gloss in your app? [Let me know.](mailto:hello@harlankellaway.com?subject=Using Gloss in my project)

## License

Gloss is available under the MIT license. See the [LICENSE](https://raw.githubusercontent.com/hkellaway/Gloss/master/LICENSE) file for more info.
