# NFCNDEFParse

## Requirements

Core NFC requires iOS11

## Installation

NFCNDEFParse is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'NFCNDEFParse'
```

## Usage

```
func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
    for message in messages {
        let data = NDEFMessageWithWellKnownTypes(records: message.records)
    }
}
```

## Author

Jari Kalinainen, jari@klubitii.com

## License

NFCNDEFParse is available under the MIT license. See the LICENSE file for more info.
