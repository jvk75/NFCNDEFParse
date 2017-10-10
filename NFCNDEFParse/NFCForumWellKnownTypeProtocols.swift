//
//  NFCForumWellKnownTypeProtocols.swift
//  NFCNDEFParse
//
//  Created by Jari Kalinainen on 09.10.17.
//

import Foundation
import CoreNFC

/// - type : NFCForumWellKnownType
/// - description : String
///   - record description (values)
public protocol NFCForumWellKnownTypeProtocol {
    var type: NFCForumWellKnownType {get}
    var description: String {get}
}

/// - string : String
/// - locale : String
public protocol NFCForumWellKnownTypeTextProtocol: NFCForumWellKnownTypeProtocol {
    var string: String? {get}
    var locale: String? {get}
}

/// - url : URL
/// - locale : String
public protocol NFCForumWellKnownTypeUriProtocol: NFCForumWellKnownTypeProtocol {
    var url: URL? {get}
    var string: String? {get}
}


/// - records: [NFCForumWellKnownTypeProtocol]
public protocol NFCForumWellKnownTypeSmartPosterProtocol: NFCForumWellKnownTypeProtocol {
    var records: [NFCForumWellKnownTypeProtocol] {get}
}

