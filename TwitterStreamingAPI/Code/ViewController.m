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
    [self.buttonTile setGestureRecognizers:@[toggleButtonRecognizer]];
    [self.buttonTile setUserInteractionEnabled:TRUE];
    
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
    // Initialize all UI views
    self.titleTile = [[MRTitleTileUIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 53)];
    self.tweetRateTile = [[MRTweetRateTileUIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleTile.frame), self.view.frame.size.width, 66)];
    self.hashtagStatisticsTile = [[MRStatisticsTileUIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tweetRateTile.frame), self.view.frame.size.width, 116)];
    self.emojiStatisticsTile = [[MRStatisticsTileUIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.hashtagStatisticsTile.frame), self.view.frame.size.width, 116)];
    self.urlStatisticsTile = [[MRStatisticsTileUIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.emojiStatisticsTile.frame), self.view.frame.size.width, 116)];
    self.imageStatisticsTile = [[MRSimpleStatisticsTileUIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.urlStatisticsTile.frame), self.view.frame.size.width, 56)];
    self.buttonTile = [[MRButtonTileUIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageStatisticsTile.frame), self.view.frame.size.width, 56)];
    
    // Use scrollview for container view for older, shorter devices
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20)];
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, CGRectGetMaxY(self.buttonTile.frame))];
    [self.view addSubview:self.scrollView];
    
    // Add views to viewcontroller's view
    [self.scrollView addSubview:self.titleTile];
    [self.scrollView addSubview:self.tweetRateTile];
    [self.scrollView addSubview:self.hashtagStatisticsTile];
    [self.scrollView addSubview:self.emojiStatisticsTile];
    [self.scrollView addSubview:self.urlStatisticsTile];
    [self.scrollView addSubview:self.imageStatisticsTile];
    [self.scrollView addSubview:self.buttonTile];
    
    // Colors
    [self.view setBackgroundColor:[UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0]];
    [self.titleTile setBackgroundColor:[UIColor clearColor]];
    [self.tweetRateTile setBackgroundColor:[UIColor clearColor]];
    [self.hashtagStatisticsTile setBackgroundColor:[UIColor clearColor]];
    [self.emojiStatisticsTile setBackgroundColor:[UIColor clearColor]];
    [self.urlStatisticsTile setBackgroundColor:[UIColor clearColor]];
    [self.imageStatisticsTile setBackgroundColor:[UIColor clearColor]];
    [self.buttonTile setBackgroundColor:[UIColor clearColor]];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grey_wash_wall_light.png"]]];
}

- (void)resetUI {
    // Preset titles
    [self.titleTile setTitle:@"Twitter Stream Statistics"];
    
    [self.tweetRateTile setTitle:@"---"];
    
    [self.tweetRateTile setSubtitleLeft:@"---"];
    [self.tweetRateTile setSubtitleCenter:@"---"];
    [self.tweetRateTile setSubtitleRight:@"---"];
    [self.tweetRateTile setNeedsDisplay];
    
    [self.emojiStatisticsTile setTitle:@"Emoji"];
    [self.emojiStatisticsTile setSubtitle:@"(---)"];
    [self.emojiStatisticsTile setRank1Title:@" ---"];
    [self.emojiStatisticsTile setRank1Subtitle:@"(---)"];
    [self.emojiStatisticsTile setRank2Title:@" ---"];
    [self.emojiStatisticsTile setRank2Subtitle:@"(---)"];
    [self.emojiStatisticsTile setRank3Title:@" ---"];
    [self.emojiStatisticsTile setRank3Subtitle:@"(---)"];
    [self.emojiStatisticsTile setNeedsDisplay];
    
    [self.hashtagStatisticsTile setTitle:@"Hashtags"];
    [self.hashtagStatisticsTile setSubtitle:@"(---)"];
    [self.hashtagStatisticsTile setRank1Title:@" ---"];
    [self.hashtagStatisticsTile setRank1Subtitle:@"(---)"];
    [self.hashtagStatisticsTile setRank2Title:@" ---"];
    [self.hashtagStatisticsTile setRank2Subtitle:@"(---)"];
    [self.hashtagStatisticsTile setRank3Title:@" ---"];
    [self.hashtagStatisticsTile setRank3Subtitle:@"(---)"];
    [self.hashtagStatisticsTile setNeedsDisplay];
    
    [self.urlStatisticsTile setTitle:@"URLs"];
    [self.urlStatisticsTile setSubtitle:@"(---)"];
    [self.urlStatisticsTile setRank1Title:@" ---"];
    [self.urlStatisticsTile setRank1Subtitle:@"(---)"];
    [self.urlStatisticsTile setRank2Title:@" ---"];
    [self.urlStatisticsTile setRank2Subtitle:@"(---)"];
    [self.urlStatisticsTile setRank3Title:@" ---"];
    [self.urlStatisticsTile setRank3Subtitle:@"(---)"];
    [self.urlStatisticsTile setNeedsDisplay];
    
    [self.imageStatisticsTile setTitle:@"Image/Photo"];
    [self.imageStatisticsTile setSubtitle:@"(---)"];
    [self.imageStatisticsTile setNeedsDisplay];
    
    [self.buttonTile setColor:[UIColor colorWithRed: 0.376 green: 0.828 blue: 0.291 alpha: 1]];
    [self.buttonTile setTitle:@"Start Monitoring"];
    [self.buttonTile setNeedsDisplay];
}

