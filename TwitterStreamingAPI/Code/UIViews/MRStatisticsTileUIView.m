//
//  MRStatisticsTileUIView.m
//  TwitterStreamingAPIAssignment
//
//  Created by Mark Rabenhorst on 5/4/16.
//  Copyright © 2016 Mark Rabenhorst. All rights reserved.
//

#import "MRStatisticsTileUIView.h"

@implementation MRStatisticsTileUIView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGRect frame = rect;
    
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* color2 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    
    //// Shadow Declarations
    NSShadow* centeredShadow = [[NSShadow alloc] init];
    [centeredShadow setShadowColor: [UIColor.blackColor colorWithAlphaComponent: 0.4]];
    [centeredShadow setShadowOffset: CGSizeMake(1.1, 1.1)];
    [centeredShadow setShadowBlurRadius: 2];
    
    //// Rectangle 8 Drawing
    UIBezierPath* rectangle8Path = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame) + 15, CGRectGetMinY(frame) + 8, CGRectGetWidth(frame) - 30, CGRectGetHeight(frame) - 16)];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, centeredShadow.shadowOffset, centeredShadow.shadowBlurRadius, [centeredShadow.shadowColor CGColor]);
    [color setFill];
    [rectangle8Path fill];
    CGContextRestoreGState(context);
    
    
    
    //// Bezier 7 Drawing
    UIBezierPath* bezier7Path = [UIBezierPath bezierPath];
    [bezier7Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.06250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 33)];
    [bezier7Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.93750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 33)];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, centeredShadow.shadowOffset, centeredShadow.shadowBlurRadius, [centeredShadow.shadowColor CGColor]);
    [color2 setFill];
    [bezier7Path fill];
    CGContextRestoreGState(context);
    
    [UIColor.blackColor setStroke];
    bezier7Path.lineWidth = 0.25;
    [bezier7Path stroke];
    
    
    //// title Drawing
    CGRect titleRect = CGRectMake(CGRectGetMinX(frame) + 20, CGRectGetMinY(frame) + 10, 140, 21);
    {
        NSString* textContent = self.title;
        NSMutableParagraphStyle* titleStyle = [NSMutableParagraphStyle new];
        titleStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary* titleFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-Medium" size: 15], NSForegroundColorAttributeName: UIColor.darkGrayColor, NSParagraphStyleAttributeName: titleStyle};
        
        CGFloat titleTextHeight = [textContent boundingRectWithSize: CGSizeMake(titleRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: titleFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, titleRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(titleRect), CGRectGetMinY(titleRect) + (CGRectGetHeight(titleRect) - titleTextHeight) / 2, CGRectGetWidth(titleRect), titleTextHeight) withAttributes: titleFontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// rank1title Drawing
    CGRect rank1titleRect = CGRectMake(CGRectGetMinX(frame) + 37, CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 21) * 0.42105 + 0.5), 177, 21);
    {
        NSString* textContent = self.rank1Title;
        NSMutableParagraphStyle* rank1titleStyle = [NSMutableParagraphStyle new];
        rank1titleStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary* rank1titleFontAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize: UIFont.systemFontSize], NSForegroundColorAttributeName: UIColor.grayColor, NSParagraphStyleAttributeName: rank1titleStyle};
        
        CGFloat rank1titleTextHeight = [textContent boundingRectWithSize: CGSizeMake(rank1titleRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: rank1titleFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, rank1titleRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(rank1titleRect), CGRectGetMinY(rank1titleRect) + (CGRectGetHeight(rank1titleRect) - rank1titleTextHeight) / 2, CGRectGetWidth(rank1titleRect), rank1titleTextHeight) withAttributes: rank1titleFontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// rank2title Drawing
    CGRect rank2titleRect = CGRectMake(CGRectGetMinX(frame) + 37, CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 21) * 0.64211 + 0.5), 177, 21);
    {
        NSString* textContent = self.rank2Title;
        NSMutableParagraphStyle* rank2titleStyle = [NSMutableParagraphStyle new];
        rank2titleStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary* rank2titleFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-Medium" size: UIFont.smallSystemFontSize], NSForegroundColorAttributeName: UIColor.grayColor, NSParagraphStyleAttributeName: rank2titleStyle};
        
        CGFloat rank2titleTextHeight = [textContent boundingRectWithSize: CGSizeMake(rank2titleRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: rank2titleFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, rank2titleRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(rank2titleRect), CGRectGetMinY(rank2titleRect) + (CGRectGetHeight(rank2titleRect) - rank2titleTextHeight) / 2, CGRectGetWidth(rank2titleRect), rank2titleTextHeight) withAttributes: rank2titleFontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// rank3title Drawing
    CGRect rank3titleRect = CGRectMake(CGRectGetMinX(frame) + 37, CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 21) * 0.86316 + 0.5), 177, 21);
    {
        NSString* textContent = self.rank3Title;
        NSMutableParagraphStyle* rank3titleStyle = [NSMutableParagraphStyle new];
        rank3titleStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary* rank3titleFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-Regular" size: 10], NSForegroundColorAttributeName: UIColor.grayColor, NSParagraphStyleAttributeName: rank3titleStyle};
        
        CGFloat rank3titleTextHeight = [textContent boundingRectWithSize: CGSizeMake(rank3titleRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: rank3titleFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, rank3titleRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(rank3titleRect), CGRectGetMinY(rank3titleRect) + (CGRectGetHeight(rank3titleRect) - rank3titleTextHeight) / 2, CGRectGetWidth(rank3titleRect), rank3titleTextHeight) withAttributes: rank3titleFontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// subtitle Drawing
    CGRect subtitleRect = CGRectMake(CGRectGetMinX(frame) + CGRectGetWidth(frame) - 160, CGRectGetMinY(frame) + 10, 140, 21);
    {
        NSString* textContent = self.subtitle;
        NSMutableParagraphStyle* subtitleStyle = [NSMutableParagraphStyle new];
        subtitleStyle.alignment = NSTextAlignmentRight;
        
        NSDictionary* subtitleFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-MediumItalic" size: 15], NSForegroundColorAttributeName: UIColor.darkGrayColor, NSParagraphStyleAttributeName: subtitleStyle};
        
        CGFloat subtitleTextHeight = [textContent boundingRectWithSize: CGSizeMake(subtitleRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: subtitleFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, subtitleRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(subtitleRect), CGRectGetMinY(subtitleRect) + (CGRectGetHeight(subtitleRect) - subtitleTextHeight) / 2, CGRectGetWidth(subtitleRect), subtitleTextHeight) withAttributes: subtitleFontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// Bezier 8 Drawing
    UIBezierPath* bezier8Path = [UIBezierPath bezierPath];
    [bezier8Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.06250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 34)];
    [bezier8Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.93750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 34)];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, centeredShadow.shadowOffset, centeredShadow.shadowBlurRadius, [centeredShadow.shadowColor CGColor]);
    [color2 setFill];
    [bezier8Path fill];
    CGContextRestoreGState(context);
    
    [UIColor.lightGrayColor setStroke];
    bezier8Path.lineWidth = 0.25;
    [bezier8Path stroke];
    
    
    //// rank1subtitle Drawing
    CGRect rank1subtitleRect = CGRectMake(CGRectGetMinX(frame) + CGRectGetWidth(frame) - 123, CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 21) * 0.42105 + 0.5), 103, 21);
    {
        NSString* textContent = self.rank1Subtitle;
        NSMutableParagraphStyle* rank1subtitleStyle = [NSMutableParagraphStyle new];
        rank1subtitleStyle.alignment = NSTextAlignmentRight;
        
        NSDictionary* rank1subtitleFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-DemiBoldItalic" size: UIFont.systemFontSize], NSForegroundColorAttributeName: UIColor.grayColor, NSParagraphStyleAttributeName: rank1subtitleStyle};
        
        CGFloat rank1subtitleTextHeight = [textContent boundingRectWithSize: CGSizeMake(rank1subtitleRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: rank1subtitleFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, rank1subtitleRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(rank1subtitleRect), CGRectGetMinY(rank1subtitleRect) + (CGRectGetHeight(rank1subtitleRect) - rank1subtitleTextHeight) / 2, CGRectGetWidth(rank1subtitleRect), rank1subtitleTextHeight) withAttributes: rank1subtitleFontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// rank2subtitle Drawing
    CGRect rank2subtitleRect = CGRectMake(CGRectGetMinX(frame) + CGRectGetWidth(frame) - 123, CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 21) * 0.64211 + 0.5), 103, 21);
    {
        NSString* textContent = self.rank2Subtitle;
        NSMutableParagraphStyle* rank2subtitleStyle = [NSMutableParagraphStyle new];
        rank2subtitleStyle.alignment = NSTextAlignmentRight;
        
        NSDictionary* rank2subtitleFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-MediumItalic" size: UIFont.smallSystemFontSize], NSForegroundColorAttributeName: UIColor.grayColor, NSParagraphStyleAttributeName: rank2subtitleStyle};
        
        CGFloat rank2subtitleTextHeight = [textContent boundingRectWithSize: CGSizeMake(rank2subtitleRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: rank2subtitleFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, rank2subtitleRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(rank2subtitleRect), CGRectGetMinY(rank2subtitleRect) + (CGRectGetHeight(rank2subtitleRect) - rank2subtitleTextHeight) / 2, CGRectGetWidth(rank2subtitleRect), rank2subtitleTextHeight) withAttributes: rank2subtitleFontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// rank3subtitle Drawing
    CGRect rank3subtitleRect = CGRectMake(CGRectGetMinX(frame) + CGRectGetWidth(frame) - 123, CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 21) * 0.86316 + 0.5), 103, 21);
    {
        NSString* textContent = self.rank3Subtitle;
        NSMutableParagraphStyle* rank3subtitleStyle = [NSMutableParagraphStyle new];
        rank3subtitleStyle.alignment = NSTextAlignmentRight;
        
        NSDictionary* rank3subtitleFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-Italic" size: 10], NSForegroundColorAttributeName: UIColor.grayColor, NSParagraphStyleAttributeName: rank3subtitleStyle};
        
        CGFloat rank3subtitleTextHeight = [textContent boundingRectWithSize: CGSizeMake(rank3subtitleRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: rank3subtitleFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, rank3subtitleRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(rank3subtitleRect), CGRectGetMinY(rank3subtitleRect) + (CGRectGetHeight(rank3subtitleRect) - rank3subtitleTextHeight) / 2, CGRectGetWidth(rank3subtitleRect), rank3subtitleTextHeight) withAttributes: rank3subtitleFontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// Text Drawing
    CGRect textRect = CGRectMake(CGRectGetMinX(frame) + 20, CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 21) * 0.42105 + 0.5), 17, 21);
    {
        NSString* textContent = @"#1";
        NSMutableParagraphStyle* textStyle = [NSMutableParagraphStyle new];
        textStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize: UIFont.systemFontSize], NSForegroundColorAttributeName: UIColor.grayColor, NSParagraphStyleAttributeName: textStyle};
        
        CGFloat textTextHeight = [textContent boundingRectWithSize: CGSizeMake(textRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, textRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (CGRectGetHeight(textRect) - textTextHeight) / 2, CGRectGetWidth(textRect), textTextHeight) withAttributes: textFontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// Text 2 Drawing
    CGRect text2Rect = CGRectMake(CGRectGetMinX(frame) + 20, CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 21) * 0.64211 + 0.5), 17, 21);
    {
        NSString* textContent = @"#2";
        NSMutableParagraphStyle* text2Style = [NSMutableParagraphStyle new];
        text2Style.alignment = NSTextAlignmentCenter;
        
        NSDictionary* text2FontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-Medium" size: UIFont.smallSystemFontSize], NSForegroundColorAttributeName: UIColor.grayColor, NSParagraphStyleAttributeName: text2Style};
        
        CGFloat text2TextHeight = [textContent boundingRectWithSize: CGSizeMake(text2Rect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: text2FontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, text2Rect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(text2Rect), CGRectGetMinY(text2Rect) + (CGRectGetHeight(text2Rect) - text2TextHeight) / 2, CGRectGetWidth(text2Rect), text2TextHeight) withAttributes: text2FontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// third Drawing
    CGRect thirdRect = CGRectMake(CGRectGetMinX(frame) + 20, CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - 21) * 0.86316 + 0.5), 17, 21);
    {
        NSString* textContent = @"#3";
        NSMutableParagraphStyle* thirdStyle = [NSMutableParagraphStyle new];
        thirdStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary* thirdFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"AvenirNext-Regular" size: 10], NSForegroundColorAttributeName: UIColor.grayColor, NSParagraphStyleAttributeName: thirdStyle};
        
        CGFloat thirdTextHeight = [textContent boundingRectWithSize: CGSizeMake(thirdRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: thirdFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, thirdRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(thirdRect), CGRectGetMinY(thirdRect) + (CGRectGetHeight(thirdRect) - thirdTextHeight) / 2, CGRectGetWidth(thirdRect), thirdTextHeight) withAttributes: thirdFontAttributes];
        CGContextRestoreGState(context);
    }

}

@end
