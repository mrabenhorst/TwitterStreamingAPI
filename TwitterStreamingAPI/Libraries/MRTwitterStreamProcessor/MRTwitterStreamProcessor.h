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
- (void)TwitterStreamProcessorUpdated:(MRTwitterStreamProcessor * _Nonnull) twitterStreamProcesssor;

@end

@interface MRTwitterStreamProcessor : NSObject

- (instancetype _Nonnull)init;
- (void)processTweet:(NSDictionary * _Nonnull) tweet;
- (void)reset;

@property (nonatomic, strong, nonnull) dispatch_queue_t concurrentProcessQueue;
@property (nonatomic, nonnull) id<MRTwitterStreamProcessorDelegate> delegate;

@property (nonatomic) int tweets;
@property (nonatomic) int urlTweets;
@property (nonatomic) int imageTweets;
@property (nonatomic) int emojiTweets;
@property (nonatomic) int hashtagTweets;
@property (nonatomic, nonnull) NSMutableDictionary<NSString *, NSNumber *> *emojiCounts;
@property (nonatomic, nonnull) NSMutableDictionary<NSString *, NSNumber *> *hashtagCounts;
@property (nonatomic, nonnull) NSMutableDictionary<NSString *, NSNumber *> *urlDomainCounts;

@end
