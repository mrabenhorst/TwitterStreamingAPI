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

@interface ViewController : UIViewController <MRTwitterStreamProcessorDelegate> {
    
}

@property (nonatomic, nonnull) NSDate *streamStart;

@property (nonatomic, nonnull) ACAccountStore *accountStore;
@property (nonatomic, nonnull) ACAccount *account;

@property (nonatomic, nonnull) MRTwitterStreamProcessor *tsp;
@property (nonatomic, nullable) NSObject<STTwitterRequestProtocol> *request;
@property (nonatomic, nonnull) STTwitterAPI *twitterAPI;


// ***********
// UI Elements
// ***********
// Tweets
@property (weak, nonatomic) IBOutlet UILabel *tweetCount;
@property (weak, nonatomic) IBOutlet UILabel *tweetRateSec;
@property (weak, nonatomic) IBOutlet UILabel *tweetRateMin;
@property (weak, nonatomic) IBOutlet UILabel *tweetRateHr;

// Hashtags
@property (weak, nonatomic) IBOutlet UILabel *hashtagsTitle;
@property (weak, nonatomic) IBOutlet UILabel *hashtagsSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *hashtagRank1Title;
@property (weak, nonatomic) IBOutlet UILabel *hashtagRank1Subtitle;
@property (weak, nonatomic) IBOutlet UILabel *hashtagRank2Title;
@property (weak, nonatomic) IBOutlet UILabel *hashtagRank2Subtitle;
@property (weak, nonatomic) IBOutlet UILabel *hashtagRank3Title;
@property (weak, nonatomic) IBOutlet UILabel *hashtagRank3Subtitle;

// Emoji
@property (weak, nonatomic) IBOutlet UILabel *emojiTitle;
@property (weak, nonatomic) IBOutlet UILabel *emojiSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *emojiRank1Title;
@property (weak, nonatomic) IBOutlet UILabel *emojiRank1Subtitle;
@property (weak, nonatomic) IBOutlet UILabel *emojiRank2Title;
@property (weak, nonatomic) IBOutlet UILabel *emojiRank2Subtitle;
@property (weak, nonatomic) IBOutlet UILabel *emojiRank3Title;
@property (weak, nonatomic) IBOutlet UILabel *emojiRank3Subtitle;

// URLs
@property (weak, nonatomic) IBOutlet UILabel *urlsTitle;
@property (weak, nonatomic) IBOutlet UILabel *urlsSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *urlsRank1Title;
@property (weak, nonatomic) IBOutlet UILabel *urlsRank1Subtitle;
@property (weak, nonatomic) IBOutlet UILabel *urlsRank2Title;
@property (weak, nonatomic) IBOutlet UILabel *urlsRank2Subtitle;
@property (weak, nonatomic) IBOutlet UILabel *urlsRank3Title;
@property (weak, nonatomic) IBOutlet UILabel *urlsRank3Subtitle;

// Images
@property (weak, nonatomic) IBOutlet UILabel *imagesTitle;
@property (weak, nonatomic) IBOutlet UILabel *imagesSubtitle;

// Button
@property (weak, nonatomic) IBOutlet UIView *startButton;
@property (weak, nonatomic) IBOutlet UILabel *startButtonTitle;

@end

