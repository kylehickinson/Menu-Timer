//
//  TMPopupView.h
//  Time Me
//
//  Created by Kyle Hickinson on 11-04-10.
//  Copyright 2011 Kyle Hickinson. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TMContentView;

@interface TMPopupView : NSView {
@private
    NSRect _contentFrame;
    
    TMContentView *_contentView;
}

@property (assign) NSRect contentFrame;

@end
