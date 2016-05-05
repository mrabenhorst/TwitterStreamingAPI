//
//  MRTweetRateTileUIView.m
//  TwitterStreamingAPIAssignment
//
//  Created by Mark Rabenhorst on 5/4/16.
//  Copyright © 2016 Mark Rabenhorst. All rights reserved.
//

#import "MRTweetRateTileUIView.h"

@implementation MRTweetRateTileUIView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGRect frame = rect;
    
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //// Shadow Declarations
    NSShadow* centeredShadow = [[NSShadow alloc] init];
    [centeredShadow setShadowColor: [UIColor.blackColor colorWithAlphaComponent: 0.4]];
    [centeredShadow setShadowOffset: CGSizeMake(1.1, 1.1)];
    [centeredShadow setShadowBlurRadius: 2];
    
    //// title Drawing
    CGRect titleRect = CGRectMake(CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 108) * 0.50000 + 0.5), CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 26) * 0.20000 + 0.5), 108, 26);
    {
        NSString* textContent = self.title;
        NSMutableParagraphStyle* titleStyle = [NSMutableParagraphStyle new];
        titleStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary* titleFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-DemiBold" size: 27], NSForegroundColorAttributeName: UIColor.grayColor, NSParagraphStyleAttributeName: titleStyle};
        
        CGFloat titleTextHeight = [textContent boundingRectWithSize: CGSizeMake(titleRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: titleFontAttributes context: nil].size.height;
        CGRect titleTextRect = CGRectMake(CGRectGetMinX(titleRect), CGRectGetMinY(titleRect) + (CGRectGetHeight(titleRect) - titleTextHeight) / 2, CGRectGetWidth(titleRect), titleTextHeight);
        CGContextSaveGState(context);
        CGContextClipToRect(context, titleRect);
        [textContent drawInRect: titleTextRect withAttributes: titleFontAttributes];
        CGContextRestoreGState(context);
        
        ////// title Text Inner Shadow
        CGContextSaveGState(context);
        UIRectClip(titleRect);
        CGContextSetShadowWithColor(context, CGSizeZero, 0, NULL);
        
        CGContextSetAlpha(context, CGColorGetAlpha([centeredShadow.shadowColor CGColor]));
        CGContextBeginTransparencyLayer(context, NULL);
        {
            UIColor* opaqueShadow = [centeredShadow.shadowColor colorWithAlphaComponent: 1];
            CGContextSetShadowWithColor(context, centeredShadow.shadowOffset, centeredShadow.shadowBlurRadius, [opaqueShadow CGColor]);
            
            CGContextSetBlendMode(context, kCGBlendModeSourceOut);
            CGContextBeginTransparencyLayer(context, NULL);
            
            NSDictionary* titleFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-DemiBold" size: 27], NSForegroundColorAttributeName: opaqueShadow, NSParagraphStyleAttributeName: titleStyle};
            [textContent drawInRect: titleTextRect withAttributes: titleFontAttributes];
            
            CGContextEndTransparencyLayer(context);
        }
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
    }
    
    
    //// subtitleLeft Drawing
    CGRect subtitleLeftRect = CGRectMake(CGRectGetMinX(frame) + 15, CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 21) * 0.82222 + 0.5), 108, 21);
    {
        NSString* textContent = self.subtitleLeft;
        NSMutableParagraphStyle* subtitleLeftStyle = [NSMutableParagraphStyle new];
        subtitleLeftStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary* subtitleLeftFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-Regular" size: UIFont.smallSystemFontSize], NSForegroundColorAttributeName: UIColor.grayColor, NSParagraphStyleAttributeName: subtitleLeftStyle};
        
        CGFloat subtitleLeftTextHeight = [textContent boundingRectWithSize: CGSizeMake(subtitleLeftRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: subtitleLeftFontAttributes context: nil].size.height;
        CGRect subtitleLeftTextRect = CGRectMake(CGRectGetMinX(subtitleLeftRect), CGRectGetMinY(subtitleLeftRect) + (CGRectGetHeight(subtitleLeftRect) - subtitleLeftTextHeight) / 2, CGRectGetWidth(subtitleLeftRect), subtitleLeftTextHeight);
        CGContextSaveGState(context);
        CGContextClipToRect(context, subtitleLeftRect);
        [textContent drawInRect: subtitleLeftTextRect withAttributes: subtitleLeftFontAttributes];
        CGContextRestoreGState(context);
        
        ////// subtitleLeft Text Inner Shadow
        CGContextSaveGState(context);
        UIRectClip(subtitleLeftRect);
        CGContextSetShadowWithColor(context, CGSizeZero, 0, NULL);
        
        CGContextSetAlpha(context, CGColorGetAlpha([centeredShadow.shadowColor CGColor]));
        CGContextBeginTransparencyLayer(context, NULL);
        {
            UIColor* opaqueShadow = [centeredShadow.shadowColor colorWithAlphaComponent: 1];
            CGContextSetShadowWithColor(context, centeredShadow.shadowOffset, centeredShadow.shadowBlurRadius, [opaqueShadow CGColor]);
            
            CGContextSetBlendMode(context, kCGBlendModeSourceOut);
            CGContextBeginTransparencyLayer(context, NULL);
            
            NSDictionary* subtitleLeftFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-Regular" size: UIFont.smallSystemFontSize], NSForegroundColorAttributeName: opaqueShadow, NSParagraphStyleAttributeName: subtitleLeftStyle};
            [textContent drawInRect: subtitleLeftTextRect withAttributes: subtitleLeftFontAttributes];
            
            CGContextEndTransparencyLayer(context);
        }
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
    }
    
    
    //// subtitleCenter Drawing
    CGRect subtitleCenterRect = CGRectMake(CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - 108) * 0.50000 + 0.5), CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 21) * 0.82222 + 0.5), 108, 21);
    {
        NSString* textContent = self.subtitleCenter;
        NSMutableParagraphStyle* subtitleCenterStyle = [NSMutableParagraphStyle new];
        subtitleCenterStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary* subtitleCenterFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-Regular" size: UIFont.smallSystemFontSize], NSForegroundColorAttributeName: UIColor.grayColor, NSParagraphStyleAttributeName: subtitleCenterStyle};
        
        CGFloat subtitleCenterTextHeight = [textContent boundingRectWithSize: CGSizeMake(subtitleCenterRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: subtitleCenterFontAttributes context: nil].size.height;
        CGRect subtitleCenterTextRect = CGRectMake(CGRectGetMinX(subtitleCenterRect), CGRectGetMinY(subtitleCenterRect) + (CGRectGetHeight(subtitleCenterRect) - subtitleCenterTextHeight) / 2, CGRectGetWidth(subtitleCenterRect), subtitleCenterTextHeight);
        CGContextSaveGState(context);
        CGContextClipToRect(context, subtitleCenterRect);
        [textContent drawInRect: subtitleCenterTextRect withAttributes: subtitleCenterFontAttributes];
        CGContextRestoreGState(context);
        
        ////// subtitleCenter Text Inner Shadow
        CGContextSaveGState(context);
        UIRectClip(subtitleCenterRect);
        CGContextSetShadowWithColor(context, CGSizeZero, 0, NULL);
        
        CGContextSetAlpha(context, CGColorGetAlpha([centeredShadow.shadowColor CGColor]));
        CGContextBeginTransparencyLayer(context, NULL);
        {
            UIColor* opaqueShadow = [centeredShadow.shadowColor colorWithAlphaComponent: 1];
            CGContextSetShadowWithColor(context, centeredShadow.shadowOffset, centeredShadow.shadowBlurRadius, [opaqueShadow CGColor]);
            
            CGContextSetBlendMode(context, kCGBlendModeSourceOut);
            CGContextBeginTransparencyLayer(context, NULL);
            
            NSDictionary* subtitleCenterFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-Regular" size: UIFont.smallSystemFontSize], NSForegroundColorAttributeName: opaqueShadow, NSParagraphStyleAttributeName: subtitleCenterStyle};
            [textContent drawInRect: subtitleCenterTextRect withAttributes: subtitleCenterFontAttributes];
            
            CGContextEndTransparencyLayer(context);
        }
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
    }
    
    
    //// subtitleRight Drawing
    CGRect subtitleRightRect = CGRectMake(CGRectGetMinX(frame) + CGRectGetWidth(frame) - 123, CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 21) * 0.82222 + 0.5), 108, 21);
    {
        NSString* textContent = self.subtitleRight;
        NSMutableParagraphStyle* subtitleRightStyle = [NSMutableParagraphStyle new];
        subtitleRightStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary* subtitleRightFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-Regular" size: UIFont.smallSystemFontSize], NSForegroundColorAttributeName: UIColor.grayColor, NSParagraphStyleAttributeName: subtitleRightStyle};
        
        CGFloat subtitleRightTextHeight = [textContent boundingRectWithSize: CGSizeMake(subtitleRightRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: subtitleRightFontAttributes context: nil].size.height;
        CGRect subtitleRightTextRect = CGRectMake(CGRectGetMinX(subtitleRightRect), CGRectGetMinY(subtitleRightRect) + (CGRectGetHeight(subtitleRightRect) - subtitleRightTextHeight) / 2, CGRectGetWidth(subtitleRightRect), subtitleRightTextHeight);
        CGContextSaveGState(context);
        CGContextClipToRect(context, subtitleRightRect);
        [textContent drawInRect: subtitleRightTextRect withAttributes: subtitleRightFontAttributes];
        CGContextRestoreGState(context);
        
        ////// subtitleRight Text Inner Shadow
        CGContextSaveGState(context);
        UIRectClip(subtitleRightRect);
        CGContextSetShadowWithColor(context, CGSizeZero, 0, NULL);
        
        CGContextSetAlpha(context, CGColorGetAlpha([centeredShadow.shadowColor CGColor]));
        CGContextBeginTransparencyLayer(context, NULL);
        {
            UIColor* opaqueShadow = [centeredShadow.shadowColor colorWithAlphaComponent: 1];
            CGContextSetShadowWithColor(context, centeredShadow.shadowOffset, centeredShadow.shadowBlurRadius, [opaqueShadow CGColor]);
            
            CGContextSetBlendMode(context, kCGBlendModeSourceOut);
            CGContextBeginTransparencyLayer(context, NULL);
            
            NSDictionary* subtitleRightFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-Regular" size: UIFont.smallSystemFontSize], NSForegroundColorAttributeName: opaqueShadow, NSParagraphStyleAttributeName: subtitleRightStyle};
            [textContent drawInRect: subtitleRightTextRect withAttributes: subtitleRightFontAttributes];
            
            CGContextEndTransparencyLayer(context);
        }
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        
    }

}

@end
