# Gloss → Codable Migration Guide

Adopters of Gloss are urged to migrate to Swift's first-class JSON parsing framwork, [Codable](https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types). Gloss is no longer maintainined as of September 2020, unless in support of Codable migration. For more context on this decision, see: [hkellaway.github.io/blog/2020/08/30/tale-of-third-parties](https://hkellaway.github.io/blog/2020/08/30/tale-of-third-parties)

## :rotating_light: Before Migration :rotating_light:

```
Upgrade Gloss to minimum version 3.2.0
```

Version `3.2.0` adds methods to help translate between Gloss and Codable models.

## Migration Summary

The following is a summary of steps to take when migrating any single model from using Gloss to using Codable.

### Comparable Terms

| Gloss  | Codable  |
|---|---|
| `JSONDecodable` | `Decodable` |
| `JSONEncodable` | `Encodable` |
| `Glossy` | `Codable` |
| `Gloss.Decoder` | `Swift.Decoder` |
| `Gloss.Encoder` | `Swift.Encoder` |

### Migration Steps

#### Step 1: Update your Gloss model to add Codable conformance

If your Gloss model conforms to `JSONDecodable`, add conformance to `Decodable`. A model that looks like this:

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
extension MyModel: Decodable { }
```

Alternatively, the following could be added to silence Codable errors:

``` swift
extension My Model: Decodable {

    init(from decoder: Swift.Decoder) throws {
        throw GlossError.decodableMigrationUnimplemented(context: "TODO")
    }

}
```

Similarly, `JSONEncodable` models add conformance to `Encodable`:

``` swift
struct MyModel: Encodable { }
```

alternatively:

``` swift
extension MyModel: Encodable {

    func encode(to encoder: Swift.Encoder) throws {
        throw GlossError.encodableMigrationUnimplemented(context: "TODO")
    }

}

```

**NOTE**: Explicit usage of `Swift.Decoder` and `Swift.Encoder` is needed not to namespace clash with `Gloss.Decoder` and `Gloss.Encoder`.


#### Step 2: Update call-sites

At call-sites where the Gloss model is used, update from using the current Gloss methods for decoding or encoding to new ones that take Codable into account.

For example, where initializing that model currently looks like:

``` swift
let myModel = MyModel(json: someJSON)
```

it becomes:

``` swift
let myModel: MyModel = .from(decodableJSON: someJSON)
```
As for encoding, this:

``` swift
let json: JSON? = myModel.toJSON()
```
 becomes:

``` swift
let json: JSON? = myModel.toEncodableJSON()
```
**NOTE**: Similar usage applies to arrays, with `from(decodableJSONArray:)` and `toEncodableJSONArray()` respectively.

#### Step 3: Update your model to use `Codable` for decoding/encoding

This means fleshing out that `init(from decoder: Swift.Decoder) throws` or `func encode(to encoder: Swift.Encoder) throws ` method. Or, better yet, removing them if Codable can synthesize your decoding/encoding for you.

Rinse and repeat this process for every Gloss model. You can leave the fallback Gloss methods in place until you're comfortable with your Codable implementation - then take the Gloss wheels off and ride into the sunset with Codable :sunrise: 

### Backwards Compatibility

If you are receiving errors anytime along the way don't worry - these **changes are backwards compatible**. What the new `from(decodableJSON:)` and `toEncodableJSON()` methods do under the hood is attempt to use Codable, but fallback to Gloss if any errors occur. They're also nice enough to log errors to the console to help you figure out where your migration is going astray.

If your Codable definitions are sound, but you're still receiving errors - you may need to explicitly configure a `JSONDecoder` or `JSONEncoder` and pass them along. A common reason for this is if your JSON is in [snake_case](https://en.wikipedia.org/wiki/Snake_case), whereas Codable defaults to [camelCase](https://en.wikipedia.org/wiki/Camel_case).

``` swift
let mySharedJSONDecoder: JSONDecoder = ...
let myModel: MyModel = .from(decodableJSON: someJSON, jsonDecoder: mySharedJSONDecoder)
```

``` swift
let mySharedJSONEncoder: JSONEncoder = ...
let json: JSON? = myModel.toEncodableJSON(jsonEncoder: mySharedJSONEncoder)
```

### :warning: One Caveat: Nested Data :warning:

**One significant caveat** is for models using [a special feature of Gloss that allows nested values to be retrieved](/README_ARCHIVE.md#retrieving-nested-model-values-without-creating-extra-models) using a period-delimited string. 

Before migrating to `Codable`, it may be simpler to un-nest those values by creating the nested models you were avoiding in the first place :cold_sweat: It's what Codable encourages regardless! Alternatively, you can use Codable's [nested containers](https://www.hackingwithswift.com/articles/119/codable-cheat-sheet) syntax.

## Case Study

Let's look at how we'd migrate [one of the models found in the Demo project](https://github.com/hkellaway/Gloss/blob/3.1.1/GlossExample/GlossExample/RepoOwner.swift#L29). We start with a simple model of a GitHub Repo owner. Here's our JSON:

``` json
{
    "id": 123,
    "html_url": "https://github.com/someUser"
}
```

### Preparing for Migration

First, we'll add conformance to Codable and update our call-sites.

#### Decodable

Our original `RepoOwner` model looks like this:

``` swift
import Gloss

struct RepoOwner: JSONDecodable, JSONEncodable {

    let ownerId: Int
    let url: String?
    
    init?(json: JSON) {
        guard let ownerId: Int = "id" <~~ json else { return nil }
        self.ownerId = ownerId
        self.url = "html_url" <~~ json
    }
    
