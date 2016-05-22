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
@property (weak, nonatomic, nullable) IBOutlet UILabel *tweetCount;
@property (weak, nonatomic, nullable) IBOutlet UILabel *tweetRateSec;
@property (weak, nonatomic, nullable) IBOutlet UILabel *tweetRateMin;
@property (weak, nonatomic, nullable) IBOutlet UILabel *tweetRateHr;

// Hashtags
@property (weak, nonatomic, nullable) IBOutlet UILabel *hashtagsTitle;
@property (weak, nonatomic, nullable) IBOutlet UILabel *hashtagsSubtitle;
@property (weak, nonatomic, nullable) IBOutlet UILabel *hashtagRank1Title;
@property (weak, nonatomic, nullable) IBOutlet UILabel *hashtagRank1Subtitle;
@property (weak, nonatomic, nullable) IBOutlet UILabel *hashtagRank2Title;
@property (weak, nonatomic, nullable) IBOutlet UILabel *hashtagRank2Subtitle;
@property (weak, nonatomic, nullable) IBOutlet UILabel *hashtagRank3Title;
@property (weak, nonatomic, nullable) IBOutlet UILabel *hashtagRank3Subtitle;

// Emoji
@property (weak, nonatomic, nullable) IBOutlet UILabel *emojiTitle;
@property (weak, nonatomic, nullable) IBOutlet UILabel *emojiSubtitle;
@property (weak, nonatomic, nullable) IBOutlet UILabel *emojiRank1Title;
@property (weak, nonatomic, nullable) IBOutlet UILabel *emojiRank1Subtitle;
@property (weak, nonatomic, nullable) IBOutlet UILabel *emojiRank2Title;
@property (weak, nonatomic, nullable) IBOutlet UILabel *emojiRank2Subtitle;
@property (weak, nonatomic, nullable) IBOutlet UILabel *emojiRank3Title;
@property (weak, nonatomic, nullable) IBOutlet UILabel *emojiRank3Subtitle;

// URLs
@property (weak, nonatomic, nullable) IBOutlet UILabel *urlsTitle;
@property (weak, nonatomic, nullable) IBOutlet UILabel *urlsSubtitle;
@property (weak, nonatomic, nullable) IBOutlet UILabel *urlsRank1Title;
@property (weak, nonatomic, nullable) IBOutlet UILabel *urlsRank1Subtitle;
@property (weak, nonatomic, nullable) IBOutlet UILabel *urlsRank2Title;
@property (weak, nonatomic, nullable) IBOutlet UILabel *urlsRank2Subtitle;
@property (weak, nonatomic, nullable) IBOutlet UILabel *urlsRank3Title;
@property (weak, nonatomic, nullable) IBOutlet UILabel *urlsRank3Subtitle;

// Images
@property (weak, nonatomic, nullable) IBOutlet UILabel *imagesTitle;
@property (weak, nonatomic, nullable) IBOutlet UILabel *imagesSubtitle;

// Button
@property (weak, nonatomic, nullable) IBOutlet UIView *startButton;
@property (weak, nonatomic, nullable) IBOutlet UILabel *startButtonTitle;


@property (weak, nonatomic, nullable) IBOutlet UIStackView *FirstStack;
@property (weak, nonatomic, nullable) IBOutlet UIStackView *SecondStack;

@end

