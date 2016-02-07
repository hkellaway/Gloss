![Gloss](http://hkellaway.github.io/Gloss/images/gloss_logo_tagline.png)

## Features :sparkles:  
[![CocoaPods](https://img.shields.io/cocoapods/v/Gloss.svg)](http://cocoapods.org/pods/Gloss) 
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) 
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![License](https://img.shields.io/cocoapods/l/Gloss.svg)](https://raw.githubusercontent.com/hkellaway/Gloss/master/LICENSE) 
[![CocoaPods](https://img.shields.io/cocoapods/p/Gloss.svg)](http://cocoapods.org/pods/Gloss) 
[![Build Status](https://travis-ci.org/hkellaway/Gloss.svg)](https://travis-ci.org/hkellaway/Gloss)

* Mapping JSON to objects
* Mapping objects to JSON
* Nested objects
* Custom transformations

## Getting Started

- [Download Gloss](https://github.com/hkellaway/Gloss/archive/master.zip) and do a `pod install` on the included `GlossExample` app to see Gloss in action
- Check out the [documentation](http://cocoadocs.org/docsets/Gloss/) for a more comprehensive look at the classes available in Gloss

### Installation with Cocoapods

```ruby
pod 'Gloss', '~> 0.7'
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
        .Package(url: "https://github.com/hkellaway/Gloss.git", majorVersion: 0)
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
        guard let ownerId: Int = "id" <~~ json
            else { return nil }

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

(Note: If nested models are present in JSON but not desired in your Gloss models, see [Retrieving Nested Model Values without Creating Extra Models](#retrieving-nested-model-values-without-creating-extra-models).)

#### Model Arrays

See [Model Objects from JSON Arrays](#model-objects-from-json-arrays) for how to create arrays of models from JSON arrays.

### Serialization

Next, how would we allow models to be translated _to_ JSON? Let's take a look again at the `RepoOwner` struct:

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

See [On Not Using Gloss Operators](#on-not-using-gloss-operators) for how to express this model without the custom `~~>` operator.


### Initializing Model Objects

Instances of `Decodable` Gloss models are made by calling `init(json:)`.

For example, we can create a `RepoOwner` as follows:

``` swift
let repoOwnerJSON = [
        "id" : 5456481,
        "name": "hkellaway"
]

guard let repoOwner = RepoOwner(json: repoJSON)
    else { /* handle nil object here */ }

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

Gloss also supports creating models from JSON arrays. The `modelsFromJSONArray(_:)` function can be called on any Gloss model class to produce an array of objects from a JSON array passed in.

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
guard let repoOwners: [RepoOwner] = RepoOwner.modelsFromJSONArray(repoOwnersJSON)
    else { /* handle nil array here */ }

print(repoOwners)
```

### Translating Model Objects to JSON

The JSON representation of an `Encodable` Gloss model is retrieved via `toJSON()`:

``` swift
repoOwner.toJSON()

```
An array of JSON from an array of models is retrieved via `toJSONArray(_:)`:

``` swift
Repo.toJSONArray(repoOwners)
```

### Retrieving Nested Model Values without Creating Extra Models

We saw in earlier examples that `Repo` has a nested model `RepoOwner` - and that nested Gloss models are handled automatically. But what if the nested models represented in our JSON really don't need to be their own models? Gloss provides a way to indicate nested model values with simple `.` syntax - let's revisit the `owner` property on `Repo` and see what changes:

``` swift
struct Repo: Glossy {

    let ownerId: Int?
    let ownerUsername: String?

    // MARK: - Deserialization

    init?(json: JSON) {
        self.ownerId = "owner.id" <~~ json
        self.ownerUsername = "owner.login" <~~ json
    }

    // MARK: - Serialization

        func toJSON() -> JSON? {
        return jsonify([
            "owner.id" ~~> self.ownerId,
            "owner.login" ~~> self.ownerUsername
            ])

}

```

## Additional Topics

Now, instead of declaring a nested model `owner` of type `RepoOwner` with its own `id` and `username` properties, the desired values from `owner` are retrieved by specifying the key names in a string delimited by periods (i.e. `owner.id` and `owner.login`).

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

* Simple types (`Decoder.decode`)
* `Decodable` models (`Decoder.decodeDecodable`)
* Simple arrays (`Decoder.decode`)
* Arrays of `Decodable` models (`Decoder.decodeDecodableArray`)
* Dictionaries of `Decodable` models (`Decoder.decodeDecodableDictionary`)
* Enum types (`Decoder.decodeEnum`)
* Enum arrays (`Decoder.decodeEnumArray`)
* `NSURL` types (`Decoder.decodeURL`)
* `NSURL` arrays (`Decode.decodeURLArray`)

##### The Encode Operator: `~~>`

The `~~>` operator is simply syntactic sugar for a set of `Encoder.encode` functions:

* Simple types (`Encoder.encode`)
* `Encodable` models (`Encoder.encodeEncodable`)
* Simple arrays (`Encoder.encodeArray`)
* Arrays of `Encodable` models (`Encoder.encodeEncodableArray`)
* Dictionaries of `Encodable` models (`Encoder.encodeEncodableDictionary`)
* Enum types (`Encoder.encodeEnum`)
* Enum arrays (`Encoder.encodeEnumArray`)
* `NSURL` types (`Encoder.encodeURL`)

### Gloss Transformations

Gloss comes with a number of transformations built in for convenience (See: [Gloss Operators](#gloss-operators)).

#### Transforming Dates

One set of handy transformations not covered by the Gloss operators is `NSDate` transformations, as they require an additional `dateFormatter` parameter. Translating from and to JSON is handled via:

`Decoder.decodeDate(key:, dateFormatter:)` and `Decode.decodeDateArray(key:, dateFormatter:)` where `key` is the JSON key and `dateFormatter` is the `NSDateFormatter` used to translate the date(s).

`Encoder.encodeDate(key:, dateFormatter:)` and `Encode.encodeDate(key:, dateFormatter:)` where `key` is the JSON key and `dateFormatter` is the `NSDateFormatter` used to translate the date(s).

See [On Not Using Gloss Operators](#on-not-using-gloss-operators) for how the `Decoder.decode`/`Encoder.encode` syntax is used in place of `<~~`/`~~>`.

### Custom Transformations

#### From JSON

You can write your own functions to enact custom transformations during model creation.

Let's imagine the `username` property on our `RepoOwner` model was to be an uppercase string. We would update as follows:

``` swift
import Gloss

struct RepoOwner: Decodable {

    let ownerId: Int?
    let username: String?

    // MARK: - Deserialization

    init?(json: JSON) {
        self.ownerId = "id" <~~ json
        self.username = Decoder.decodeStringUppercase("login")(json)
    }

}

extension Decoder {

    static func decodeStringUppercase(key: String) -> JSON -> String? {
        return {
            json in

            if let string = json[key] as? String {
                return string.uppercaseString
            }

            return nil
        }
    }

}
```

We've created an extension on `Decoder` and written our own decode function, `decodeStringUppercase`.

What's important to note is that the return type for `decodeStringUppercase` is a function that translates from `JSON` to the desired type -- in this case, `JSON -> String?`. The value you're working with will be accessible via `json[key]` and will need to be cast to the desired type using `as?`. Then, manipulation can be done - for example, uppercasing. The transformed value should be returned; in the case that the cast failed, `nil` should be returned.

Though depicted here as being in the same file, good practice might have the `Decoder` extension in a separate file for organizational purposes.


#### To JSON

You can also write your own functions to enact custom transformations during JSON translation.

Let's imagine the `username` property on our `RepoOwner` model was to be a lowercase string. We would update as follows:

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
            Encoder.encodeStringLowercase("login")(self.username)
        ])
    }


}

extension Encoder {

    static func encodeStringLowercase(key: String) -> String? -> JSON? {
        return {
            string in

            if let string = string {
                return [key : string.lowercaseString]
            }

            return nil
        }
    }

}
```

We've created an extension on `Encoder` and written our own encode function, `encodeStringLowercase`.

What's important to note is that the return type for `encodeStringLowercase` is a function that translates from the property's type to `JSON?` -- in this case, `String? -> JSON?`. The value you're working with will be accessible via the `if let` statement. Then, manipulation can be done - for example, lowercasing. What should be returned is a dictionary with `key` as the key and the manipulated value as its value. In the case that the `if let` failed, `nil` should be returned.

Though depicted here as being in the same file, good practice might have the `Encoder` extension in a separate file for organizational purposes.

### Gloss Protocols

Models that are to be created from JSON _must_ adopt the `Decodable` protocol.

Models that are to be transformed to JSON _must_ adopt the `Encodable` protocol.

The `Glossy` protocol depicted in the examples is simply a convenience for defining models that can translated to _and_ from JSON. `Glossy` can be replaced by `Decodable, Encodable` for more preciseness, if desired.

## Why "Gloss"?

The name for Gloss was inspired by the name for a popular Objective-C library, [Mantle](https://github.com/Mantle/Mantle) - both names are a play on the word "layer", in reference to their role in defining the model layer of the application.

The particular word "gloss" was chosen as it evokes both being lightweight and adding beauty.

## Credits

Gloss was created by [Harlan Kellaway](http://harlankellaway.com).

Inspiration was gathered from other great JSON parsing libraries like [Argo](https://github.com/thoughtbot/Argo). Read more about why Gloss was made [here](http://harlankellaway.com/blog/2015/08/16/introducing-gloss-json-parsing-swift/).

Special thanks to all [contributors](https://github.com/hkellaway/Gloss/contributors)! :sparkling_heart:

### Featured

Check out Gloss in these cool places:

* [Ray Wenderlich | Swift Tutorial: Working with JSON](http://www.raywenderlich.com/120442/swift-json-tutorial)
* [The iOS Times](http://theiostimes.com/year-01-issue-12.html)
* [Swift Sandbox](http://swiftsandbox.io/issues/3#b1RJwo2)
* [iOS Goodies](http://ios-goodies.com/post/127166753231/week-93)
* [awesome-ios](https://github.com/vsouza/awesome-ios#json)
* [awesome-swift](https://github.com/matteocrippa/awesome-swift#json)
* [Reactofire library](https://github.com/RahulKatariya/Reactofire)

Using Gloss in your app? [Let me know.](mailto:hello@harlankellaway.com?subject=Using Gloss in my app)

## License

Gloss is available under the MIT license. See the [LICENSE](https://raw.githubusercontent.com/hkellaway/Gloss/master/LICENSE) file for more info.
