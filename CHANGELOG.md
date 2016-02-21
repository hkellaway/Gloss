# Change Log
All notable changes to this project will be documented in this file.
`Gloss` adheres to [Semantic Versioning](http://semver.org/).

- `0.7.x` Releases - [0.7.0](#070) | [0.7.1](#071)
- `0.6.x` Releases - [0.6.0](#060) | [0.6.1](#061) | [0.6.2](#062)
- `0.5.x` Releases - [0.5.0](#050) | [0.5.1](#051) | [0.5.2](#052) | [0.5.3](#053) | [0.5.4](#054)
- `0.4.x` Releases - [0.4.0](#040)
- `0.3.x` Releases - [0.3.0](#030) | [0.3.1](#031) 
- `0.2.x` Releases - [0.2.0](#020) 
- `0.1.x` Releases - [0.1.0](#010) 

---

## [0.7.1](https://github.com/hkellaway/Gloss/releases/tag/0.7.1)
Released on 2016-02-21. All issues associated with this milestone can be found using this [filter](https://github.com/hkellaway/Gloss/issues?utf8=%E2%9C%93&q=milestone%3A0.7.1)

#### Fixed
- Stale Dictionary.swift reference [Issue [#122](https://github.com/hkellaway/Gloss/issues/122)]

---

## [0.7.0](https://github.com/hkellaway/Gloss/releases/tag/0.7.0)
Released on 2016-02-20. All issues associated with this milestone can be found using this [filter](https://github.com/hkellaway/Gloss/issues?utf8=%E2%9C%93&q=milestone%3A0.7.0).

#### Added
- Ability to de/encode dictionaries of de/encodable models [PR [#100](https://github.com/hkellaway/Gloss/pull/100)]
- Ability to reference nested model properties via a period-delimited key [PR [#98](https://github.com/hkellaway/Gloss/pull/98)], [PR [#115](https://github.com/hkellaway/Gloss/pull/115)]

#### Fixed
- Not being able to subclass Gloss models [PR [#103](https://github.com/hkellaway/Gloss/pull/103)]

#### Updated
- Date formatter for ISO 8601 dates to be lazily instantiated [Issue [#110](https://github.com/hkellaway/Gloss/issues/110)]
- Syntax for de/encoding models to/from JSON arrays [PR [#116](https://github.com/hkellaway/Gloss/pull/116)]
- Decoder to sanitize strings used for creating NSURLs [PR [#119](https://github.com/hkellaway/Gloss/pull/119)]

---

## [0.6.2](https://github.com/hkellaway/Gloss/releases/tag/0.6.2)
Released on 2015-12-24. All issues associated with this milestone can be found using this [filter](https://github.com/hkellaway/Gloss/issues?utf8=%E2%9C%93&q=milestone%3A0.6.2).

#### Added
- tvOS target [PR [#88](https://github.com/hkellaway/Gloss/pull/88)]
- watchOS target
- Swift Package Manager support

---

## [0.6.1](https://github.com/hkellaway/Gloss/releases/tag/0.6.1)
Released on 2015-11-20. All issues associated with this milestone can be found using this [filter](https://github.com/hkellaway/Gloss/issues?utf8=%E2%9C%93&q=milestone%3A0.6.1).

#### Fixed
- URL arrays not decoded automatically [Issue [#81](https://github.com/hkellaway/Gloss/issues/81)]
- Date arrays not decoded or encoded automatically [Issue [#84](https://github.com/hkellaway/Gloss/issues/84)]
- Empty JSON arrays encoded as `nil`

---

## [0.6.0](https://github.com/hkellaway/Gloss/releases/tag/0.6.0)
Released on 2015-10-25. All issues associated with this milestone can be found using this [filter](https://github.com/hkellaway/Gloss/issues?utf8=%E2%9C%93&q=milestone%3A0.6.0).

#### Added
- Creation of model arrays from JSON arrays via `modelsFromJSONArray(:_)`
- Creation of JSON arrays from model arrays via `toJSONArray(_:)`
- Support for Mac OSX [Issue [#75](https://github.com/hkellaway/Gloss/issues/75)]

#### Fixed
- Encoder returning `nil` for encoded arrays that came out empty [Issue [#68](https://github.com/hkellaway/Gloss/issues/68)]

#### Removed
- Support for Swift 1.2 via the `swift_1.2` branch

---

## [0.5.4](https://github.com/hkellaway/Gloss/releases/tag/0.5.4)
Released on 2015-09-22. All issues associated with this milestone can be found using this [filter](https://github.com/hkellaway/Gloss/issues?utf8=%E2%9C%93&q=milestone%3A0.5.4).

#### Added
- tvOS platform to podspec [PR [#63](https://github.com/hkellaway/Gloss/pull/63)]

---

## [0.5.3](https://github.com/hkellaway/Gloss/releases/tag/0.5.3)
Released on 2015-09-19. All issues associated with this milestone can be found using this [filter](https://github.com/hkellaway/Gloss/issues?utf8=%E2%9C%93&q=milestone%3A0.5.3).

#### Fixed
- Carthage compatibility issues [PR [#54](https://github.com/hkellaway/Gloss/pull/54)]
- Failing tests for ISO 8601 Dates when not in Eastern timezone [Issue [#55](https://github.com/hkellaway/Gloss/issues/55)]

---

## [0.5.2](https://github.com/hkellaway/Gloss/releases/tag/0.5.2)
Released on 2015-09-08. All issues associated with this milestone can be found using this [filter](https://github.com/hkellaway/Gloss/issues?utf8=%E2%9C%93&q=milestone%3A0.5.2).

#### Added
- Import of Foundation in source files [PR [#51](https://github.com/hkellaway/Gloss/pull/51)]

---

## [0.5.1](https://github.com/hkellaway/Gloss/releases/tag/0.5.1)
Released on 2015-08-24. All issues associated with this milestone can be found using this [filter](https://github.com/hkellaway/Gloss/issues?utf8=%E2%9C%93&q=milestone%3A0.5.1).

#### Added
- Support for installation via Carthage [Issue [#28](https://github.com/hkellaway/Gloss/issues/28)]

---

## [0.5.0](https://github.com/hkellaway/Gloss/releases/tag/0.5.0)
Released on 2015-08-22. All issues associated with this milestone can be found using this [filter](https://github.com/hkellaway/Gloss/issues?utf8=%E2%9C%93&q=milestone%3A0.5.0).

#### Added
- Failable initializer `init?(json:)` added to `Decodable` protocol in place of `init(json:)` [PR [#38](https://github.com/hkellaway/Gloss/pull/38)]

#### Removed
- Force decode functions and force decode operator `<~~!` removed in place of failable initializer `init?(json:)`

---

## [0.4.0](https://github.com/hkellaway/Gloss/releases/tag/0.4.0)
Released on 2015-08-22. All issues associated with this milestone can be found using this [filter](https://github.com/hkellaway/Gloss/issues?utf8=%E2%9C%93&q=milestone%3A0.4.0).

#### Added
- Ability to force the decoding of a property from JSON [Issue [#25](https://github.com/hkellaway/Gloss/issues/25)]
- Custom `<~~!` operator for force decoding [Issue [#25](https://github.com/hkellaway/Gloss/issues/25)]
- `Decodable` protocol was updated to have JSON passed in via the `init(json:)` initializer [Issue [#25](https://github.com/hkellaway/Gloss/issues/25)]
- Tests for object creation from JSON and JSON creation from object

#### Updated
- Pod docs now use reStructured text format [PR [#33](https://github.com/hkellaway/Gloss/pull/33), [#34](https://github.com/hkellaway/Gloss/pull/34)]

#### Removed

- The `fromJSON(json:)` method was removed from the `Decodable` protocol in place of the new `init(json:)` initializer [Issue [#25](https://github.com/hkellaway/Gloss/issues/25)]

---

## [0.3.1](https://github.com/hkellaway/Gloss/releases/tag/0.3.1)
Released on 2015-08-17.

#### Added
- CHANGELOG
- Increased Pod documentation

---

## [0.3.0](https://github.com/hkellaway/Gloss/releases/tag/0.3.0)
Released on 2015-08-16.

#### Added
- Custom operators `<~~` and `~~>` for decoding/encoding respectively
- Test suite

#### Fixed
- Decoding and encoding support for `enum` value arrays
- Removed unnecessary decoding/encoding for dictionaries with `String` keys
- Removed requirement for ISO8601 Dates to pass in `NSDateFormatter` in order to be decoded/encoded

---

## [0.2.0](https://github.com/hkellaway/Gloss/releases/tag/0.2.0)
Released on 2015-08-13.

#### Added
- Ability to create immutable models by declaring properties via `let`

---

## [0.1.0](https://github.com/hkellaway/Gloss/releases/tag/0.1.0)
Released on 2015-08-12.

#### Added
- Initial release of Gloss
- Mapping JSON to objects
- Mapping objects to JSON
- Nested Objects
- Custom transformations
- Swift 2 compatibilty
- Swift 1.2 support off branch `swift_1.2`
- Documentation
