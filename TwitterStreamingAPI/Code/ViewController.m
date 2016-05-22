//
//  ViewController.m
//  TwitterStreamingAPIAssignment
//
//  Created by Mark Rabenhorst on 5/2/16.
//  Copyright © 2016 Mark Rabenhorst. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Setup UI views
    [self initUI];
    
    // Reset the fields to default values
    [self resetUI];
    
    // Add GestureRecognizer to button view to recieve tap
    UIGestureRecognizer *toggleButtonRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleStream:)];
    [self.startButton setGestureRecognizers:@[toggleButtonRecognizer]];
    [self.startButton setUserInteractionEnabled:TRUE];
    
    // Setup Twitter Stream Processor model core
    self.tsp = [[MRTwitterStreamProcessor alloc] init];
    [self.tsp setDelegate:self];
    
    // Create twitter oAuth credentials
    // **********************************************************************
    //
    // You will need to enter your own credentials before this will work!
    //
    // **********************************************************************
    self.twitterAPI = [STTwitterAPI twitterAPIWithOAuthConsumerKey:@""
                                                    consumerSecret:@""
                                                        oauthToken:@""
                                                  oauthTokenSecret:@""];
    
}

- (void)initUI {
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grey_wash_wall_light.png"]]];
}

- (void)resetUI {
    // Preset titles
    [self.tweetCount setText:@"---"];
    
    [self.tweetRateSec setText:@"---"];
    [self.tweetRateMin setText:@"---"];
    [self.tweetRateHr setText:@"---"];
    
    [self.hashtagsTitle setText:@"Hashtags"];
    [self.hashtagsSubtitle setText:@"(---)"];
    [self.hashtagRank1Title setText:@" ---"];
    [self.hashtagRank1Subtitle setText:@"(---)"];
    [self.hashtagRank2Title setText:@" ---"];
    [self.hashtagRank2Subtitle setText:@"(---)"];
    [self.hashtagRank3Title setText:@" ---"];
    [self.hashtagRank3Subtitle setText:@"(---)"];
    
    [self.emojiTitle setText:@"Emoji"];
    [self.emojiSubtitle setText:@"(---)"];
    [self.emojiRank1Title setText:@" ---"];
    [self.emojiRank1Subtitle setText:@"(---)"];
    [self.emojiRank2Title setText:@" ---"];
    [self.emojiRank2Subtitle setText:@"(---)"];
    [self.emojiRank3Title setText:@" ---"];
    [self.emojiRank3Subtitle setText:@"(---)"];
    
    [self.urlsTitle setText:@"URLs"];
    [self.urlsSubtitle setText:@"(---)"];
    [self.urlsRank1Title setText:@" ---"];
    [self.urlsRank1Subtitle setText:@"(---)"];
    [self.urlsRank2Title setText:@" ---"];
    [self.urlsRank2Subtitle setText:@"(---)"];
    [self.urlsRank3Title setText:@" ---"];
    [self.urlsRank3Subtitle setText:@"(---)"];
    
    [self.imagesTitle setText:@"Image/Photo"];
    [self.imagesSubtitle setText:@"(---)"];
    
    [self.startButton setBackgroundColor:[UIColor colorWithRed: 0.376 green: 0.828 blue: 0.291 alpha: 1]];
    [self.startButtonTitle setText:@"Start Monitoring"];
}

