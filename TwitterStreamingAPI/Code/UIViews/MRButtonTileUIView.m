//
//  MRButtonTileUIView.m
//  TwitterStreamingAPIAssignment
//
//  Created by Mark Rabenhorst on 5/5/16.
//  Copyright © 2016 Mark Rabenhorst. All rights reserved.
//

#import "MRButtonTileUIView.h"

@implementation MRButtonTileUIView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
   
    CGRect frame = rect;
    
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Shadow Declarations
    NSShadow* centeredShadow = [[NSShadow alloc] init];
    [centeredShadow setShadowColor: [UIColor.blackColor colorWithAlphaComponent: 0.4]];
    [centeredShadow setShadowOffset: CGSizeMake(1.1, 1.1)];
    [centeredShadow setShadowBlurRadius: 2];
    
    //// Rectangle 6 Drawing
    UIBezierPath* rectangle6Path = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame) + 15, CGRectGetMinY(frame) + 8, CGRectGetWidth(frame) - 30, CGRectGetHeight(frame) - 19)];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, centeredShadow.shadowOffset, centeredShadow.shadowBlurRadius, [centeredShadow.shadowColor CGColor]);
    [self.color setFill];
    [rectangle6Path fill];
    CGContextRestoreGState(context);
    
    
    
    //// title Drawing
    CGRect titleRect = CGRectMake(CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 290) * 0.50000 + 0.5), CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 29) * 0.44444 + 0.5), 290, 29);
    {
        NSString* textContent = self.title;
        NSMutableParagraphStyle* titleStyle = [NSMutableParagraphStyle new];
        titleStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary* titleFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-DemiBold" size: 22], NSForegroundColorAttributeName: UIColor.whiteColor, NSParagraphStyleAttributeName: titleStyle};
        
        CGFloat titleTextHeight = [textContent boundingRectWithSize: CGSizeMake(titleRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: titleFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, titleRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(titleRect), CGRectGetMinY(titleRect) + (CGRectGetHeight(titleRect) - titleTextHeight) / 2, CGRectGetWidth(titleRect), titleTextHeight) withAttributes: titleFontAttributes];
        CGContextRestoreGState(context);
    }
    


}

@end
