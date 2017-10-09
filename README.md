# NFCNDEFParse

NFC Forum Well Known Type Data Parser for iOS11 and Core NFC.

Supports parsing of types:

Text - NFCForum-TS-RTD_Text_1.0 2006-07-24

Uri - NFCForum-TS-RTD_URI_1.0 2006-07-24

Smart Poster - NFCForum-SmartPoster_RTD_1.0 2006-07-24 (TBA)

## Requirements

Core NFC requires iOS11

## Installation

NFCNDEFParse is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod 'NFCNDEFParse'
```

## Usage

```
import NFCNDEFParse

...

var data: NDEFMessageWithWellKnownTypes?

...

func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
    for message in messages {
        data = NDEFMessageWithWellKnownTypes(records: message.records)
    }
}

...

data?.records.forEach({ record in
    if record.type == .text, let record = record as? NFCForumWellKnownTypeTextProtocol {
        print(record.string)
        print(record.locale)
    }
    if record.type == .uri, let record = record as? NFCForumWellKnownTypeUriProtocol {
        print(record.string)
        print(record.url)
    }
})

```

## Author

Jari Kalinainen, jari@klubitii.com

## License

NFCNDEFParse is available under the MIT license. See the LICENSE file for more info.
