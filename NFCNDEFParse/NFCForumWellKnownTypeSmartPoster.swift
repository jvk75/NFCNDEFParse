//
//  NFCForumWellKnownTypeSmartPoster.swift
//  NFCNDEFParse
//
//  Created by Jari Kalinainen on 09.10.17.
//

import Foundation
import CoreNFC

/// NFCForum-SmartPoster_RTD_1.0 2006-07-24
/// (only URI and Text records supported, Action and Size records are ignored, Type and Icon records may cause problems)
/// - **records** : [NFCForumWellKnownTypeProtocol]
///   - collection of the NFCForumWellKnownTypes
public class NFCForumWellKnownTypeSmartPoster: NSObject, NFCForumWellKnownTypeSmartPosterProtocol {
    
    public var type: NFCForumWellKnownTypeEnum = .smartPoster
    
    public var records: [NFCForumWellKnownTypeProtocol] = []

    public var recordDescription: String {
        let recordDescriptions = records.map({ $0.recordDescription }).joined(separator: "\n")
        return "- \(self.type.description): {\n\(recordDescriptions)\n}\n"
    }

    private var payloadFirstByte: Int = 0

    public init?(payload: Data) {
        super.init()
        let allBytes = [UInt8](payload)
        guard allBytes.count > 3 else {
            return
        }
        var newRecords: [NFCForumWellKnownTypeProtocol?] = []
        while payloadFirstByte < allBytes.count {
            let bytes = Array(allBytes[payloadFirstByte...])

            let typeLength = Int(bytes[1])
            let type = NFCForumWellKnownTypeEnum(data: Data(bytes: bytes[3...(2+typeLength)]))

            let payloadLength: Int
            switch type {
            case .action:
                payloadLength = 1
            case .size:
                payloadLength = 4
            default:
                payloadLength = Int(bytes[2])
            }

            let payloadLastByte = (2+typeLength) + payloadLength

            let payload = Data(bytes: bytes[(2+typeLength + 1)...payloadLastByte])
            switch type {
            case .text:
                newRecords.append(NFCForumWellKnownTypeText(payload: payload))
            case .uri:
                newRecords.append(NFCForumWellKnownTypeUri(payload: payload))
            case .size:
                newRecords.append(NFCForumWellKnownSubTypeSize(payload: payload))
            case .action:
                newRecords.append(NFCForumWellKnownSubTypeAction(payload: payload))
            default:
                continue
            }
            payloadFirstByte += payloadLastByte + 1
        }
        self.records = newRecords.flatMap({ $0 })
    }
}

// MARK: - Smart Poster Action Record Enum
@objc public enum NFCSmartPosterActionRecord: UInt8 {
    case execute = 0x00
    case save = 0x01
    case open = 0x02
    
    var description: String {
        switch self {
        case .execute:
            return "do the action"
        case .save:
            return "save for later"
        case .open:
            return "open for editing"
        }
    }
}

// MARK: - Smart Poster Action Record
/// NFCForum-SmartPoster_RTD_1.0 2006-07-24
/// Smart Poster Action Record
/// - **action** : NFCSmartPosterActionRecord
///   - **execute** : Do the action (send the SMS, launch the browser, make the telephone call)
///   - **save** : Save for later (store the SMS in INBOX, put the URI in a bookmark, save the telephone number in contacts)
///   - **open** : Open for editing (open an SMS in the SMS editor, open the URI in an URI editor, open the telephone number for editing).
@objc public class NFCForumWellKnownSubTypeAction: NSObject, NFCForumWellKnownTypeActionProtocol, NFCForumWellKnownTypeActionProtocolObjC {

    @objc public var type: NFCForumWellKnownTypeEnum = .action
    
    @objc public var recordDescription: String {
        return "-\(type.description)\naction: " + (self.action?.description ?? "nil")
    }
    
    public var action: NFCSmartPosterActionRecord?
    @objc public var actionByte: UInt8 = 0xFF

    public init?(payload: Data) {
        super.init()
        let bytes = [UInt8](payload)
        self.actionByte = bytes[0]
        if let byte = bytes.first {
            self.action = NFCSmartPosterActionRecord(rawValue: byte)
        }
    }
}

// MARK: - Smart Poster Size Record
/// NFCForum-SmartPoster_RTD_1.0 2006-07-24
/// Smart Poster Size Record
/// - **size** : Int
///   - value of the size payload
public class NFCForumWellKnownSubTypeSize: NSObject, NFCForumWellKnownTypeSizeProtocol {
    
    public var type: NFCForumWellKnownTypeEnum = .action
    
    public var recordDescription: String {
        return "-\(type.description)\nsize: \(size)"
    }
    
    public var size: Int = 0
    
    public init?(payload: Data) {
        super.init()
        let bytes = [UInt8](payload)
        if let byte = bytes.first {
            self.size = Int(byte)
        }
    }
}
