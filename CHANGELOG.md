# Change Log
All notable changes to this project will be documented in this file.
`Gloss` adheres to [Semantic Versioning](http://semver.org/).

- `1.0.x` Releases - [1.0.0](#100)
- `0.8.x` Releases - [0.8.0](#080)
- `0.7.x` Releases - [0.7.0](#070) | [0.7.1](#071) | [0.7.2](#072) | [0.7.3](#073) | [0.7.4](#074)
- `0.6.x` Releases - [0.6.0](#060) | [0.6.1](#061) | [0.6.2](#062)
- `0.5.x` Releases - [0.5.0](#050) | [0.5.1](#051) | [0.5.2](#052) | [0.5.3](#053) | [0.5.4](#054)
- `0.4.x` Releases - [0.4.0](#040)
- `0.3.x` Releases - [0.3.0](#030) | [0.3.1](#031)
- `0.2.x` Releases - [0.2.0](#020)
- `0.1.x` Releases - [0.1.0](#010)

---

## [1.0.0](https://github.com/hkellaway/Gloss/releases/tag/1.0.0)
Released on 2016-09-20. All issues associated with this milestone can be found using this [filter](https://github.com/hkellaway/Gloss/issues?utf8=%E2%9C%93&q=milestone%3A1.0.0)

#### Updated
- Support for Swift 3.0 [PR [#212](https://github.com/hkellaway/Gloss/pull/212)]
- Syntax now reflects Swift 3.0 standards [PR [#216](https://github.com/hkellaway/Gloss/pull/216)]
- JSON typealias now uses Any instead of AnyObject

#### Upgrade Notes

This version marks the first version using Swift 3.0 syntax. Users should update client projects to Swift 3.0 before switching to `1.0.0`

Also note: Version `0.8.0` marked the deprecation of a feature called "nested keypaths". This allowed deeply nested JSON values to be accessed via a period-delimited key. However, it caused a runtime crash when using the Release configuration. Users who rely on nested keypaths should update their models before switching to `0.8.0` or `1.0.0`. See [Nested Keypaths Deprecation](https://github.com/hkellaway/Gloss#nested-keypaths-deprecation) for more information.

---

## [0.8.0](https://github.com/hkellaway/Gloss/releases/tag/0.8.0)
Released on 2016-09-20. All issues associated with this milestone can be found using this [filter](https://github.com/hkellaway/Gloss/issues?utf8=%E2%9C%93&q=milestone%3A0.8.0)

#### Deprecated
- The "nested keypaths" feature has been removed as it caused a runtime crash for the Release configuration (Issue [#135](https://github.com/hkellaway/Gloss/issues/135))

#### Updated
- Array decoding now returns `nil` if any decodings fail instead of a partial array of decoded values (Issue [#189](https://github.com/hkellaway/Gloss/issues/189))
- Support for Swift 2.3 [PR [#209](https://github.com/hkellaway/Gloss/pull/209)]

#### Upgrade Notes

This version marks the deprecation of a feature called "nested keypaths". This allowed deeply nested JSON values to be accessed via a period-delimited key. However, it caused a runtime crash when using the Release configuration. Users who rely on nested keypaths should update their models before switching to `0.8.0`. See [Nested Keypaths Deprecation](https://github.com/hkellaway/Gloss#nested-keypaths-deprecation) for more information.

While it's understood that this is inconvenient, the decision was made to remove in favor of avoiding runtime crashes.

Also note: this version marks the last that will use Swift 2.x syntax. Version `1.0.0` will support Swift 3.0 and any improvements to Gloss thereafter will use Swift 3.0 syntax.

---

## [0.7.4](https://github.com/hkellaway/Gloss/releases/tag/0.7.4)
Released on 2016-07-14. All issues associated with this milestone can be found using this [filter](https://github.com/hkellaway/Gloss/issues?utf8=%E2%9C%93&q=milestone%3A0.7.4)

#### Added
- De/Encoding for UIInt32, [UIInt32], UInt64, and [UInt64] [PR [#168](https://github.com/hkellaway/Gloss/pull/168)]
- Support for Swift 2.3 [PR [#178](https://github.com/hkellaway/Gloss/pull/178)]
- Separate `swift_2.3` and `swift_3.0` branches

#### Fixed
- Occasional Carthage build failure [PR [#180](https://github.com/hkellaway/Gloss/pull/180)]

#### Removed
- Documentation on nested keypaths until [Issue [#135](https://github.com/hkellaway/Gloss/issues/135)] is resolved

---

## [0.7.3](https://github.com/hkellaway/Gloss/releases/tag/0.7.3)
Released on 2016-05-04. All issues associated with this milestone can be found using this [filter](https://github.com/hkellaway/Gloss/issues?utf8=%E2%9C%93&q=milestone%3A0.7.3)

#### Added
- De/Encoding for dictionaries with de/encodable model arrays [Issue [#148](https://github.com/hkellaway/Gloss/issues/148)]
- De/Encoding for Int32 and Int64 [PR [#154](https://github.com/hkellaway/Gloss/pull/154)]

#### Fixed
- Access modifier inconsistency [PR [#150](https://github.com/hkellaway/Gloss/pull/150)]

#### Updated
- All documentation to be consistent [PR [#156](https://github.com/hkellaway/Gloss/pull/156)]

---

## [0.7.2](https://github.com/hkellaway/Gloss/releases/tag/0.7.2)
Released on 2016-04-15. All issues associated with this milestone can be found using this [filter](https://github.com/hkellaway/Gloss/issues?utf8=%E2%9C%93&q=milestone%3A0.7.2)

#### Fixed
- Issue with encoding Encodable dictonaries that resulted in top-level translation being lost [PR [#126](https://github.com/hkellaway/Gloss/pull/126)]
- Date parsing failure if non-Gregorian calendar set on device [PR [#129](https://github.com/hkellaway/Gloss/pull/129)]
- Incorrect decoding of for nested keypaths in Release builds using Swift 2.2 [Issue [#135](https://github.com/hkellaway/Gloss/issues/135)]
- Usage of lazy NSDateFormatter for ISO 8601 dates [PR [#138](https://github.com/hkellaway/Gloss/pull/138)]

#### Updated
- Moved tests from Example project to framework project [[PR #131](https://github.com/hkellaway/Gloss/pull/131)]

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
