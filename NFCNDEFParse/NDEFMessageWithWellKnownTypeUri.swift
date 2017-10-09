//
//  NDEFMessageWithWellKnownTypeUri.swift
//  NFCNDEFParse
//
//  Created by Jari Kalinainen on 09.10.17.
//

import Foundation
import CoreNFC

/// NFCForum-TS-RTD_URI_1.0 2006-07-24
/// - url : URL
///   - not nil if payload can be created as URL type
/// - string : String (
///   - string representation of the payload
class NFCForumWellKnownTypeUri: NFCForumWellKnownTypeUriProtocol {
    
    var type: NFCForumWellKnownType = .uri
    
    var url: URL?
    var string: String?
    
    init?(payload: Data) {
        let bytes = [UInt8](payload)
        let uriIdentifierByte = bytes[0]
        let textBytes = bytes[1...]
        if let textString = String(bytes: textBytes, encoding: .utf8) {
            self.string = self.abbreviation(uriIdentifierByte) + textString
            if let string = self.string {
                self.url = URL(string: string)
            }
        }
    }
    
    private func abbreviation(_ value: UInt8) -> String {
        switch value {
        case 0x01:
            return "http://www."
        case 0x02:
            return "https://www."
        case 0x03:
            return "http://"
        case 0x04:
            return "https://"
        case 0x05:
            return "tel:"
        case 0x06:
            return "mailto:"
        case 0x07:
            return "ftp://anonymous:anonymous@"
        case 0x08:
            return "ftp://ftp."
        case 0x09:
            return "ftps://"
        case 0x0A:
            return "sftp://"
        case 0x0B:
            return "smb://"
        case 0x0C:
            return "nfs://"
        case 0x0D:
            return "ftp://"
        case 0x0E:
            return "dav://"
        case 0x0F:
            return "news://"
        case 0x10:
            return "telnet://"
        case 0x11:
            return "imap://"
        case 0x12:
            return "rtsp://"
        case 0x13:
            return "urn:"
        case 0x14:
            return "pop:"
        case 0x15:
            return "sip:"
        case 0x16:
            return "sips:"
        case 0x17:
            return "tftp:"
        case 0x18:
            return "btspp://"
        case 0x19:
            return "btl2cap://"
        case 0x1A:
            return "btgoep://"
        case 0x1B:
            return "tcpobex://"
        case 0x1C:
            return "irdaobex://"
        case 0x1D:
            return "file://"
        case 0x1E:
            return "urn:epc:id:"
        case 0x1F:
            return "urn:epc:tag:"
        case 0x20:
            return "urn:epc:pat:"
        case 0x21:
            return "urn:epc:raw:"
        case 0x22:
            return "urn:epc:"
        case 0x23:
            return "urn:nfc:"
        default:
            return ""
        }
    }
}
