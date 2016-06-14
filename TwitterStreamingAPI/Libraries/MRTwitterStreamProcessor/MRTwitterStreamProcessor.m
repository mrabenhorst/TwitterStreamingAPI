//
//  MRTwitterStreamProcessor.m
//  TwitterStreamingAPIAssignment
//
//  Created by Mark Rabenhorst on 5/2/16.
//  Copyright © 2016 Mark Rabenhorst. All rights reserved.
//

#import "MRTwitterStreamProcessor.h"

@implementation MRTwitterStreamProcessor

- (nonnull instancetype)init
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

- (void)processTweet:(nonnull NSDictionary<NSString *, NSDictionary *>*) tweet {
    // Dispatch concurrent to optimize speed under heavy traffic input
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self process:tweet];
    });
}

- (void)process:(nonnull NSDictionary<NSString *, NSDictionary *>*) tweet {
    
    // Collect hash tags
    NSMutableArray<NSString *> *hashtags = [NSMutableArray array];
    for( NSDictionary *hashtag in (NSArray <NSDictionary *>*)tweet[@"entities"][@"hashtags"] ) {
        [hashtags addObject:hashtag[@"text"]];
    }
    
    // Collect urls
    NSArray<NSString *> *urls = (NSArray<NSString *>*)tweet[@"entities"][@"urls"];
    NSMutableArray<NSString *> *urlDomains = [NSMutableArray array];
    
    // process urls using regex to find any possible image url (including popular image extensions)
    BOOL hasImage = FALSE;
    for( NSDictionary<NSString *, NSDictionary *> *url in urls ) {
        
        // Test for image if image hasn't been found - otherwise it's wasted computation
        if( !hasImage ) {
            NSRange range = [(NSString*)url[@"expanded_url"] rangeOfString:@"instagram|pic[.]twitter[.]com|[.]jp[e]*g$|[.]gif$" options:NSRegularExpressionSearch];
            BOOL matches = range.location != NSNotFound;
            
            // Early terminate if found
            if( matches ) {
                hasImage = TRUE;
            }
        }
        
        // Extract domain
        NSString *domain = [self domainFromUrl:(NSString*)url[@"expanded_url"]];
        if( domain != nil ) {
            [urlDomains addObject:domain];
        }
    }
    
    // Collect Emojis using NSString+EmojiTools
    NSArray<NSString *> *emojis = [(NSString*)tweet[@"text"] getEmojis];
    
    // Record changes on sync'ed main queue
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self recordTweetStatsHashtags:hashtags urlDomains:urlDomains emojis:emojis hasImage:hasImage];
    });
}

- (void)recordTweetStatsHashtags:(nonnull NSArray<NSString *>*) hashtags urlDomains:(nonnull NSArray<NSString *>*) urlDomains emojis:(nonnull NSArray<NSString *>*) emojis hasImage:(BOOL) hasImage {
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
        if( self.urlDomainCounts[domain] != nil ) {
            self.urlDomainCounts[domain] = @([self.urlDomainCounts[domain] integerValue] + 1);
        } else {
            self.urlDomainCounts[domain] = @1;
        }
    }
    
    // Add hash tags... if tag exists, increment the count, otherwise add hashtag with value 1
    for( NSString *hashtag in hashtags ) {
        if( self.hashtagCounts[hashtag] != nil ) {
            self.hashtagCounts[hashtag] = @([self.hashtagCounts[hashtag] integerValue] + 1);
        } else {
            self.hashtagCounts[hashtag] = @1;
        }
    }
    
    // Add emojis... if emoji exists, increment the count, otherwise add emoji with value 1
    for( NSString *emoji in emojis ) {
        if( self.emojiCounts[emoji] != nil ) {
            self.emojiCounts[emoji] = @([self.emojiCounts[emoji] integerValue] + 1);
        } else {
            self.emojiCounts[emoji] = @1;
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

- (nullable NSString*)domainFromUrl:(nonnull NSString*) url {
    NSArray<NSString *> *parts = [url componentsSeparatedByString:@"/"];
    for (NSString *part in parts) {
        if( [part rangeOfString:@"."].location != NSNotFound ) {
            // Remove the www. which is a common useless occurance
            return [(NSString*)part stringByReplacingOccurrencesOfString:@"www." withString:@""];
        }
    }
    return nil;
}

@end
