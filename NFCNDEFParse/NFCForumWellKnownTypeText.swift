//
//  NFCForumWellKnownTypeText.swift
//  NFCNDEFParse
//
//  Created by Jari Kalinainen on 09.10.17.
//

import Foundation
import CoreNFC

/// NFCForum-TS-RTD_Text_1.0 2006-07-24
/// - **string** : String
///   - string representation of the payload
/// - **locale** : String
///   - language code of the payload string
@objc public class NFCForumWellKnownTypeText: NSObject, NFCForumWellKnownTypeTextProtocol {
    
    @objc public var type: NFCForumWellKnownTypeEnum = .text
    
    @objc public var string: String?
    @objc public var locale: String?

    @objc public var recordDescription: String {
        return "- \(self.type.description): \n\tstring: \(string ?? "nil") \n\tlocale: \(locale ?? "nil")"
    }

    private var localeLength: Int = 0
    private var encoding: String.Encoding = .utf8
    
    public init?(payload: Data) {
        super.init()
        let bytes = [UInt8](payload)
        guard bytes.count > 1 else {
            return
        }
        let statusByte = bytes[0]
        parseStatusByte(byte: statusByte)
        let localeBytes = bytes[1...localeLength]
        locale = String(bytes: localeBytes, encoding: encoding)
        let textBytes = bytes[(localeLength + 1)...]
        string = String(bytes: textBytes, encoding: encoding)
    }
    
    private func parseStatusByte(byte: UInt8) {
        let binary = String(byte, radix: 2).characters
        if binary.count == 8, binary.first! == "1" {
            encoding = .utf16
        }
        localeLength = Int(byte & 0x3F)
    }
}
