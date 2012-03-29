//
//  Time_MeAppDelegate.m
//  Time Me
//
//  Created by Kyle Hickinson on 11-04-09.
//  Copyright 2011 Kyle Hickinson. All rights reserved.
//

#import "Menu_TimerAppDelegate.h"
#import "TMPopupView.h"
#import "TMContentView.h"

@interface TMWindow : NSWindow @end
@implementation TMWindow
- (BOOL)canBecomeKeyWindow  { return YES; }
- (BOOL)canBecomeMainWindow { return YES; }
@end

@interface Menu_TimerAppDelegate ()
- (void)_createWindow;
- (void)_configStatusItem;
- (NSRect)_statusItemFrame;

@property (nonatomic, strong) TMWindow *window;
@end

@implementation Menu_TimerAppDelegate

@synthesize statusItem = _statusItem;
@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    //
    // MAKE STATUS ITEM
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    //
    // CONFIG STATUS ITEM
    [self _configStatusItem];
        
    //
    // CREATE STATUS WINDOW
    [self _createWindow];
}

- (void)_createWindow {
    NSRect bounds = NSMakeRect(0, 0, 200, 100);
    
    //
    // INIT WINDOW
    _window = [[TMWindow alloc] initWithContentRect:bounds styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];
    
    //
    // CONFIG WINDOW
    [_window setHasShadow:YES];
    [_window setLevel:NSFloatingWindowLevel];
    [_window setOpaque:NO];
    [_window setBackgroundColor:[NSColor clearColor]];
    [_window setCollectionBehavior:NSWindowCollectionBehaviorStationary];
    [_window setDelegate:self];
    
    // 
    // SET NEW CONTENT
    TMPopupView *_tPopupView = [[TMPopupView alloc] initWithFrame:bounds];
    TMContentView *_tContentView = [[TMContentView alloc] initWithFrame:_tPopupView.contentFrame];

    [_window setContentView:_tPopupView];
    [[_window contentView] addSubview:_tContentView];
}

- (void)_configStatusItem {
    [_statusItem setImage:[NSImage imageNamed:@"status_off.png"]];
    [_statusItem setAlternateImage:[NSImage imageNamed:@"status_alt.png"]];
    [_statusItem setHighlightMode:YES];
    [_statusItem setAction:@selector(statusItemClicked:)];
    [_statusItem setTarget:self];
}

- (NSRect)_statusItemFrame { 
    NSView *tempView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 13, [[_statusItem statusBar] thickness])];
    [_statusItem setView:tempView];
    NSRect _frame = [[[_statusItem view] window] frame];
    [_statusItem setView:nil];
    
    //
    // RECONFIGURE STATUS ITEM
    [self _configStatusItem];
    
    return _frame;
}

- (void)dealloc {
    [[NSStatusBar systemStatusBar] removeStatusItem:self.statusItem];
}

- (void)statusItemClicked:(id)sender {
    [[NSAnimationContext currentContext] setDuration:0.15f];
    
    if ([self.window isVisible]) {
        //
        // FADE OUT WINDOW        
        [[self.window animator] setAlphaValue:0.0f];
        [self.window performSelector:@selector(orderOut:) withObject:self afterDelay:0.1];
    } else {        
        //
        // FADE IN WINDOW
        if (self.window.frame.origin.x == 0) {
            NSRect newFrame = [self _statusItemFrame];
            newFrame.origin.y -= self.window.frame.size.height + 5;
            newFrame.origin.x -= (self.window.frame.size.width / 2);
            newFrame.size.width = self.window.frame.size.width;
            newFrame.size.height = self.window.frame.size.height;
            
            [self.window setFrame:newFrame display:NO];
        } else {
            [self.window setFrame:self.window.frame display:NO];
        }
        
        [self.window setAlphaValue:0.0f];        
        [self.window makeKeyAndOrderFront:self];
        [[self.window animator] setAlphaValue:1.0f];
        
        [NSApp activateIgnoringOtherApps:YES];
    }
}

#pragma mark - NSWindowDelegate

- (void)windowDidResignMain:(NSNotification *)notification {
    [self statusItemClicked:self];
}
- (void)windowDidResignKey:(NSNotification *)notification {
    [self statusItemClicked:self];
}

@end