- (void)toggleStream:(UIGestureRecognizer *)gestureRecognizer {
    if( !self.request ) {
        // Validate credentials on every attempt in case user no longer authenticated to use resource
        [self.twitterAPI verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
            
            // Time monitoring for statistics
            self.streamStart = [NSDate date];
            
            // Set button color/title
            [self.buttonTile setTitle:@"Stop Monitoring"];
            [self.buttonTile setColor:[UIColor redColor]];
            [self.buttonTile setNeedsDisplay];
            
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
        [self.buttonTile setTitle:@"Start Monitoring"];
        [self.buttonTile setColor:[UIColor colorWithRed: 0.376 green: 0.828 blue: 0.291 alpha: 1]];
        [self.buttonTile setNeedsDisplay];
    }
}


- (void)TwitterStreamProcessorUpdated:(MRTwitterStreamProcessor *) twitterStreamProcesssor {
    // Update every 100 tweets to prevent UI from twitching - better user experience
    if( [twitterStreamProcesssor tweets] % 100 == 0 ) {
        [self computeStatistics:twitterStreamProcesssor];
    }
}

- (void)computeStatistics:(MRTwitterStreamProcessor*) twitterStreamProcessor {
    
    // Comparer block for sorting counts
    NSComparisonResult (^countComparer)( id, id ) = ^NSComparisonResult( id obj1, id obj2 ) {
        if( [obj1 integerValue] < [obj2 integerValue] ) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if( [obj1 integerValue] > [obj2 integerValue] ) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    // Calculate current duration
    NSDate *streamFinish = [NSDate date];
    NSTimeInterval streamDuration = [streamFinish timeIntervalSinceDate:self.streamStart];
    
    // Tweet Rate Indicator
    [self.tweetRateTile setTitle:[NSString stringWithFormat:@"%d", [twitterStreamProcessor tweets]]];
    
    float tweetsPerSecond = ((float)[twitterStreamProcessor tweets] / (float)streamDuration);
    [self.tweetRateTile setSubtitleLeft:[NSString stringWithFormat:@"%@/sec", [NSNumberFormatter localizedStringFromNumber:@((int)tweetsPerSecond) numberStyle:NSNumberFormatterDecimalStyle]]];
    [self.tweetRateTile setSubtitleCenter:[NSString stringWithFormat:@"%@/min", [NSNumberFormatter localizedStringFromNumber:@((int)tweetsPerSecond*60) numberStyle:NSNumberFormatterDecimalStyle]]];
    [self.tweetRateTile setSubtitleRight:[NSString stringWithFormat:@"%@/hr", [NSNumberFormatter localizedStringFromNumber:@((int)tweetsPerSecond*60*60) numberStyle:NSNumberFormatterDecimalStyle]]];
    [self.tweetRateTile setNeedsDisplay];
    
    // Emoji readouts (try/catch prevents BAD ACCESS in cases where not enough Emojis have been read to be ranked to 3)
    NSArray *sortedEmojis = [[twitterStreamProcessor emojiCounts] keysSortedByValueUsingComparator:countComparer];
    [self.emojiStatisticsTile setTitle:@"Emoji"];
    [self.emojiStatisticsTile setSubtitle:[NSString stringWithFormat:@"(%.1f%%)", (((float)[twitterStreamProcessor emojiTweets] / (float)[twitterStreamProcessor tweets])*100)]];
    @try {
        [self.emojiStatisticsTile setRank1Title:[NSString stringWithFormat:@" %@",[sortedEmojis objectAtIndex:0]]];
        [self.emojiStatisticsTile setRank1Subtitle:[NSString stringWithFormat:@"(%ld)",[[[twitterStreamProcessor emojiCounts] objectForKey:[sortedEmojis objectAtIndex:0]] integerValue]]];
    } @catch(NSException *exception) {}
    @try {
        [self.emojiStatisticsTile setRank2Title:[NSString stringWithFormat:@" %@",[sortedEmojis objectAtIndex:1]]];
        [self.emojiStatisticsTile setRank2Subtitle:[NSString stringWithFormat:@"(%ld)",[[[twitterStreamProcessor emojiCounts] objectForKey:[sortedEmojis objectAtIndex:1]] integerValue]]];
    } @catch(NSException *exception) {}
    @try {
        [self.emojiStatisticsTile setRank3Title:[NSString stringWithFormat:@" %@",[sortedEmojis objectAtIndex:2]]];
        [self.emojiStatisticsTile setRank3Subtitle:[NSString stringWithFormat:@"(%ld)",[[[twitterStreamProcessor emojiCounts] objectForKey:[sortedEmojis objectAtIndex:2]] integerValue]]];
    } @catch(NSException *exception) {}
    [self.emojiStatisticsTile setNeedsDisplay];
    
    // Hashtag readouts (try/catch prevents BAD ACCESS in cases where not enough Hashtags have been read to be ranked to 3)
    NSArray *sortedHashtags = [[twitterStreamProcessor hashtagCounts] keysSortedByValueUsingComparator:countComparer];
    [self.hashtagStatisticsTile setTitle:@"Hashtags"];
    [self.hashtagStatisticsTile setSubtitle:[NSString stringWithFormat:@"(%.1f%%)", (((float)[twitterStreamProcessor hashtagTweets] / (float)[twitterStreamProcessor tweets])*100)]];
    @try {
        [self.hashtagStatisticsTile setRank1Title:[NSString stringWithFormat:@" %@",[sortedHashtags objectAtIndex:0]]];
        [self.hashtagStatisticsTile setRank1Subtitle:[NSString stringWithFormat:@"(%ld)",[[[twitterStreamProcessor hashtagCounts] objectForKey:[sortedHashtags objectAtIndex:0]] integerValue]]];
    } @catch(NSException *exception) {}
    @try {
        [self.hashtagStatisticsTile setRank2Title:[NSString stringWithFormat:@" %@",[sortedHashtags objectAtIndex:1]]];
        [self.hashtagStatisticsTile setRank2Subtitle:[NSString stringWithFormat:@"(%ld)",[[[twitterStreamProcessor hashtagCounts] objectForKey:[sortedHashtags objectAtIndex:1]] integerValue]]];
    } @catch(NSException *exception) {}
    @try {
        [self.hashtagStatisticsTile setRank3Title:[NSString stringWithFormat:@" %@",[sortedHashtags objectAtIndex:2]]];
        [self.hashtagStatisticsTile setRank3Subtitle:[NSString stringWithFormat:@"(%ld)",[[[twitterStreamProcessor hashtagCounts] objectForKey:[sortedHashtags objectAtIndex:2]] integerValue]]];
    } @catch(NSException *exception) {}
    [self.hashtagStatisticsTile setNeedsDisplay];
    
    // URL/Domain readouts (try/catch prevents BAD ACCESS in cases where not enough URLs have been read to be ranked to 3)
    NSArray *sortedUrlDomains = [[twitterStreamProcessor urlDomainCounts] keysSortedByValueUsingComparator:countComparer];
    [self.urlStatisticsTile setTitle:@"URLs"];
    [self.urlStatisticsTile setSubtitle:[NSString stringWithFormat:@"(%.1f%%)", (((float)[twitterStreamProcessor urlTweets] / (float)[twitterStreamProcessor tweets])*100)]];
    @try {
        [self.urlStatisticsTile setRank1Title:[NSString stringWithFormat:@" %@",[sortedUrlDomains objectAtIndex:0]]];
        [self.urlStatisticsTile setRank1Subtitle:[NSString stringWithFormat:@"(%ld)",[[[twitterStreamProcessor urlDomainCounts] objectForKey:[sortedUrlDomains objectAtIndex:0]] integerValue]]];
    } @catch(NSException *exception) {}
    @try {
        [self.urlStatisticsTile setRank2Title:[NSString stringWithFormat:@" %@",[sortedUrlDomains objectAtIndex:1]]];
        [self.urlStatisticsTile setRank2Subtitle:[NSString stringWithFormat:@"(%ld)",[[[twitterStreamProcessor urlDomainCounts] objectForKey:[sortedUrlDomains objectAtIndex:1]] integerValue]]];
    } @catch(NSException *exception) {}
    @try {
        [self.urlStatisticsTile setRank3Title:[NSString stringWithFormat:@" %@",[sortedUrlDomains objectAtIndex:2]]];
        [self.urlStatisticsTile setRank3Subtitle:[NSString stringWithFormat:@"(%ld)",[[[twitterStreamProcessor urlDomainCounts] objectForKey:[sortedUrlDomains objectAtIndex:2]] integerValue]]];
    } @catch(NSException *exception) {}
    [self.urlStatisticsTile setNeedsDisplay];
    
    // Image readouts
    [self.imageStatisticsTile setTitle:@"Image/Photo"];
    [self.imageStatisticsTile setSubtitle:[NSString stringWithFormat:@"(%.1f%%)", (((float)[twitterStreamProcessor imageTweets] / (float)[twitterStreamProcessor tweets])*100)]];
    [self.imageStatisticsTile setNeedsDisplay];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
