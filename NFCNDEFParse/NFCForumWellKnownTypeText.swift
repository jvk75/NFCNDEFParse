//
//  NFCForumWellKnownTypeText.swift
//  NFCNDEFParse
//
//  Created by Jari Kalinainen on 09.10.17.
//

import Foundation
import CoreNFC

/// NFCForum-TS-RTD_Text_1.0 2006-07-24
/// - string : String
///   - string representation of the payload
/// - locale : String
///   - language code of the payload string
public class NFCForumWellKnownTypeText: NFCForumWellKnownTypeTextProtocol {
    
    public var type: NFCForumWellKnownType = .text
    
    public var string: String?
    public var locale: String?
    
    private var localeLength: Int = 0
    private var encoding: String.Encoding = .utf8
    
    public init?(payload: Data) {
        let bytes = [UInt8](payload)
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
