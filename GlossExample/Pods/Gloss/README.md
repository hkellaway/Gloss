![Gloss](http://hkellaway.github.io/Gloss/images/gloss_logo_tagline.png)

## Features :sparkles:

* Mapping JSON to objects
* Mapping objects to JSON
* Nested objects
* Custom transformations

## Installation 

### Cocoapods


```ruby
pod 'Gloss', '~> 0.2'
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

class RepoOwner: Glossy {
    
    let ownerId: Int?
    let username: String?
    
    // MARK: - Deserialization
    
    required init(json: JSON) {
        self.ownerId = decode("id")(json)
        self.username = decode("login")(json)

        super.init(json: json)
    }
    
}
```

This model is characterized by:

* Importing `Gloss`
* Subclassing `Glossy`
* Implementing `init(json:)`

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

This model is more complex for a couple reasons

* Its properties are not just simple types
* It has a nested model, `owner`

Our Gloss model would look as such:

``` swift
import Gloss

class Repo : Glossy {
    
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
    
    required init(json: JSON) {
        self.repoId = decode("id")(json)
        self.name = decode("name")(json)
        self.desc = decode("description")(json)
        self.url = Decoder.decodeURL("html_url")(json)
        self.owner = decode("owner")(json)
        self.primaryLanguage = Decoder.decodeEnum("language")(json)

        super.init(json: json)
    }
    
}
```


### Serialization

How do we allow models to be translated to JSON? Let's take a look again at the `RepoOwner` class:

``` swift
import Gloss

class RepoOwner: Glossy {
    
    let ownerId: Int?
    let username: String?
    
    // MARK: - Deserialization
    // ...
    
    // MARK: - Serialization
    
    override func encoders() -> [JSON?] {
        return [
            encode("id")(self.ownerId),
            encode("login")(self.username)
        ]
    }
    
}
```

We've simply added an override of a function named `encoders`.


## Initializing Model Objects

Gloss models are initialized by passing JSON into the `init(json:)` initializer.

For example, we can create an object of the `RepoOwner` type as follows:

``` swift
let repoOwnerJSON = [
	"id" : 5456481,
	"name": "hkellaway"
]

let repoOwner = RepoOwner(json: repoOwnerJSON)

```

## Translating Model Objects to JSON

The JSON representation of an object is retrieved as such:

```swift
repoOwner.toJSON()

```
Note: This requires that the model overrides the `endcoders` function (see: [Serialization](#serialization)).


## Discussion

### Decoders

At the heart of deserialization with Gloss is the `init(json:)` initializer. It lists a series of "decoders" that take the format:

`self.propertyName = Decoder.decodeFunction(jsonKey)(json)`

where `propertyName` is one of the model's properties, `jsonKey` is the corresponding JSON key, and `Decoder.decodeFunction` is the function that handles the translation.

Note: The provided examples make use of `decode` instead of `Decoder.decode` - this is simply a shorthand for convenience, either can be used.

#### Gloss Decoders

Gloss handles decoding simple types via `decode`. Nested Gloss models are also decoded automatically - no extra work! :tada:

Gloss also comes with a number of built-in decoders for convenience:

* `decodeArray` - for simple `Array`s or `Array`s of Gloss models
* `decodeDate` - for `NSDate` types
* `decodeDateISO8601` - for `NSDate` types of the ISO8601 format
* `decodeEnum` - for enum types
* `decodeURL` - for `NSURL` types


### Encoders

At the heart of serialization with Gloss is the `encoders` function that returns an array of JSON.

Encoders take the format: 

`Encoder.encodeFunction(jsonKey)(self.propertyName)`

where `propertyName` is one of the model's properties, `jsonKey` is the corresponding JSON key, and `Encoder.encodeFunction` is the function that handles the translation.

Note: The provided examples use `encode` instead of `Encoder.encode` - this is simply a shorthand for convenience, either can be used.

#### Gloss Encoders

Gloss handles encoding simple types via `encode`. Nested Gloss models are also encoded automatically - no extra work! :confetti_ball:

Gloss also comes with a number of built-in encoders for convenience:

* `encodeDate` - for `NSDate` types
* `encodeDateISO8601` - for `NSDate` types with the ISO8601 format
* `encodeEnum` - for enum types
* `encodeURL` - for `NSURL` types


## Advanced Topics

### Custom Transformations

#### Custom Decoders

You can write your own decoders to enact custom transformations during model creation.

Let's imagine the `username` property on our `RepoOwner` model was to be an uppercase string. We would update as follows:

``` swift
import Gloss

class RepoOwner: Glossy {
    
    let ownerId: Int?
    let username: String?
    
    // MARK: - Deserialization
    
    required init(json: JSON) {
        self.ownerId = decode("id")(json)
        self.username = Decoder.decodeStringUppercase("login")(json)

        super.init(json: json)
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

What's important to note is that the return type for `decodeStringUppercase` is a function that translates from `JSON` to the desired type -- in this case, `JSON -> String?`. The value you're working with will be accessible via `json[key]` and will need to be cast to the desired type using `as?`. Then, manipulation can be done - for example, uppercasing. The transformed value should be returned; in the case that the cast failed, `nil` can be returned. 

Though depicted here as being in the same file, good practice would have the `Decoder` extension in a separate `Decoder.swift` file for organizational purposes.


#### Custom Encoders

You can also write your own encoders to enact custom transformations during JSON translation.

Let's imagine the `username` property on our `RepoOwner` model was to be a lowercase string. We would update as follows:

``` swift
import Gloss

class RepoOwner: Glossy {
    
    let ownerId: Int?
    let username: String?
    
   // ... 

   // MARK: - Serialization

    override func encoders() -> [JSON?] {
        return [
            encode("id")(self.ownerId),
            Encoder.encodeStringLowercase("login")(self.username)
        ]
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

What's important to note is that the return type for `encodeStringLowercase` is a function that translates from the property's type to `JSON` -- in this case, `String? -> JSON?`. The value you're working with will be accessible via the `if let` statement. Then, manipulation can be done - for example, lowercasing. What should be returned is a dictionary with `key` as the key and the manipulated value as its value. In the case that the `if let` failed, `nil` can be returned. 

Though depicted here as being in the same file, good practice would have the `Encoder` extension in a separate `Encoder.swift` file for organizational purposes.


## What's Next

- [x] Swift 1.2 compatibility on the `swift_1.2` branch
- [ ] Tests

## Why "Gloss"?

The name for Gloss was inspired by the name for a popular Objective-C library, [Mantle](https://github.com/Mantle/Mantle) - both names are a play on the word "layer", in reference to their role in defining the model layer of the application. 

The particular word "gloss" was chosen as it evokes both being lightweight and adding beauty.

## Credits

Gloss was created by [Harlan Kellaway](http://harlankellaway.com).

## License

Gloss is available under the MIT license. See the [LICENSE](https://raw.githubusercontent.com/hkellaway/Gloss/master/LICENSE) file for more info.
