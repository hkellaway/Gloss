# Change Log
All notable changes to this project will be documented in this file.
`Gloss` adheres to [Semantic Versioning](http://semver.org/).

- `0.3.x` Releases - [0.3.0](#030) | [0.3.1](#031) 
- `0.2.x` Releases - [0.2.0](#020) 
- `0.1.x` Releases - [0.1.0](#010) 

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
