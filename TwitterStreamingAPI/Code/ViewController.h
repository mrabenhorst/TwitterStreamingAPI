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
    NSDate *_streamStart;
    
    ACAccountStore *_accountStore;
    ACAccount *_account;
    
    MRTwitterStreamProcessor *_tsp;
    NSObject<STTwitterRequestProtocol> *_request;
    STTwitterAPI *_twitterAPI;
    
    // UI Elements
    MRTitleTileUIView *_titleTile;
    MRTweetRateTileUIView *_tweetRateTile;
    MRStatisticsTileUIView *_hashtagStatisticsTile;
    MRStatisticsTileUIView *_emojiStatisticsTile;
    MRStatisticsTileUIView *_urlStatisticsTile;
    MRSimpleStatisticsTileUIView *_imageStatisticsTile;
    MRButtonTileUIView *_buttonTile;
    
    UIScrollView *_scrollView;
}

@end

