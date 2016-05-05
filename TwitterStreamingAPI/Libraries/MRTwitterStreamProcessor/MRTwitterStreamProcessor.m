//
//  MRTwitterStreamProcessor.m
//  TwitterStreamingAPIAssignment
//
//  Created by Mark Rabenhorst on 5/2/16.
//  Copyright © 2016 Mark Rabenhorst. All rights reserved.
//

#import "MRTwitterStreamProcessor.h"

@implementation MRTwitterStreamProcessor

@synthesize delegate = _delegate;

@synthesize tweets = _tweets;
@synthesize urlTweets = _urlTweets;
@synthesize imageTweets = _imageTweets;
@synthesize emojiTweets = _emojiTweets;
@synthesize hashtagTweets = _hashtagTweets;
@synthesize emojiCounts = _emojiCounts;
@synthesize hashtagCounts = _hashtagCounts;
@synthesize urlDomainCounts = _urlDomainCounts;


- (instancetype)init
{
    self = [super init];
    if (self) {
        _tweets = 0;
        _urlTweets = 0;
        _emojiTweets = 0;
        _imageTweets = 0;
        _hashtagTweets = 0;
        _emojiCounts = [[NSMutableDictionary alloc] init];
        _hashtagCounts = [[NSMutableDictionary alloc] init];
        _urlDomainCounts = [[NSMutableDictionary alloc] init];
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
    NSMutableArray *hashtags = [NSMutableArray array];
    for( NSDictionary *hashtag in [[tweet objectForKey:@"entities"] objectForKey:@"hashtags"] ) {
        [hashtags addObject:[hashtag objectForKey:@"text"]];
    }
    
    // Collect urls
    NSArray *urls = [[tweet objectForKey:@"entities"] objectForKey:@"urls"];
    NSMutableArray *urlDomains = [NSMutableArray array];
    
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
    NSArray *emojis = [[tweet objectForKey:@"text"] getEmojis];
    
    // Record changes on sync'ed main queue
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self recordTweetStatsHashtags:hashtags urlDomains:urlDomains emojis:emojis hasImage:hasImage];
    });
}

- (void)recordTweetStatsHashtags:(NSArray*) hashtags urlDomains:(NSArray*) urlDomains emojis:(NSArray*) emojis hasImage:(BOOL) hasImage {
    // By default, increase tweet count
    _tweets += 1;
    
    // Increment images if tweet had image
    _imageTweets = hasImage ? _imageTweets + 1 : _imageTweets;
    
    // Increment urls if domains >0
    _urlTweets = [urlDomains count] ? _urlTweets + 1 : _urlTweets;
    
    // Increment emojis if emojis >0
    _emojiTweets = [emojis count] ? _emojiTweets + 1 : _emojiTweets;
    
    // Increment hashtags if hashtags >0
    _hashtagTweets = [hashtags count] ? _hashtagTweets + 1 : _hashtagTweets;
    
    // Add domains... If domain exists, increment the count, otherwise add domain with value 1
    for( NSString *domain in urlDomains ) {
        if( [_urlDomainCounts objectForKey:domain] != nil ) {
            [_urlDomainCounts setObject:[NSNumber numberWithInt:[[_urlDomainCounts objectForKey:domain] integerValue] + 1]
                               forKey:domain];
        } else {
            [_urlDomainCounts setObject:[NSNumber numberWithInt:1]
                               forKey:domain];
        }
    }
    
    // Add hash tags... if tag exists, increment the count, otherwise add hashtag with value 1
    for( NSString *hashtag in hashtags ) {
        if( [_hashtagCounts objectForKey:hashtag] != nil ) {
            [_hashtagCounts setObject:[NSNumber numberWithInt:[[_hashtagCounts objectForKey:hashtag] integerValue] + 1]
                               forKey:hashtag];
        } else {
            [_hashtagCounts setObject:[NSNumber numberWithInt:1]
                               forKey:hashtag];
        }
    }
    
    // Add emojis... if emoji exists, increment the count, otherwise add emoji with value 1
    for( NSString *emoji in emojis ) {
        if( [_emojiCounts objectForKey:emoji] != nil ) {
            [_emojiCounts setObject:[NSNumber numberWithInt:[[_emojiCounts objectForKey:emoji] integerValue] + 1]
                               forKey:emoji];
        } else {
            [_emojiCounts setObject:[NSNumber numberWithInt:1]
                               forKey:emoji];
        }
    }
    
    // Let delegate know we've updated
    if( [_delegate respondsToSelector:@selector(TwitterStreamProcessorUpdated:)] ) {
        [_delegate TwitterStreamProcessorUpdated:self];
    }
}

- (void)reset {
    _tweets = 0;
    _urlTweets = 0;
    _emojiTweets = 0;
    _imageTweets = 0;
    _hashtagTweets = 0;
    [_emojiCounts removeAllObjects];
    [_hashtagCounts removeAllObjects];
    [_urlDomainCounts removeAllObjects];
}

- (NSString*)domainFromUrl:(NSString*) url {
    NSArray *parts = [url componentsSeparatedByString:@"/"];
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
