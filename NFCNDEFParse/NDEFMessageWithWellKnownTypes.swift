//
//  NDEFMessageWithWellKnownTypes.swift
//  NFCNDEFParse
//
//  Created by Jari Kalinainen on 09/10/2017.
//
//  NFC Forum Well Known Type model/parser

import Foundation
import CoreNFC

/// Currently supported types
/// - text
/// - uri
/// - smart poster (title, uri, action, size)
@objc public enum NFCForumWellKnownTypeEnum: Int {
    case text //"T"
    case uri //"U"
    case smartPoster //"Sp"
    case action //"act" // smart poster sub type
    case size //"s" // smart poster sub type
    case type //"t" // smart poster sub type
    case unknown

    init(data: Data) {
        if let string = String(data: data, encoding: .utf8) {
            switch string {
            case "T":
                self = .text
            case "U":
                self = .uri
            case "Sp":
                self = .smartPoster
            case "act":
                self = .action
            case "s":
                self = .size
            case "t":
                self = .type
            default:
                self = .unknown
            }
        } else {
            self = .unknown
        }
    }
    
    var description: String {
        switch self {
        case .text:
            return "Text"
        case .uri:
            return "Uri"
        case .smartPoster:
            return "Smart Poster"
        case .action:
            return "Action"
        case .size:
            return "Size"
        case .type:
            return "Type"
        default:
            return "Unknown"
        }
    }
}

/// Class that contains records of NFC Forum Well Known Types
/// - **records** : [NFCForumWellKnownTypeProtocol]
///   - collection of the NFCForumWellKnownTypes
/// - **types** : [NFCTypeNameFormat]
///   - collection of the record types
@objc public class NDEFMessageWithWellKnownTypes: NSObject  {

    @objc public var records: [NFCForumWellKnownTypeProtocol] = []
    @objc public var types: [UInt8] = []
    
    public init?(records: [NFCNDEFPayload]) {
        super.init()
        self.records = records.flatMap({ record in
            self.types.append(record.typeNameFormat.rawValue)
            let type = NFCForumWellKnownTypeEnum(data: record.type)
            switch type {
            case .text:
                return NFCForumWellKnownTypeText(payload: record.payload)
            case .uri:
                return NFCForumWellKnownTypeUri(payload: record.payload)
            case .smartPoster:
                return NFCForumWellKnownTypeSmartPoster(payload: record.payload)
            default:
                return nil
            }
        })
    }
}
