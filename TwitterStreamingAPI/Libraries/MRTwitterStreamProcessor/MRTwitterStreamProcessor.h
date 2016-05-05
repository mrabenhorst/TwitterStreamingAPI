//
//  MRTwitterStreamProcessor.h
//  TwitterStreamingAPIAssignment
//
//  Created by Mark Rabenhorst on 5/2/16.
//  Copyright © 2016 Mark Rabenhorst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+EmojiTools.h"

@class MRTwitterStreamProcessor;
@protocol MRTwitterStreamProcessorDelegate <NSObject>

@optional
- (void)TwitterStreamProcessorUpdated:(MRTwitterStreamProcessor*) twitterStreamProcesssor;

@end

@interface MRTwitterStreamProcessor : NSObject {
    
    // Statistical Storage
    int _tweets;
    int _urlTweets;
    int _imageTweets;
    int _emojiTweets;
    int _hashtagTweets;
    NSMutableDictionary *_emojiCounts;
    NSMutableDictionary *_hashtagCounts;
    NSMutableDictionary *_urlDomainCounts;
    
    // Delegate to post updates to
    id _delegate;
    
}

- (instancetype)init;
- (void)processTweet:(NSDictionary*) tweet;
- (void)reset;

@property (nonatomic, strong) dispatch_queue_t concurrentProcessQueue;
@property (nonatomic) id<MRTwitterStreamProcessorDelegate> delegate;

@property (nonatomic, readonly) int tweets;
@property (nonatomic, readonly) int urlTweets;
@property (nonatomic, readonly) int imageTweets;
@property (nonatomic, readonly) int emojiTweets;
@property (nonatomic, readonly) int hashtagTweets;
@property (nonatomic, readonly) NSDictionary *emojiCounts;
@property (nonatomic, readonly) NSDictionary *hashtagCounts;
@property (nonatomic, readonly) NSDictionary *urlDomainCounts;

@end
