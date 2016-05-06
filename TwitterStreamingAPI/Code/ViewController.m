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
    [_buttonTile setGestureRecognizers:@[toggleButtonRecognizer]];
    [_buttonTile setUserInteractionEnabled:TRUE];
    
    // Setup Twitter Stream Processor model core
    _tsp = [[MRTwitterStreamProcessor alloc] init];
    [_tsp setDelegate:self];
    
    // Create twitter oAuth credentials
    // **********************************************************************
    //
    // You will need to enter your own credentials before this will work!
    //
    // **********************************************************************
    _twitterAPI = [STTwitterAPI twitterAPIWithOAuthConsumerKey:@""
                                                consumerSecret:@""
                                                    oauthToken:@""
                                              oauthTokenSecret:@""];
    
}

- (void)initUI {
    // Initialize all UI views
    _titleTile = [[MRTitleTileUIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 53)];
    _tweetRateTile = [[MRTweetRateTileUIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleTile.frame), self.view.frame.size.width, 66)];
    _hashtagStatisticsTile = [[MRStatisticsTileUIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tweetRateTile.frame), self.view.frame.size.width, 116)];
    _emojiStatisticsTile = [[MRStatisticsTileUIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_hashtagStatisticsTile.frame), self.view.frame.size.width, 116)];
    _urlStatisticsTile = [[MRStatisticsTileUIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_emojiStatisticsTile.frame), self.view.frame.size.width, 116)];
    _imageStatisticsTile = [[MRSimpleStatisticsTileUIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_urlStatisticsTile.frame), self.view.frame.size.width, 56)];
    _buttonTile = [[MRButtonTileUIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageStatisticsTile.frame), self.view.frame.size.width, 56)];
    
    // Use scrollview for container view for older, shorter devices
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20)];
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width, CGRectGetMaxY(_buttonTile.frame))];
    [self.view addSubview:_scrollView];
    
    // Add views to viewcontroller's view
    [_scrollView addSubview:_titleTile];
    [_scrollView addSubview:_tweetRateTile];
    [_scrollView addSubview:_hashtagStatisticsTile];
    [_scrollView addSubview:_emojiStatisticsTile];
    [_scrollView addSubview:_urlStatisticsTile];
    [_scrollView addSubview:_imageStatisticsTile];
    [_scrollView addSubview:_buttonTile];
    
    // Colors
    [self.view setBackgroundColor:[UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0]];
    [_titleTile setBackgroundColor:[UIColor clearColor]];
    [_tweetRateTile setBackgroundColor:[UIColor clearColor]];
    [_hashtagStatisticsTile setBackgroundColor:[UIColor clearColor]];
    [_emojiStatisticsTile setBackgroundColor:[UIColor clearColor]];
    [_urlStatisticsTile setBackgroundColor:[UIColor clearColor]];
    [_imageStatisticsTile setBackgroundColor:[UIColor clearColor]];
    [_buttonTile setBackgroundColor:[UIColor clearColor]];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grey_wash_wall_light.png"]]];
}

- (void)resetUI {
    // Preset titles
    [_titleTile setTitle:@"Twitter Stream Statistics"];
    
    [_tweetRateTile setTitle:@"---"];
    
    [_tweetRateTile setSubtitleLeft:@"---"];
    [_tweetRateTile setSubtitleCenter:@"---"];
    [_tweetRateTile setSubtitleRight:@"---"];
    [_tweetRateTile setNeedsDisplay];
    
    [_emojiStatisticsTile setTitle:@"Emoji"];
    [_emojiStatisticsTile setSubtitle:@"(---)"];
    [_emojiStatisticsTile setRank1Title:@" ---"];
    [_emojiStatisticsTile setRank1Subtitle:@"(---)"];
    [_emojiStatisticsTile setRank2Title:@" ---"];
    [_emojiStatisticsTile setRank2Subtitle:@"(---)"];
    [_emojiStatisticsTile setRank3Title:@" ---"];
    [_emojiStatisticsTile setRank3Subtitle:@"(---)"];
    [_emojiStatisticsTile setNeedsDisplay];
    
    [_hashtagStatisticsTile setTitle:@"Hashtags"];
    [_hashtagStatisticsTile setSubtitle:@"(---)"];
    [_hashtagStatisticsTile setRank1Title:@" ---"];
    [_hashtagStatisticsTile setRank1Subtitle:@"(---)"];
    [_hashtagStatisticsTile setRank2Title:@" ---"];
    [_hashtagStatisticsTile setRank2Subtitle:@"(---)"];
    [_hashtagStatisticsTile setRank3Title:@" ---"];
    [_hashtagStatisticsTile setRank3Subtitle:@"(---)"];
    [_hashtagStatisticsTile setNeedsDisplay];
    
    [_urlStatisticsTile setTitle:@"URLs"];
    [_urlStatisticsTile setSubtitle:@"(---)"];
    [_urlStatisticsTile setRank1Title:@" ---"];
    [_urlStatisticsTile setRank1Subtitle:@"(---)"];
    [_urlStatisticsTile setRank2Title:@" ---"];
    [_urlStatisticsTile setRank2Subtitle:@"(---)"];
    [_urlStatisticsTile setRank3Title:@" ---"];
    [_urlStatisticsTile setRank3Subtitle:@"(---)"];
    [_urlStatisticsTile setNeedsDisplay];
    
    [_imageStatisticsTile setTitle:@"Image/Photo"];
    [_imageStatisticsTile setSubtitle:@"(---)"];
    [_imageStatisticsTile setNeedsDisplay];
    
    [_buttonTile setColor:[UIColor colorWithRed: 0.376 green: 0.828 blue: 0.291 alpha: 1]];
    [_buttonTile setTitle:@"Start Monitoring"];
    [_buttonTile setNeedsDisplay];
}

