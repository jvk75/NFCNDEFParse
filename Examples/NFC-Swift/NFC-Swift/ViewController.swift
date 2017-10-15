//
//  ViewController.swift
//  NFC-Swift
//
//  Created by Jari Kalinainen on 14.10.17.
//  Copyright © 2017 Jari Kalinainen. All rights reserved.
//

import UIKit
import CoreNFC

class ViewController: UIViewController, NFCNDEFReaderSessionDelegate {
    
    @IBOutlet weak var dataLabel: UILabel!
    
    var nfc: NFCNDEFReaderSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeNFCSession()
    }
    
    func initializeNFCSession() {
        if let session = self.nfc {
            session.invalidate()
            self.nfc = nil
        }
        self.nfc = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        self.nfc?.alertMessage = "Ready to scan NFC tags!"
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        if NFCNDEFReaderSession.readingAvailable {
            nfc?.begin()
        }
    }
    
    func updateLabel(string: String) {
        dataLabel.text = string
    }
    
    // MARK - NFCNDEFReaderSessionDelegate
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        let data = NDEFMessageWithWellKnownTypes(records: messages[0].records)
        if let string = data?.records.flatMap({ $0.recordDescription }).joined(separator: "\n") {
            print(string)
            DispatchQueue.main.async {
                self.updateLabel(string: "Data: \n" + string)
            }
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("Session invalidated: \(error.localizedDescription)")
        self.initializeNFCSession()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
