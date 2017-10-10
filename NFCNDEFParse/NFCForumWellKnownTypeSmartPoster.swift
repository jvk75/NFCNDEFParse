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
/// - records : [NFCForumWellKnownTypeProtocol]
///   - collection of the NFCForumWellKnownTypes
public class NFCForumWellKnownTypeSmartPoster: NFCForumWellKnownTypeSmartPosterProtocol {
    
    public var type: NFCForumWellKnownType = .smartPoster
    
    public var records: [NFCForumWellKnownTypeProtocol]

    public var description: String {
        let recordDescriptions = records.map({ $0.description }).joined(separator: "\n")
        return "- \(self.type): {\n\(recordDescriptions)\n}\n"
    }

    private var payloadFirstByte: Int = 0

    public init?(payload: Data) {
        let allBytes = [UInt8](payload)
        var newRecords: [NFCForumWellKnownTypeProtocol?] = []
        while payloadFirstByte < allBytes.count {
            let bytes = Array(allBytes[payloadFirstByte...])

            let typeLength = Int(bytes[1])
            let type = NFCForumWellKnownType(data: Data(bytes: bytes[3...(2+typeLength)]))

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

            let payload = bytes[(2+typeLength + 1)...payloadLastByte]
            if  type == .uri {
                newRecords.append(NFCForumWellKnownTypeUri(payload: Data(bytes: payload)))
            }
            if  type == .text {
                newRecords.append(NFCForumWellKnownTypeText(payload: Data(bytes: payload)))
            }
            payloadFirstByte += payloadLastByte + 1
        }
        self.records = newRecords.flatMap({ $0 })
    }
}
