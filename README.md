![Gloss](http://hkellaway.github.io/Gloss/images/gloss_logo_tagline.png)

## Features :sparkles: ![Swift](https://img.shields.io/badge/language-swift-orange.svg) [![CocoaPods](https://img.shields.io/cocoapods/v/Gloss.svg)](http://cocoapods.org/pods/Gloss) [![License](https://img.shields.io/cocoapods/l/Gloss.svg)](https://raw.githubusercontent.com/hkellaway/Gloss/master/LICENSE) [![CocoaPods](https://img.shields.io/cocoapods/p/Gloss.svg)](http://cocoapods.org/pods/Gloss)

* Mapping JSON to objects
* Mapping objects to JSON
* Nested objects
* Custom transformations

## Installation 

### Cocoapods


```ruby
pod 'Gloss', '~> 0.4'
```

#### Swift 2 and Swift 1.2

Gloss was written for use with Swift 2. If you are a Swift 1.2 user, you can install the version found on the `swift_1.2` branch using 

`pod 'Gloss', :git => 'https://github.com/hkellaway/Gloss.git', :branch => 'swift_1.2'`.

Note: The `swift_1.2` branch will not include improvements made using features specific to Swift 2.


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
    
    init(json: JSON) {
        self.ownerId = "id" <~~ json
        self.username = "login" <~~ json
    }
    
}
```

This model:

* Imports `Gloss`
* Adopts the `Decodable` protocol
* Implements the `init(json:)` initializer

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

    // MARK: - Deserializaiton
    
    init(json: JSON) {
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

See [On Not Using Gloss Operators](#on-not-using-gloss-operators) for how to express these models without the custom `<~~` operator.


### Serialization

Next, how would we allow models to be translated _to_ JSON? Let's take a look again at the `RepoOwner` class:

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
 

## Initializing Model Objects

Instances of Gloss models are made by calling `init(json:)`.

For example, we can create a `RepoOwner` as follows:

``` swift
let repoOwnerJSON = [
	"id" : 5456481,
	"name": "hkellaway"
]

let repoOwner = RepoOwner.init(json: repoOwnerJSON)

```

## Translating Model Objects to JSON

The JSON representation of an object is retrieved as such:

```swift
repoOwner.toJSON()

```
Note: This requires implementing the `toJSON()` function (see: [Serialization](#serialization)).


## Additional Topics

### Models with Non-Optional Properties

Examples thus far have depicted models with only Optional properties - i.e. all properties end with a `?`. This means that these properties should be handled as if they could be `nil`. If you are certain that there are properties in your JSON will _never_ be unavailable, you can represent these properties as non-Optionals.

Let's image we know that retrieving the values for our `RepOwner` model will never fail. We would represent the model as follows:

``` swift
import Gloss

struct RepoOwner: Decodable {
    
    let ownerId: Int
    let username: String
    
    // MARK: - Deserialization
    
