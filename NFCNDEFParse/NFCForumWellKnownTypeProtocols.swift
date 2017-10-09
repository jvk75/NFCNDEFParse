//
//  NFCForumWellKnownTypeProtocols.swift
//  NFCNDEFParse
//
//  Created by Jari Kalinainen on 09.10.17.
//

import Foundation
import CoreNFC

/// - type : NFCForumWellKnownType
protocol NFCForumWellKnownTypeProtocol {
    var type: NFCForumWellKnownType {get}
}

/// - string : String
/// - locale : String
protocol NFCForumWellKnownTypeTextProtocol: NFCForumWellKnownTypeProtocol {
    var string: String? {get}
    var locale: String? {get}
}

/// - url : URL
/// - locale : String
protocol NFCForumWellKnownTypeUriProtocol: NFCForumWellKnownTypeProtocol {
    var url: URL? {get}
    var string: String? {get}
}
