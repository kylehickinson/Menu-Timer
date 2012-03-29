//
//  TMPopupView.m
//  Time Me
//
//  Created by Kyle Hickinson on 11-04-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TMPopupView.h"
#import "TMContentView.h"

/** Corner clipping radius **/
#define CORNER_CLIP_RADIUS 4.0
#define TRIANGLE_CLIP_BASE 10.0

@implementation TMPopupView

@synthesize contentFrame = _contentFrame;

- (id)initWithFrame:(NSRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.contentFrame = NSMakeRect(frame.origin.x+CORNER_CLIP_RADIUS, frame.origin.y+(CORNER_CLIP_RADIUS + 3), frame.size.width-(CORNER_CLIP_RADIUS * 3), frame.size.height - (CORNER_CLIP_RADIUS * 2) - TRIANGLE_CLIP_BASE - 3);
    }
    return self;
}

#pragma mark - Drawing

- (NSBezierPath*)clippingPathWithRect:(NSRect)aRect cornerRadius:(float)radius {
    NSBezierPath *path = [NSBezierPath bezierPath];
	NSRect rect = NSInsetRect(aRect, radius, radius+(TRIANGLE_CLIP_BASE/2));
    
    [path appendBezierPathWithRoundedRect:rect xRadius:radius yRadius:radius];
//    [[NSColor colorWithCalibratedWhite:0.3 alpha:1.0] setStroke];
    [[NSColor colorWithCalibratedWhite:0.96 alpha:1.0] setStroke];
    [path setLineWidth:2.0f];
    [path stroke];
    
    
    NSBezierPath *tri = [NSBezierPath bezierPath];
    [tri moveToPoint:NSMakePoint(NSMidX(rect)-TRIANGLE_CLIP_BASE, NSMaxY(rect))]; 
    [tri lineToPoint:NSMakePoint(NSMidX(rect), NSMaxY(aRect))];
    [tri lineToPoint:NSMakePoint(NSMidX(rect)+TRIANGLE_CLIP_BASE, NSMaxY(rect))];
    [tri lineToPoint:NSMakePoint(NSMidX(rect)-TRIANGLE_CLIP_BASE, NSMaxY(rect))];
    [tri setLineJoinStyle:NSMiterLineJoinStyle];
    [tri closePath];
    
    // black bg
//    [[NSColor blackColor] setStroke];
    [[NSColor whiteColor] setStroke];
    [tri stroke];
    
    [path setWindingRule:NSNonZeroWindingRule];
    [path appendBezierPath:tri];
    
    [path closePath];
    return path;
}

- (void)drawRect:(NSRect)dirtyRect {
    NSBezierPath *clipPath = [self clippingPathWithRect:dirtyRect cornerRadius:CORNER_CLIP_RADIUS];

    [NSGraphicsContext saveGraphicsState];
    [clipPath addClip];
    
    // black bg
//    [[NSColor colorWithCalibratedWhite:0.1 alpha:0.5] setFill];
    [[NSColor windowBackgroundColor] setFill];
    NSRectFill([self frame]);
    
    [NSGraphicsContext restoreGraphicsState];
}

@end
