//
//  NFCForumWellKnownTypeSmartPoster.swift
//  NFCNDEFParse
//
//  Created by Jari Kalinainen on 09.10.17.
//

import Foundation
import CoreNFC

/// NFCForum-SmartPoster_RTD_1.0 2006-07-24
/// - records : [NFCForumWellKnownTypeProtocol]
///   - collection of the NFCForumWellKnownTypes
class NFCForumWellKnownTypeSmartPoster: NFCForumWellKnownTypeProtocol {
    
    var type: NFCForumWellKnownType = .smartPoster
    
    var records: [NFCForumWellKnownTypeProtocol] = []
    
    init?(payload: Data) {
        //TBA
    }
}
