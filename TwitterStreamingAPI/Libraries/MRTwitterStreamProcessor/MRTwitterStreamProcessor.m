//
//  MRTwitterStreamProcessor.m
//  TwitterStreamingAPIAssignment
//
//  Created by Mark Rabenhorst on 5/2/16.
//  Copyright © 2016 Mark Rabenhorst. All rights reserved.
//

#import "MRTwitterStreamProcessor.h"

@implementation MRTwitterStreamProcessor

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tweets = 0;
        self.urlTweets = 0;
        self.emojiTweets = 0;
        self.imageTweets = 0;
        self.hashtagTweets = 0;
        self.emojiCounts = [[NSMutableDictionary alloc] init];
        self.hashtagCounts = [[NSMutableDictionary alloc] init];
        self.urlDomainCounts = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)processTweet:(NSDictionary*) tweet {
    // Dispatch concurrent to optimize speed under heavy traffic input
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self process:tweet];
    });
}

- (void)process:(NSDictionary*) tweet {
    
    // Collect hash tags
    NSMutableArray<NSString *> *hashtags = [NSMutableArray array];
    for( NSDictionary *hashtag in [[tweet objectForKey:@"entities"] objectForKey:@"hashtags"] ) {
        [hashtags addObject:[hashtag objectForKey:@"text"]];
    }
    
    // Collect urls
    NSArray<NSString *> *urls = [[tweet objectForKey:@"entities"] objectForKey:@"urls"];
    NSMutableArray<NSString *> *urlDomains = [NSMutableArray array];
    
    // process urls using regex to find any possible image url (including popular image extensions)
    BOOL hasImage = FALSE;
    for( NSDictionary *url in urls ) {
        
        // Test for image if image hasn't been found - otherwise it's wasted computation
        if( !hasImage ) {
            NSRange range = [[url objectForKey:@"expanded_url"] rangeOfString:@"instagram|pic[.]twitter[.]com|[.]jp[e]*g$|[.]gif$" options:NSRegularExpressionSearch];
            BOOL matches = range.location != NSNotFound;
            
            // Early terminate if found
            if( matches ) {
                hasImage = TRUE;
            }
        }
        
        // Extract domain, using try-catch because sometimes url can be malformed and this will prevent an exception from terminating process
        @try {
            [urlDomains addObject:[self domainFromUrl:[url objectForKey:@"expanded_url"]]];
        }
        @catch (NSException *exception) {
            // Eat it
        }
        
    }
    
    // Collect Emojis using NSString+EmojiTools
    NSArray<NSString *> *emojis = [[tweet objectForKey:@"text"] getEmojis];
    
    // Record changes on sync'ed main queue
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self recordTweetStatsHashtags:hashtags urlDomains:urlDomains emojis:emojis hasImage:hasImage];
    });
}

- (void)recordTweetStatsHashtags:(NSArray*) hashtags urlDomains:(NSArray*) urlDomains emojis:(NSArray*) emojis hasImage:(BOOL) hasImage {
    // By default, increase tweet count
    self.tweets += 1;
    
    // Increment images if tweet had image
    self.imageTweets = hasImage ? self.imageTweets + 1 : self.imageTweets;
    
    // Increment urls if domains >0
    self.urlTweets = [urlDomains count] ? self.urlTweets + 1 : self.urlTweets;
    
    // Increment emojis if emojis >0
    self.emojiTweets = [emojis count] ? self.emojiTweets + 1 : self.emojiTweets;
    
    // Increment hashtags if hashtags >0
    self.hashtagTweets = [hashtags count] ? self.hashtagTweets + 1 : self.hashtagTweets;
    
    // Add domains... If domain exists, increment the count, otherwise add domain with value 1
    for( NSString *domain in urlDomains ) {
        if( [self.urlDomainCounts objectForKey:domain] != nil ) {
            [self.urlDomainCounts setObject:[NSNumber numberWithInt:(int)[[self.urlDomainCounts objectForKey:domain] integerValue] + 1]
                               forKey:domain];
        } else {
            [self.urlDomainCounts setObject:[NSNumber numberWithInt:1]
                               forKey:domain];
        }
    }
    
    // Add hash tags... if tag exists, increment the count, otherwise add hashtag with value 1
    for( NSString *hashtag in hashtags ) {
        if( [self.hashtagCounts objectForKey:hashtag] != nil ) {
            [self.hashtagCounts setObject:[NSNumber numberWithInt:(int)[[self.hashtagCounts objectForKey:hashtag] integerValue] + 1]
                               forKey:hashtag];
        } else {
            [self.hashtagCounts setObject:[NSNumber numberWithInt:1]
                               forKey:hashtag];
        }
    }
    
    // Add emojis... if emoji exists, increment the count, otherwise add emoji with value 1
    for( NSString *emoji in emojis ) {
        if( [self.emojiCounts objectForKey:emoji] != nil ) {
            [self.emojiCounts setObject:[NSNumber numberWithInt:(int)[[self.emojiCounts objectForKey:emoji] integerValue] + 1]
                               forKey:emoji];
        } else {
            [self.emojiCounts setObject:[NSNumber numberWithInt:1]
                               forKey:emoji];
        }
    }
    
    // Let delegate know we've updated
    if( [self.delegate respondsToSelector:@selector(TwitterStreamProcessorUpdated:)] ) {
        [self.delegate TwitterStreamProcessorUpdated:self];
    }
}

- (void)reset {
    self.tweets = 0;
    self.urlTweets = 0;
    self.emojiTweets = 0;
    self.imageTweets = 0;
    self.hashtagTweets = 0;
    [self.emojiCounts removeAllObjects];
    [self.hashtagCounts removeAllObjects];
    [self.urlDomainCounts removeAllObjects];
}

- (NSString*)domainFromUrl:(NSString*) url {
    NSArray<NSString *> *parts = [url componentsSeparatedByString:@"/"];
    for (NSString *part in parts) {
        if( [part rangeOfString:@"."].location != NSNotFound ) {
            // Remove the www. which is a common useless occurance
            return [(NSString*)part stringByReplacingOccurrencesOfString:@"www." withString:@""];
        }
    }
    return nil;
}


- (NSArray*)urlDomains {
    return [_urlDomainCounts allKeys];
}

- (NSArray*)hashtags {
    return [_hashtagCounts allKeys];
}

- (NSArray*)emojis {
    return [_emojiCounts allKeys];
}



@end
