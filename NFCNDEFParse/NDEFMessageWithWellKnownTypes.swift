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
public enum NFCForumWellKnownType: String {
    case text = "T"
    case uri = "U"
    case smartPoster = "Sp"
    case action = "act" // smart poster sub type
    case size = "s" // smart poster sub type
    case type = "t" // smart poster sub type
    case unknown

    init(data: Data) {
        if let string = String(data: data, encoding: .utf8) {
            self = NFCForumWellKnownType(rawValue: string) ?? .unknown
        } else {
            self = .unknown
        }
    }
}

/// Class that contains records of NFC Forum Well Known Types
/// - **records** : [NFCForumWellKnownTypeProtocol]
///   - collection of the NFCForumWellKnownTypes
/// - **types** : [NFCTypeNameFormat]
///   - collection of the record types
public class NDEFMessageWithWellKnownTypes: NSObject  {

    public var records: [NFCForumWellKnownTypeProtocol] = []
    public var types: [NFCTypeNameFormat] = []
    
    public init?(records: [NFCNDEFPayload]) {
        super.init()
        self.records = records.flatMap({ record in
            self.types.append(record.typeNameFormat)
            let type = NFCForumWellKnownType(data: record.type)
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
