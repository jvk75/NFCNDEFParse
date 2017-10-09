//
//  NDEFMessageWithWellKnownTypes.swift
//
//  Created by Jari Kalinainen on 09/10/2017.
//
//  NFC Forum Well Known Type model/parser

import Foundation
import CoreNFC

/// Currently supported types
/// - text
/// - uri
/// - smart poster (coming soon)
enum NFCForumWellKnownType: String {
    case text = "T"
    case uri = "U"
    case smartPoster = "Sp"
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
/// - records : [NFCForumWellKnownTypeProtocol]
///   - collection of the NFCForumWellKnownTypes
public class NDEFMessageWithWellKnownTypes {

    /// - records : [NFCForumWellKnownTypeProtocol]
    ///   - collection of the NFCForumWellKnownTypes
    var records: [NFCForumWellKnownTypeProtocol] = []

    public init?(records: [NFCNDEFPayload]) {
        self.records = records.flatMap({ record in
            let type = NFCForumWellKnownType(data: record.type)
            switch type {
            case .text:
                return NFCForumWellKnownTypeText(payload: record.payload)
            case .uri:
                return NFCForumWellKnownTypeUri(payload: record.payload)
            default:
                return nil
            }
        })
    }
}