    init(json: JSON) {
        self.ownerId = "id" <~~! json
        self.username = "login" <~~! json
    }
  
```

This model has changed in two ways:

* The properties are no longer Optionals
* The `<~~!` operator is used in place of the `<~~` operator

### Gloss Operators

#### On Not Using Gloss Operators

Gloss offers custom operators as a way to make your models less visually cluttered. However, some choose not to use custom operators for good reason - custom operators do not always clearly communicate what they are doing (See [this discussion](http://programmers.stackexchange.com/questions/180948/why-arent-user-defined-operators-more-common)). 

If you wish to not use the `<~~`, `<~~!`, or `~~>` operators, their `Decoder.decode`, `Decoder.forceDecode`, and `Encoder.encode` complements can be used instead. 

For example,

`self.url = "html_url" <~~ json` would become `self.url = Decoder.decodeURL("html_url")(json)`

and

`self.url = "html_url" <~~! json` would become `self.url = Decoder.forceDecodeURL("html_url")(json)`

and

`"html_url" ~~> self.url` would become `Encoder.encode("html_url")(self.url)`

#### On Using Gloss Operators

##### The Decode Operator: `<~~`

The `<~~` operator is simply syntactic sugar for a set of `Decoder.decode` functions:

* Simple types (`Decoder.decode`)
* `Decodable` models (`Decoder.decode`)
* Simple arrays (`Decoder.decode`)
* Arrays of `Decodable` models (`Decoder.decodeArray`)
* Enum types (`Decoder.decodeEnum`)
* Enum arrays (`Decoder.decodeArray`)
* `NSURL` types (`Decoder.decodeURL`)

##### The Force Decode Operator: `<~~!`

The `<~~!` operator is syntactic sugar for the force unwrapped version of `<~~`. See [Models with Non-Optional Properties](#models-with-non-optional-properties) for when this operator is best used.

Its function complements are same, except with `force` before the function name. For example, whereas `<~~` would use `Decoder.decodeURL`, `<~~!` would use `Decoder.forceDecodeURL`.

##### The Encode Operator: `~~>`

The `~~>` operator is simply syntactic sugar for a set of `Encoder.encode` functions:

* Simple types (`Encoder.encode`)
* `Encodable` models (`Encoder.encode`)
* Simple arrays (`Encoder.encode`)
* Arrays of `Encodable` models (`Encoder.encodeArray`)
* Enum types (`Encoder.encodeEnum`)
* Enum arrays (`Encoder.encodeArray`)
* `NSURL` types (`Encoder.encodeURL`)

### Gloss Transformations

Gloss comes with a number of transformations built in for convenience. (See: [Gloss Operators](#gloss-operators)).

#### Transforming Dates

One set of handy transformations not covered by the Gloss operators is `NSDate` transformations, as they require an additional `dateFormatter` parameter. Translating from and to JSON is handled via:

`Decoder.decodeDate(key:, dateFormatter:)` where `key` is the JSON key and `dateFormatter` is the `NSDateFormatter` used to translate the date.

`Decoder.forceDecodeDate(key:, dateFormatter:)` where `key` is the JSON key and `dateFormatter` is the `NSDateFormatter` used to translate the date.

`Encoder.encodeDate(key:, dateFormatter:)` where `key` is the JSON key and `dateFormatter` is the `NSDateFormatter` used to translate the date.

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
    
    static func fromJSON(json: JSON) -> RepoOwner {
        return RepoOwner(
            ownerId: "id" <~~ json,
            username: Decoder.decodeStringUppercase("login")(json)
        )
    }
    
}

extension Decoder {
    
    static func decodeStringUppercase(key: String) -> JSON -> String? {
        return {
            json in
            
            if let str = json[key] as? String {
                return str.uppercaseString
            }
            
            return nil
        }
    }
    
}
```

We've created an extension on `Decoder` and written our own decode function, `decodeStringUppercase`. 

What's important to note is that the return type for `decodeStringUppercase` is a function that translates from `JSON` to the desired type -- in this case, `JSON -> String?`. The value you're working with will be accessible via `json[key]` and will need to be cast to the desired type using `as?`. Then, manipulation can be done - for example, uppercasing. The transformed value should be returned; in the case that the cast failed, `nil` should be returned.

Though depicted here as being in the same file, good practice would have the `Decoder` extension in a separate `Decoder.swift` file for organizational purposes.


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

Though depicted here as being in the same file, good practice would have the `Encoder` extension in a separate `Encoder.swift` file for organizational purposes.

### Gloss Protocols

Models that are to be created from JSON _must_ adopt the `Decodable` protocol.

Models that are to be transofmed to JSON _must_ adopt the `Encodable` protocol.

The `Glossy` protocol depicted in the examples is simply a convenience for defining models that can translated to _and_ from JSON. `Glossy` can be replaced by `Decodable, Encodable` for more preciseness, if desired.

## Why "Gloss"?

The name for Gloss was inspired by the name for a popular Objective-C library, [Mantle](https://github.com/Mantle/Mantle) - both names are a play on the word "layer", in reference to their role in defining the model layer of the application. 

The particular word "gloss" was chosen as it evokes both being lightweight and adding beauty.

## Credits

Gloss was created by [Harlan Kellaway](http://harlankellaway.com).

 Inspiration was gathered from other great JSON parsing libraries like [Argo](https://github.com/thoughtbot/Argo). Read more about why Gloss was made [here](http://harlankellaway.com/blog/2015/08/16/introducing-gloss-json-parsing-swift/).

## License

Gloss is available under the MIT license. See the [LICENSE](https://raw.githubusercontent.com/hkellaway/Gloss/master/LICENSE) file for more info.