    // ...
}
```

To start migrating to Codable, let's add conformance to `Decodable`.

``` swift
extension RepoOwner: Decodable { }
```

At our call-sites, we currently create this model from `JSON` as such:

``` swift
let json: JSON = ...
let repoOwner = RepoOwner(json: json)
```

Let's change that to use our new Codable-friendly method:

``` swift
let json: JSON = ...
let repoOwner: RepoOwner = .from(decodableJSON: json)
```

That's it! We're done preparing our Gloss decoding for a rewrite to Codable. For now, Gloss will attempt to use Codable but safely fallback to our Gloss decoding if there's an error.

#### Encodable

Let's look at the same steps for `Encodable`. Remember our model:

``` swift
import Gloss

struct RepoOwner: JSONDecodable, JSONEncodable {

    let ownerId: Int
    let url: String?
    
    // ...
    

    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> self.ownerId,
            "html_url" ~~> self.url
        ])
    } 
}

```

To start migrating to Codable, let's add conformance to `Encodable`.

``` swift
extension RepoOwner: Encodable { }
```

Currently, our call-sites look like this:

``` swift
let someRepoOwner: RepoOwner = ...
let json: JSON? = someRepoOwner.toJSON()
```

Let's change it to use our new Codable-friendly method:

``` swift
let someRepoOwner: RepoOwner = ...
let json: JSON? = someRepoOwner.toEncodableJSON()
```

That's it! We're done preparing our Gloss encoding for a rewrite to Codable. For now, Gloss will attempt to use Codable but safely fallback to our Gloss encoding if there's an error.

### Codable Definitions

Now we're ready to write our actual Codable definitions. Let's update our `Decodable` extension:

``` swift
extension RepoOwner: Decodable {

    fileprivate enum CodingKeys: String, CodingKey {
        case id, htmlUrl
    }
    
    init(from decoder: Swift.Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let ownerId = try container.decode(Int.self, forKey: .id)
        let url = try container.decodeIfPresent(String.self, forKey: .htmlUrl)
        self.init(ownerId: ownerId, url: url)
    }

}
```

and the `Encodable` one:

``` swift
extension RepoOnwer: Encodable {

    func encode(to encoder: Swift.Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.ownerId, forKey: .id)
        try container.encode(self.url, forKey: .htmlUrl)
    }

}
```

Looks great! But, even though these `Decodable` and `Encodable` definitions are sound....we're still getting an error.

It turns out that Codable assumes JSON keys will be in [camelCase](https://en.wikipedia.org/wiki/Camel_case), whereas our JSON uses [snake_case](https://en.wikipedia.org/wiki/Snake_case). We simply have to create our own `JSONDecoder` and `JSONEncoder` configured as such and pass those along. The good news is they will still come in handy when we ultimately remove Gloss!

``` swift
extension JSONDecoder {
    
    static func snakeCase() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
}


extension JSONEncoder {
    
    static func snakeCase() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
    
}

```

And our call-sites now become:

``` swift
let repoOwner: RepoOwner? = .from(decodableJSON: json, jsonDecoder: .snakeCase())
```

and:

``` swift
let json: JSON = someRepoOwner.toEncodableJSON(jsonEncoder: .snakeCase())
```

There we go! Our Codable code-paths now should be executing and our Gloss defintion is defunct :sparkles:


### Embracing Codable

Could we do better? Could we get Swift-ier?

The answer is: Yes. One of the most powerful things about Codable is it it can auto-magically use property names to synthesize our JSON decoding and encoding for us. Unless we have a special need for our key names or de/encoding logic, this is what we should aim for.

Let's revisit our JSON:

``` json
{
    "id": 123,
    "html_url": "https://github.com/someUser"
}
```

If we match our `RepoOwner` property names to `id` and `html_url` respectively, Codable will take care of the rest. Our penultimate model defintion looks like this, with Codable doing the work but our Gloss fallback in place: 

``` swift
import Gloss

struct RepoOwner: JSONDecodable, JSONEncodable {

    let id: Int
    let htmlUrl: String?
    
    init?(json: JSON) {
        guard let id: Int = "id" <~~ json else { return nil }
        self.id = id
        self.htmlUrl = "html_url" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> self.id,
            "html_url" ~~> self.htmlUrl
        ])
    }
}

extension RepoOwner: Codable { } // Codable covers both Decodable & Encodable

```

#### Using `Data` Instead of `JSON` to Create Models

In the places where you've come to rely on Gloss's `JSON` type, you'll eventually need to pass `Data`, as that is what Codable uses. To get a jump using `decode(:)`, one option is use the same method Gloss uses to do `Data` transformation:


``` swift
import Gloss

let mySharedSerializer: GlossJSONSErializer = ...
let json: JSON = ...
if let data: Data? = mySharedSerializer.data(from: json, options: nil) {
    let myModel: MyModel? = try? myJSONDecoder.decode(MyModel.self, from : data)
    ...
}
```

### Finally

The last step, once we're comfortable with our Codable integration, is to strip Gloss away. At the end of the day, our beautiful model looks like this:

``` swift
struct RepoOwner: Codable {
    let id: Int
    let htmlUrl: String?
}
```

And our need for snake-case is defined in just one place, instead of stringly-typed in each and every model. Talk about [lightweight](https://github.com/hkellaway/Gloss/blob/production/README_ARCHIVE.md#why-gloss)!

Take the opportunity with this migration to pare your models down to the slim amount of code Codable needs to work its magic and detangle your networking code from the details of JSON serialization. Future you will be grateful! :crystal_ball:

## Errata

If you find an issue with this guide or would like to add helpful content given your own migration, please [submit a Pull Request](https://github.com/hkellaway/Gloss/pulls).
