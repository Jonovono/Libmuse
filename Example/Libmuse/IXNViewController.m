//
//  IXNViewController.m
//  Libmuse
//
//  Created by 'Jordan Howlett' on 01/10/2017.
//  Copyright (c) 2017 'Jordan Howlett'. All rights reserved.
//

#import "IXNViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface IXNViewController ()
@property IXNMuseManagerIos * manager;
@property (weak, nonatomic) IXNMuse *muse;

@end

@implementation IXNViewController

- (void)viewDidLoad
{
    NSLog(@"TEST");
    [super viewDidLoad];
    
    if (!self.manager) {
        self.manager = [IXNMuseManagerIos sharedManager];
    }
    
    [self.manager setMuseListener:self];
    
    [self connect];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)museListChanged {
    NSArray * muses = [self.manager getMuses];
    
    NSLog(@"MUSES %d", [muses count]);
    
    for (int i = 0; i < [muses count]; i++) {
        IXNMuse * m = [[self.manager getMuses] objectAtIndex:i];
        NSLog(@"NAME %@", [m getName]);
    }
    
//    if (indexPath.row < [muses count]) {
//        IXNMuse * muse = [[self.manager getMuses] objectAtIndex:indexPath.row];
//        cell.textLabel.text = [muse getName];
//        if (![muse isLowEnergy]) {
//            cell.textLabel.text = [cell.textLabel.text stringByAppendingString:
//                                   [muse getMacAddress]];
//        }
//    }
    
}

-(void)receiveMuseDataPacket:(IXNMuseDataPacket *)packet muse:(IXNMuse *)muse {
    NSLog(@"test");
}

-(void)receiveMuseArtifactPacket:(IXNMuseArtifactPacket *)packet muse:(IXNMuse *)muse {
    NSLog(@"ART");
}

-(void)receiveLog:(IXNLogPacket *)log {
    NSLog(@"LOG");
}

- (void) connect {
    NSLog(@"CONNECT");
    [self.muse registerConnectionListener:self];
    [self.muse registerDataListener:self
                               type:IXNMuseDataPacketTypeArtifacts];
    [self.muse registerDataListener:self
                               type:IXNMuseDataPacketTypeAlphaAbsolute];
    /*
     [self.muse registerDataListener:self
     type:IXNMuseDataPacketTypeEeg];
     */
    [self.muse runAsynchronously];
    
    [self.manager startListening];
}

- (void)receiveMuseConnectionPacket:(IXNMuseConnectionPacket *)packet muse:(IXNMuse *)muse {
    NSLog(@"CONNECT");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
