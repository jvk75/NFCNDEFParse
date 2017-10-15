//
//  ViewController.m
//  objc-test
//
//  Created by Jari Kalinainen on 14.10.17.
//  Copyright © 2017 Jari Kalinainen. All rights reserved.
//

#import "ViewController.h"
#import "NFC_ObjC-Swift.h" //Xcode generated file, will be generated automatically during first build

@interface ViewController ()

@end

@implementation ViewController

NFCNDEFReaderSession *nfc;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeNFCSession];
}

-(void)initializeNFCSession {
    if (nfc != nil) {
        [nfc invalidateSession];
        nfc = nil;
    }
    nfc = [[NFCNDEFReaderSession alloc] initWithDelegate:self queue:nil invalidateAfterFirstRead:NO];
    nfc.alertMessage = @"Ready to scan NFC tags!";
}

- (IBAction)buttonPressed:(id)sender {
    if (NFCNDEFReaderSession.readingAvailable) {
        [nfc beginSession];
    }
}

-(void)updateLabel:(NSString *)string {
    _dataLabel.text = string;
}

// MARK - NFCNDEFReaderSessionDelegate
-(void)readerSession:(NFCNDEFReaderSession *)session didDetectNDEFs:(NSArray<NFCNDEFMessage *> *)messages {
    NDEFMessageWithWellKnownTypes *data = [[NDEFMessageWithWellKnownTypes alloc] initWithRecords: [messages[0] records]];
    NSMutableString *string = [[NSMutableString alloc] initWithString:@"Data:\n"];
    for (int i = 0; i< data.records.count; i++) {
        [string appendString:[NSString stringWithFormat:@"%@\n", data.records[i].recordDescription]];
    }
    NSLog(@"%@",string);
    [self performSelectorOnMainThread:@selector(updateLabel:) withObject:string waitUntilDone:NO];
}

-(void)readerSession:(NFCNDEFReaderSession *)session didInvalidateWithError:(NSError *)error {
    NSLog(@"Session invalidated: %@", error.localizedDescription);
    [self initializeNFCSession];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
