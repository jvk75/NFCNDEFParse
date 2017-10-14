//
//  ViewController.h
//  objc-test
//
//  Created by Jari Kalinainen on 14.10.17.
//  Copyright © 2017 Jari Kalinainen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreNfc/CoreNFC.h>

@interface ViewController : UIViewController <NFCNDEFReaderSessionDelegate>

- (IBAction)buttonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;

@end

