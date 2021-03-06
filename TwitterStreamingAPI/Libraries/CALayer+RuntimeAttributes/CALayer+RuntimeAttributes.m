//
//  CALayer+RuntimeAttributes.m
//  TwitterStreamingAPI
//
//  Created by Mark Rabenhorst on 5/18/16.
//  Copyright © 2016 Mark Rabenhorst. All rights reserved.
//

#import "CALayer+RuntimeAttributes.h"

@implementation CALayer (IBConfiguration)

-(void)setShadowUIColor:(nullable UIColor*)color {
    self.shadowColor = color.CGColor;
}

-(nullable UIColor*)shadowUIColor {
    return [UIColor colorWithCGColor:self.shadowColor];
}

@end
