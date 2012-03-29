//
//  Time_MeAppDelegate.h
//  Time Me
//
//  Created by Kyle Hickinson on 11-04-09.
//  Copyright 2011 Kyle Hickinson. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TMContentView;
@class INAppStoreWindow;

@interface Menu_TimerAppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate> {
@private
    NSStatusItem *_statusItem;
}

@property (nonatomic, strong) NSStatusItem *statusItem;

- (void)statusItemClicked:(id)sender;

@end
