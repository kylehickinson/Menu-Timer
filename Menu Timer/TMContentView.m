//
//  TMContentView.m
//  Time Me
//
//  Created by Kyle Hickinson on 11-04-11.
//  Copyright 2011 Kyle Hickinson. All rights reserved.
//

#import "TMContentView.h"

@interface TMContentView ()
- (void)_setupButton:(NSButton *)button title:(NSString *)title target:(id)target action:(SEL)action;
@end

@implementation TMContentView

- (id)initWithFrame:(NSRect)frame {
    if ((self = [super initWithFrame:frame])) {
        _startButton = [[NSButton alloc] initWithFrame:NSMakeRect(10, 10, 50, 23)];
        _pauseButton = [[NSButton alloc] initWithFrame:NSMakeRect(70, 10, 50, 23)];
        _quitButton = [[NSButton alloc] initWithFrame:NSMakeRect(130, 10, 50, 23)];
        
        [self _setupButton:_startButton title:@"Start" target:self action:@selector(startTimer:)];
        [self _setupButton:_pauseButton title:@"Pause" target:self action:@selector(pauseTimer:)];
        [self _setupButton:_quitButton title:@"Quit" target:self action:@selector(quitApp:)];
        
        [_pauseButton setEnabled:NO];
        
        _timeLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(10, 40, self.frame.size.width-20, 40)];
        [_timeLabel setStringValue:@"00:00:00"];
        [_timeLabel setEditable:NO];
        [_timeLabel setBordered:NO];
        [_timeLabel setFont:[NSFont systemFontOfSize:32.0f]];
        [_timeLabel setBackgroundColor:[NSColor windowBackgroundColor]];
        [_timeLabel setAlignment:NSCenterTextAlignment];
        
        [self addSubview:_startButton];
        [self addSubview:_pauseButton];
        [self addSubview:_quitButton];
        [self addSubview:_timeLabel];
        
        _timeInterval = 0;
    }
    return self;
}

- (void)_setupButton:(NSButton *)button title:(NSString *)title target:(id)target action:(SEL)action { 
    [button setBezelStyle:NSTexturedRoundedBezelStyle];
    [button setTitle:title];
    [button setTarget:target];
    [button setButtonType:NSMomentaryPushInButton];
    [button setAction:action];
    [[button cell] setControlSize:NSSmallControlSize];
    [button setFont:[NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:NSSmallControlSize]]];
}

- (void)drawRect:(NSRect)dirtyRect {
    [[NSColor windowBackgroundColor] set];
    NSRectFill([self frame]);
}

- (void)updateTimer {
    _timeInterval++;
    
    NSInteger hours   = (NSInteger)floor(_timeInterval / 60 / 60);
    NSInteger minutes = (NSInteger)floor(round(_timeInterval - hours * 3600) / 60);
    NSInteger seconds = (NSInteger)round((_timeInterval - hours * 3600) - minutes * 60);
    
    [_timeLabel setStringValue:[NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds]];
}

- (void)startTimer:(id)sender {
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [_pauseButton setEnabled:YES];
    [_startButton setEnabled:NO];
    [_pauseButton setTitle:@"Pause"];
}
- (void)pauseTimer:(id)sender {
    if ([_timer isValid]) {
        [_timer invalidate];
        [_pauseButton setTitle:@"Reset"];
        [_startButton setEnabled:YES];
    } else {
        // Reset
        _timeInterval = 0;
        [_timeLabel setStringValue:@"00:00:00"];
        [_pauseButton setTitle:@"Pause"];
        [_pauseButton setEnabled:NO];
        [_startButton setEnabled:YES];
    }
}

- (void)quitApp:(id)sender {
    [[NSApplication sharedApplication] terminate:nil];
}

@end
