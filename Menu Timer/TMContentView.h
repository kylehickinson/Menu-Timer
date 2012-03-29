//
//  TMContentView.h
//  Time Me
//
//  Created by Kyle Hickinson on 11-04-11.
//  Copyright 2011 Kyle Hickinson. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TMContentView : NSView {
@private
    NSButton *_startButton;
    NSButton *_pauseButton;
    NSButton *_quitButton;
    
    NSTextField *_timeLabel;
    
    NSTimer *_timer;
    
    BOOL _isPaused;
    
    NSTimeInterval _timeInterval;
}

@end