- (void)toggleStream:(nonnull UIGestureRecognizer *)gestureRecognizer {
    if( !self.request ) {
        // Validate credentials on every attempt in case user no longer authenticated to use resource
        [self.twitterAPI verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
            
            // Time monitoring for statistics
            self.streamStart = [NSDate date];
            
            // Set button color/title
            [self.startButtonTitle setText:@"Stop Monitoring"];
            [self.startButton setBackgroundColor:[UIColor redColor]];
            
            // If authenticated, then open request for sample statuses
            self.request = [self.twitterAPI getStatusesSampleStallWarnings:[NSNumber numberWithInt:0] progressBlock:^( NSDictionary *json, STTwitterStreamJSONType type ) {
                
                // Process the tweet
                [self.tsp processTweet:json];
                
            } errorBlock:^( NSError *error ) {
                // This occurs on a cancellation, so don't bother user
                NSLog(@"Error: %@", error);
            }];
        } errorBlock:^(NSError *error){
            // Alert user to error
            NSLog(@"Error: %@", error);
            // Report error to user
            UIAlertController *authenticationErrorAlertController = [UIAlertController alertControllerWithTitle:@"Authentication Error"
                                                                                                        message:[error localizedDescription]
                                                                                                 preferredStyle:UIAlertControllerStyleAlert];
            
            [authenticationErrorAlertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [authenticationErrorAlertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            
            [self presentViewController:authenticationErrorAlertController animated:YES completion:nil];
        }];
    } else {
        // Close connection
        [self.request cancel];
        self.request = nil;
        
        // Reset the processor
        [self.tsp reset];
        
        // Set button color/title
        [self.startButtonTitle setText:@"Start Monitoring"];
        [self.startButton setBackgroundColor:[UIColor colorWithRed: 0.376 green: 0.828 blue: 0.291 alpha: 1]];
    }
}


- (void)TwitterStreamProcessorUpdated:(nonnull MRTwitterStreamProcessor*) twitterStreamProcesssor {
    // Location for possible throttle if hooked into Firehose
    [self computeStatistics:twitterStreamProcesssor];
}

- (void)computeStatistics:(nonnull MRTwitterStreamProcessor*) twitterStreamProcessor {
    
    // Comparer block for sorting counts
    NSComparisonResult (^countComparer)( NSNumber* _Nonnull, NSNumber* _Nonnull ) = ^NSComparisonResult( NSNumber *num1, NSNumber *num2 ) {
        if( [num1 integerValue] < [num2 integerValue] ) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if( [num1 integerValue] > [num2 integerValue] ) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    // Calculate current duration
    NSDate *streamFinish = [NSDate date];
    NSTimeInterval streamDuration = [streamFinish timeIntervalSinceDate:self.streamStart];
    
    // Tweet Rate Indicator
    [self.tweetCount setText:[NSString stringWithFormat:@"%d", [twitterStreamProcessor tweets]]];
    
    float tweetsPerSecond = ((float)[twitterStreamProcessor tweets] / (float)streamDuration);
    [self.tweetRateSec setText:[NSString stringWithFormat:@"%@/sec", [NSNumberFormatter localizedStringFromNumber:@((int)tweetsPerSecond) numberStyle:NSNumberFormatterDecimalStyle]]];
    [self.tweetRateMin setText:[NSString stringWithFormat:@"%@/min", [NSNumberFormatter localizedStringFromNumber:@((int)tweetsPerSecond*60) numberStyle:NSNumberFormatterDecimalStyle]]];
    [self.tweetRateHr  setText:[NSString stringWithFormat:@"%@/hr", [NSNumberFormatter localizedStringFromNumber:@((int)tweetsPerSecond*60*60) numberStyle:NSNumberFormatterDecimalStyle]]];
    
    // Hashtag readouts ('if' prevents BAD ACCESS in cases where not enough Hashtags have been read to be ranked to 3)
    NSArray<NSString *> *sortedHashtags = [[twitterStreamProcessor hashtagCounts] keysSortedByValueUsingComparator:countComparer];
    [self.hashtagsSubtitle setText:[NSString stringWithFormat:@"(%.1f%%)", (((float)[twitterStreamProcessor hashtagTweets] / (float)[twitterStreamProcessor tweets])*100)]];
    int numHashtags = (int)[sortedHashtags count];
    if( numHashtags > 0 ) {
        [self.hashtagRank1Title setText:[NSString stringWithFormat:@" %@",[sortedHashtags objectAtIndex:0]]];
        [self.hashtagRank1Subtitle setText:[NSString stringWithFormat:@"(%ld)",(long)[[[twitterStreamProcessor hashtagCounts] objectForKey:[sortedHashtags objectAtIndex:0]] integerValue]]];
    }
    if( numHashtags > 1 ) {
        [self.hashtagRank2Title setText:[NSString stringWithFormat:@" %@",[sortedHashtags objectAtIndex:1]]];
        [self.hashtagRank2Subtitle setText:[NSString stringWithFormat:@"(%ld)",(long)[[[twitterStreamProcessor hashtagCounts] objectForKey:[sortedHashtags objectAtIndex:1]] integerValue]]];
    }
    if( numHashtags > 2 ) {
        [self.hashtagRank3Title setText:[NSString stringWithFormat:@" %@",[sortedHashtags objectAtIndex:2]]];
        [self.hashtagRank3Subtitle setText:[NSString stringWithFormat:@"(%ld)",(long)[[[twitterStreamProcessor hashtagCounts] objectForKey:[sortedHashtags objectAtIndex:2]] integerValue]]];
    }
    
    // Emoji readouts ('if' prevents BAD ACCESS in cases where not enough Emojis have been read to be ranked to 3)
    NSArray<NSString *> *sortedEmojis = [[twitterStreamProcessor emojiCounts] keysSortedByValueUsingComparator:countComparer];
    [self.emojiSubtitle setText:[NSString stringWithFormat:@"(%.1f%%)", (((float)[twitterStreamProcessor emojiTweets] / (float)[twitterStreamProcessor tweets])*100)]];
    int numEmojis = (int)[sortedEmojis count];
    if( numEmojis > 0 ) {
        [self.emojiRank1Title setText:[NSString stringWithFormat:@" %@",[sortedEmojis objectAtIndex:0]]];
        [self.emojiRank1Subtitle setText:[NSString stringWithFormat:@"(%ld)",(long)[[[twitterStreamProcessor emojiCounts] objectForKey:[sortedEmojis objectAtIndex:0]] integerValue]]];
    }
    if( numEmojis > 1 ) {
        [self.emojiRank2Title setText:[NSString stringWithFormat:@" %@",[sortedEmojis objectAtIndex:1]]];
        [self.emojiRank2Subtitle setText:[NSString stringWithFormat:@"(%ld)",(long)[[[twitterStreamProcessor emojiCounts] objectForKey:[sortedEmojis objectAtIndex:1]] integerValue]]];
    }
    if( numEmojis > 2 ) {
        [self.emojiRank3Title setText:[NSString stringWithFormat:@" %@",[sortedEmojis objectAtIndex:2]]];
        [self.emojiRank3Subtitle setText:[NSString stringWithFormat:@"(%ld)",(long)[[[twitterStreamProcessor emojiCounts] objectForKey:[sortedEmojis objectAtIndex:2]] integerValue]]];
    }
    
    // URL/Domain readouts ('if' prevents BAD ACCESS in cases where not enough URLs have been read to be ranked to 3)
    NSArray<NSString *> *sortedUrlDomains = [[twitterStreamProcessor urlDomainCounts] keysSortedByValueUsingComparator:countComparer];
    [self.urlsSubtitle setText:[NSString stringWithFormat:@"(%.1f%%)", (((float)[twitterStreamProcessor urlTweets] / (float)[twitterStreamProcessor tweets])*100)]];
    int numDomains = (int)[sortedUrlDomains count];
    if( numDomains > 0 ) {
        [self.urlsRank1Title setText:[NSString stringWithFormat:@" %@",[sortedUrlDomains objectAtIndex:0]]];
        [self.urlsRank1Subtitle setText:[NSString stringWithFormat:@"(%ld)",(long)[[[twitterStreamProcessor urlDomainCounts] objectForKey:[sortedUrlDomains objectAtIndex:0]] integerValue]]];
    }
    if( numDomains > 1 ) {
        [self.urlsRank2Title setText:[NSString stringWithFormat:@" %@",[sortedUrlDomains objectAtIndex:1]]];
        [self.urlsRank2Subtitle setText:[NSString stringWithFormat:@"(%ld)",(long)[[[twitterStreamProcessor urlDomainCounts] objectForKey:[sortedUrlDomains objectAtIndex:1]] integerValue]]];
    }
    if( numDomains > 2 ) {
        [self.urlsRank3Title setText:[NSString stringWithFormat:@" %@",[sortedUrlDomains objectAtIndex:2]]];
        [self.urlsRank3Subtitle setText:[NSString stringWithFormat:@"(%ld)",(long)[[[twitterStreamProcessor urlDomainCounts] objectForKey:[sortedUrlDomains objectAtIndex:2]] integerValue]]];
    }
    
    // Image readouts
    [self.imagesSubtitle setText:[NSString stringWithFormat:@"(%.1f%%)", (((float)[twitterStreamProcessor imageTweets] / (float)[twitterStreamProcessor tweets])*100)]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
