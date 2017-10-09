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
public class NFCForumWellKnownTypeSmartPoster: NFCForumWellKnownTypeProtocol {
    
    public var type: NFCForumWellKnownType = .smartPoster
    
    public var records: [NFCForumWellKnownTypeProtocol] = []
    
    public init?(payload: Data) {
        //TBA
    }
}
