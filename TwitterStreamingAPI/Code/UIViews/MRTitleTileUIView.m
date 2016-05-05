//
//  MRTitleTileUIView.m
//  TwitterStreamingAPIAssignment
//
//  Created by Mark Rabenhorst on 5/4/16.
//  Copyright © 2016 Mark Rabenhorst. All rights reserved.
//

#import "MRTitleTileUIView.h"

@implementation MRTitleTileUIView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGRect frame = rect;
    
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    
    //// Shadow Declarations
    NSShadow* centeredShadow = [[NSShadow alloc] init];
    [centeredShadow setShadowColor: [UIColor.blackColor colorWithAlphaComponent: 0.4]];
    [centeredShadow setShadowOffset: CGSizeMake(1.1, 1.1)];
    [centeredShadow setShadowBlurRadius: 2];
    
    //// Rectangle 8 Drawing
    UIBezierPath* rectangle8Path = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame) + 15, CGRectGetMinY(frame) + 8, CGRectGetWidth(frame) - 29, CGRectGetHeight(frame) - 16)];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, centeredShadow.shadowOffset, centeredShadow.shadowBlurRadius, [centeredShadow.shadowColor CGColor]);
    [color setFill];
    [rectangle8Path fill];
    CGContextRestoreGState(context);
    
    
    
    //// title Drawing
    CGRect titleRect = CGRectMake(CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 290) * 0.51724 + 0.5), CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 37) * 0.50000 + 0.5), 290, 37);
    {
        NSString* textContent = self.title;
        NSMutableParagraphStyle* titleStyle = [NSMutableParagraphStyle new];
        titleStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary* titleFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-Medium" size: 25], NSForegroundColorAttributeName: UIColor.darkGrayColor, NSParagraphStyleAttributeName: titleStyle};
        
        CGFloat titleTextHeight = [textContent boundingRectWithSize: CGSizeMake(titleRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: titleFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, titleRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(titleRect), CGRectGetMinY(titleRect) + (CGRectGetHeight(titleRect) - titleTextHeight) / 2, CGRectGetWidth(titleRect), titleTextHeight) withAttributes: titleFontAttributes];
        CGContextRestoreGState(context);
    }

}

@end
