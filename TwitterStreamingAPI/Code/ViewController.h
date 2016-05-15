//
//  ViewController.h
//  TwitterStreamingAPIAssignment
//
//  Created by Mark Rabenhorst on 5/2/16.
//  Copyright © 2016 Mark Rabenhorst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "MRTwitterStreamProcessor.h"
#import "STTwitter.h"

#import "MRTitleTileUIView.h"
#import "MRButtonTileUIView.h"
#import "MRTweetRateTileUIView.h"
#import "MRStatisticsTileUIView.h"
#import "MRSimpleStatisticsTileUIView.h"


@interface ViewController : UIViewController <MRTwitterStreamProcessorDelegate> {
    
}

@property (nonatomic, nonnull) NSDate *streamStart;

@property (nonatomic, nonnull) ACAccountStore *accountStore;
@property (nonatomic, nonnull) ACAccount *account;

@property (nonatomic, nonnull) MRTwitterStreamProcessor *tsp;
@property (nonatomic, nullable) NSObject<STTwitterRequestProtocol> *request;
@property (nonatomic, nonnull) STTwitterAPI *twitterAPI;

// UI Elements
@property (nonatomic, nonnull) MRTitleTileUIView *titleTile;
@property (nonatomic, nonnull) MRTweetRateTileUIView *tweetRateTile;
@property (nonatomic, nonnull) MRStatisticsTileUIView *hashtagStatisticsTile;
@property (nonatomic, nonnull) MRStatisticsTileUIView *emojiStatisticsTile;
@property (nonatomic, nonnull) MRStatisticsTileUIView *urlStatisticsTile;
@property (nonatomic, nonnull) MRSimpleStatisticsTileUIView *imageStatisticsTile;
@property (nonatomic, nonnull) MRButtonTileUIView *buttonTile;

@property (nonatomic, nonnull) UIScrollView *scrollView;

@end