- (void)toggleStream:(UIGestureRecognizer *)gestureRecognizer {
    if( !_request ) {
        // Validate credentials on every attempt in case user no longer authenticated to use resource
        [_twitterAPI verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
            
            // Time monitoring for statistics
            _streamStart = [NSDate date];
            
            // Set button color/title
            [_buttonTile setTitle:@"Stop Monitoring"];
            [_buttonTile setColor:[UIColor redColor]];
            [_buttonTile setNeedsDisplay];
            
            // If authenticated, then open request for sample statuses
            _request = [_twitterAPI getStatusesSampleStallWarnings:[NSNumber numberWithInt:0] progressBlock:^( NSDictionary *json, STTwitterStreamJSONType type ) {
                
                // Process the tweet
                [_tsp processTweet:json];
                
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
        [_request cancel];
        _request = nil;
        
        // Reset the processor
        [_tsp reset];
        
        // Set button color/title
        [_buttonTile setTitle:@"Start Monitoring"];
        [_buttonTile setColor:[UIColor colorWithRed: 0.376 green: 0.828 blue: 0.291 alpha: 1]];
        [_buttonTile setNeedsDisplay];
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
    NSTimeInterval streamDuration = [streamFinish timeIntervalSinceDate:_streamStart];
    
    // Tweet Rate Indicator
    [_tweetRateTile setTitle:[NSString stringWithFormat:@"%d", [twitterStreamProcessor tweets]]];
    
    float tweetsPerSecond = ((float)[twitterStreamProcessor tweets] / (float)streamDuration);
    [_tweetRateTile setSubtitleLeft:[NSString stringWithFormat:@"%@/sec", [NSNumberFormatter localizedStringFromNumber:@((int)tweetsPerSecond) numberStyle:NSNumberFormatterDecimalStyle]]];
    [_tweetRateTile setSubtitleCenter:[NSString stringWithFormat:@"%@/min", [NSNumberFormatter localizedStringFromNumber:@((int)tweetsPerSecond*60) numberStyle:NSNumberFormatterDecimalStyle]]];
    [_tweetRateTile setSubtitleRight:[NSString stringWithFormat:@"%@/hr", [NSNumberFormatter localizedStringFromNumber:@((int)tweetsPerSecond*60*60) numberStyle:NSNumberFormatterDecimalStyle]]];
    [_tweetRateTile setNeedsDisplay];
    
    // Emoji readouts (try/catch prevents BAD ACCESS in cases where not enough Emojis have been read to be ranked to 3)
    NSArray *sortedEmojis = [[twitterStreamProcessor emojiCounts] keysSortedByValueUsingComparator:countComparer];
    [_emojiStatisticsTile setTitle:@"Emoji"];
    [_emojiStatisticsTile setSubtitle:[NSString stringWithFormat:@"(%.1f%%)", (((float)[twitterStreamProcessor emojiTweets] / (float)[twitterStreamProcessor tweets])*100)]];
    @try {
        [_emojiStatisticsTile setRank1Title:[NSString stringWithFormat:@" %@",[sortedEmojis objectAtIndex:0]]];
        [_emojiStatisticsTile setRank1Subtitle:[NSString stringWithFormat:@"(%d)",[[[twitterStreamProcessor emojiCounts] objectForKey:[sortedEmojis objectAtIndex:0]] integerValue]]];
    } @catch(NSException *exception) {}
    @try {
        [_emojiStatisticsTile setRank2Title:[NSString stringWithFormat:@" %@",[sortedEmojis objectAtIndex:1]]];
        [_emojiStatisticsTile setRank2Subtitle:[NSString stringWithFormat:@"(%d)",[[[twitterStreamProcessor emojiCounts] objectForKey:[sortedEmojis objectAtIndex:1]] integerValue]]];
    } @catch(NSException *exception) {}
    @try {
        [_emojiStatisticsTile setRank3Title:[NSString stringWithFormat:@" %@",[sortedEmojis objectAtIndex:2]]];
        [_emojiStatisticsTile setRank3Subtitle:[NSString stringWithFormat:@"(%d)",[[[twitterStreamProcessor emojiCounts] objectForKey:[sortedEmojis objectAtIndex:2]] integerValue]]];
    } @catch(NSException *exception) {}
    [_emojiStatisticsTile setNeedsDisplay];
    
    // Hashtag readouts (try/catch prevents BAD ACCESS in cases where not enough Hashtags have been read to be ranked to 3)
    NSArray *sortedHashtags = [[twitterStreamProcessor hashtagCounts] keysSortedByValueUsingComparator:countComparer];
    [_hashtagStatisticsTile setTitle:@"Hashtags"];
    [_hashtagStatisticsTile setSubtitle:[NSString stringWithFormat:@"(%.1f%%)", (((float)[twitterStreamProcessor hashtagTweets] / (float)[twitterStreamProcessor tweets])*100)]];
    @try {
        [_hashtagStatisticsTile setRank1Title:[NSString stringWithFormat:@" %@",[sortedHashtags objectAtIndex:0]]];
        [_hashtagStatisticsTile setRank1Subtitle:[NSString stringWithFormat:@"(%d)",[[[twitterStreamProcessor hashtagCounts] objectForKey:[sortedHashtags objectAtIndex:0]] integerValue]]];
    } @catch(NSException *exception) {}
    @try {
        [_hashtagStatisticsTile setRank2Title:[NSString stringWithFormat:@" %@",[sortedHashtags objectAtIndex:1]]];
        [_hashtagStatisticsTile setRank2Subtitle:[NSString stringWithFormat:@"(%d)",[[[twitterStreamProcessor hashtagCounts] objectForKey:[sortedHashtags objectAtIndex:1]] integerValue]]];
    } @catch(NSException *exception) {}
    @try {
        [_hashtagStatisticsTile setRank3Title:[NSString stringWithFormat:@" %@",[sortedHashtags objectAtIndex:2]]];
        [_hashtagStatisticsTile setRank3Subtitle:[NSString stringWithFormat:@"(%d)",[[[twitterStreamProcessor hashtagCounts] objectForKey:[sortedHashtags objectAtIndex:2]] integerValue]]];
    } @catch(NSException *exception) {}
    [_hashtagStatisticsTile setNeedsDisplay];
    
    // URL/Domain readouts (try/catch prevents BAD ACCESS in cases where not enough URLs have been read to be ranked to 3)
    NSArray *sortedUrlDomains = [[twitterStreamProcessor urlDomainCounts] keysSortedByValueUsingComparator:countComparer];
    [_urlStatisticsTile setTitle:@"URLs"];
    [_urlStatisticsTile setSubtitle:[NSString stringWithFormat:@"(%.1f%%)", (((float)[twitterStreamProcessor urlTweets] / (float)[twitterStreamProcessor tweets])*100)]];
    @try {
        [_urlStatisticsTile setRank1Title:[NSString stringWithFormat:@" %@",[sortedUrlDomains objectAtIndex:0]]];
        [_urlStatisticsTile setRank1Subtitle:[NSString stringWithFormat:@"(%d)",[[[twitterStreamProcessor urlDomainCounts] objectForKey:[sortedUrlDomains objectAtIndex:0]] integerValue]]];
    } @catch(NSException *exception) {}
    @try {
        [_urlStatisticsTile setRank2Title:[NSString stringWithFormat:@" %@",[sortedUrlDomains objectAtIndex:1]]];
        [_urlStatisticsTile setRank2Subtitle:[NSString stringWithFormat:@"(%d)",[[[twitterStreamProcessor urlDomainCounts] objectForKey:[sortedUrlDomains objectAtIndex:1]] integerValue]]];
    } @catch(NSException *exception) {}
    @try {
        [_urlStatisticsTile setRank3Title:[NSString stringWithFormat:@" %@",[sortedUrlDomains objectAtIndex:2]]];
        [_urlStatisticsTile setRank3Subtitle:[NSString stringWithFormat:@"(%d)",[[[twitterStreamProcessor urlDomainCounts] objectForKey:[sortedUrlDomains objectAtIndex:2]] integerValue]]];
    } @catch(NSException *exception) {}
    [_urlStatisticsTile setNeedsDisplay];
    
    // Image readouts
    [_imageStatisticsTile setTitle:@"Image/Photo"];
    [_imageStatisticsTile setSubtitle:[NSString stringWithFormat:@"(%.1f%%)", (((float)[twitterStreamProcessor imageTweets] / (float)[twitterStreamProcessor tweets])*100)]];
    [_imageStatisticsTile setNeedsDisplay];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
