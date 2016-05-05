//
//  MRSimpleStatisticsTileUIView.m
//  TwitterStreamingAPIAssignment
//
//  Created by Mark Rabenhorst on 5/4/16.
//  Copyright © 2016 Mark Rabenhorst. All rights reserved.
//

#import "MRSimpleStatisticsTileUIView.h"

@implementation MRSimpleStatisticsTileUIView


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
    
    //// Rectangle 5 Drawing
    UIBezierPath* rectangle5Path = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame) + 15, CGRectGetMinY(frame) + 8, CGRectGetWidth(frame) - 30, CGRectGetHeight(frame) - 16)];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, centeredShadow.shadowOffset, centeredShadow.shadowBlurRadius, [centeredShadow.shadowColor CGColor]);
    [color setFill];
    [rectangle5Path fill];
    CGContextRestoreGState(context);
    
    
    
    //// title Drawing
    CGRect titleRect = CGRectMake(CGRectGetMinX(frame) + 20, CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 21) * 0.51429 + 0.5), 140, 21);
    {
        NSString* textContent = self.title;
        NSMutableParagraphStyle* titleStyle = [NSMutableParagraphStyle new];
        titleStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary* titleFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 15], NSForegroundColorAttributeName: UIColor.darkGrayColor, NSParagraphStyleAttributeName: titleStyle};
        
        CGFloat titleTextHeight = [textContent boundingRectWithSize: CGSizeMake(titleRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: titleFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, titleRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(titleRect), CGRectGetMinY(titleRect) + (CGRectGetHeight(titleRect) - titleTextHeight) / 2, CGRectGetWidth(titleRect), titleTextHeight) withAttributes: titleFontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// subtitle Drawing
    CGRect subtitleRect = CGRectMake(CGRectGetMinX(frame) + CGRectGetWidth(frame) - 123, CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 21) * 0.51429 + 0.5), 103, 21);
    {
        NSString* textContent = self.subtitle;
        NSMutableParagraphStyle* subtitleStyle = [NSMutableParagraphStyle new];
        subtitleStyle.alignment = NSTextAlignmentRight;
        
        NSDictionary* subtitleFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 15], NSForegroundColorAttributeName: UIColor.darkGrayColor, NSParagraphStyleAttributeName: subtitleStyle};
        
        CGFloat subtitleTextHeight = [textContent boundingRectWithSize: CGSizeMake(subtitleRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: subtitleFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, subtitleRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(subtitleRect), CGRectGetMinY(subtitleRect) + (CGRectGetHeight(subtitleRect) - subtitleTextHeight) / 2, CGRectGetWidth(subtitleRect), subtitleTextHeight) withAttributes: subtitleFontAttributes];
        CGContextRestoreGState(context);
    }
    

}


@end
