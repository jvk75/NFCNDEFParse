//
//  NFCForumWellKnownTypeProtocols.swift
//  NFCNDEFParse
//
//  Created by Jari Kalinainen on 09.10.17.
//

import Foundation
import CoreNFC

/// - **type** : NFCForumWellKnownType
/// - **description** : String
///   - record description (values)
public protocol NFCForumWellKnownTypeProtocol {
    var type: NFCForumWellKnownType {get}
    var recordDescription: String {get}
}

/// - **string** : String
/// - **locale** : String
public protocol NFCForumWellKnownTypeTextProtocol: NFCForumWellKnownTypeProtocol {
    var string: String? {get}
    var locale: String? {get}
}

/// - **url** : URL
/// - **locale** : String
public protocol NFCForumWellKnownTypeUriProtocol: NFCForumWellKnownTypeProtocol {
    var url: URL? {get}
    var string: String? {get}
}


/// - **records**: [NFCForumWellKnownTypeProtocol]
public protocol NFCForumWellKnownTypeSmartPosterProtocol: NFCForumWellKnownTypeProtocol {
    var records: [NFCForumWellKnownTypeProtocol] {get}
}

/// - **size**: Int
public protocol NFCForumWellKnownTypeSizeProtocol: NFCForumWellKnownTypeProtocol {
    var size: Int? {get}
}

/// - **action**: NFCSmartPosterActionRecord
///   - **execute** : Do the action (send the SMS, launch the browser, make the telephone call)
///   - **save** : Save for later (store the SMS in INBOX, put the URI in a bookmark, save the telephone number in contacts)
///   - **open** : Open for editing (open an SMS in the SMS editor, open the URI in an URI editor, open the telephone number for editing).
public protocol NFCForumWellKnownTypeActionProtocol: NFCForumWellKnownTypeProtocol {
    var action: NFCSmartPosterActionRecord? {get}
}

