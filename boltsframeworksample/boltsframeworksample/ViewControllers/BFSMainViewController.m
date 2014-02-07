//
//  BFSMainViewController.m
//  boltsframeworksample
//
//  Created by gianluca.esposito on 07/02/14.
//  Copyright (c) 2014 Officine K. All rights reserved.
//

#import "BFSMainViewController.h"

typedef NS_ENUM(NSInteger, kTTCounter){
    kTTCounterRunning = 0,
    kTTCounterStopped,
    kTTCounterReset,
    kTTCounterEnded
};

@interface BFSMainViewController ()

@property (strong, nonatomic) IBOutlet TTCounterLabel * counterLabel;
@property (strong, nonatomic) IBOutlet UIButton * startStopButton;
@property (strong, nonatomic) IBOutlet UIButton * startStopBFTaskButton;
@property (strong, nonatomic) IBOutlet UILabel * urlLabel;
@property (strong, nonatomic) IBOutlet UILabel * outputLabel;

@end

@implementation BFSMainViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
    /*
    self.counterLabel.countDirection = kCountDirectionDown;
    [self.counterLabel setStartValue:60000];
    self.counterLabel.countdownDelegate = self;
    */
    
    // Optional
    [self customiseAppearance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (IBAction)startStopTapped:(id)sender {
    if (self.counterLabel.isRunning) {
        [self.counterLabel stop];
        [self.startStopButton setEnabled:YES];
        [self.startStopBFTaskButton setEnabled:YES];
        [self.startStopButton setAlpha:1.0];
        [self.startStopBFTaskButton setAlpha:1.0];
        [self updateUIForState:kTTCounterStopped];
    } else {
        [self.counterLabel start];
        [self.startStopButton setEnabled:YES];
        [self.startStopBFTaskButton setEnabled:NO];
        [self.startStopButton setAlpha:1.0];
        [self.startStopBFTaskButton setAlpha:0.5];

        [self updateUIForState:kTTCounterRunning];
        
        [self parseHTML:[NSURL URLWithString:@"http://it.wikipedia.org/wiki/IOS_(Apple)"] searchString:@"iOS"];
        [self parseHTML:[NSURL URLWithString:@"http://www.raywenderlich.com"] searchString:@"iOS"];
        [self parseHTML:[NSURL URLWithString:@"https://developer.apple.com/"] searchString:@"iOS"];
        [self parseHTML:[NSURL URLWithString:@"http://ios.wordpress.org/"] searchString:@"iOS"];
        [self parseHTML:[NSURL URLWithString:@"https://developers.facebook.com/docs/ios/"] searchString:@"iOS"];
        [self parseHTML:[NSURL URLWithString:@"http://mashable.com/category/ios/"] searchString:@"iOS"];
        [self parseHTML:[NSURL URLWithString:@"http://www.google.com/mobile/ios/"] searchString:@"iOS"];
        [self parseHTML:[NSURL URLWithString:@"https://www.dropbox.com/iphoneapp"] searchString:@"iOS"];
    }
}

- (IBAction)startStopBFTaskTapped:(id)sender {
    if (self.counterLabel.isRunning) {
        [self.counterLabel stop];
        [self.startStopButton setEnabled:YES];
        [self.startStopBFTaskButton setEnabled:YES];
        [self.startStopButton setAlpha:1.0];
        [self.startStopBFTaskButton setAlpha:1.0];
        [self updateUIForBFTaskState:kTTCounterStopped];
    } else {
        [self.counterLabel start];
        [self.startStopButton setEnabled:NO];
        [self.startStopBFTaskButton setEnabled:YES];
        [self.startStopButton setAlpha:0.5];
        [self.startStopBFTaskButton setAlpha:1.0];
        [self updateUIForBFTaskState:kTTCounterRunning];
        
        // Create a BFExecutor that uses the main thread.
        BFExecutor *executor = [BFExecutor executorWithBlock:^void(void(^block)()) {
            dispatch_async(dispatch_get_main_queue(), block);
        }];
        
        [[[[[[[[[self parseHTML:[NSURL URLWithString:@"http://it.wikipedia.org/wiki/IOS_(Apple)"] searchString:@"iOS"] continueWithExecutor:executor withBlock:^id(BFTask *task) {
            return [self parseHTML:[NSURL URLWithString:@"http://www.raywenderlich.com"] searchString:@"iOS"];
        }] continueWithExecutor:executor withBlock:^id(BFTask *task) {
            return [self parseHTML:[NSURL URLWithString:@"https://developer.apple.com/"] searchString:@"iOS"];
        }] continueWithExecutor:executor withBlock:^id(BFTask *task) {
            return [self parseHTML:[NSURL URLWithString:@"http://ios.wordpress.org/"] searchString:@"iOS"];
        }] continueWithExecutor:executor withBlock:^id(BFTask *task) {
            return [self parseHTML:[NSURL URLWithString:@"https://developers.facebook.com/docs/ios/"] searchString:@"iOS"];
        }] continueWithExecutor:executor withBlock:^id(BFTask *task) {
            return [self parseHTML:[NSURL URLWithString:@"http://mashable.com/category/ios/"] searchString:@"iOS"];
        }] continueWithExecutor:executor withBlock:^id(BFTask *task) {
            return [self parseHTML:[NSURL URLWithString:@"http://www.google.com/mobile/ios/"] searchString:@"iOS"];
        }] continueWithExecutor:executor withBlock:^id(BFTask *task) {
            return [self parseHTML:[NSURL URLWithString:@"https://www.dropbox.com/iphoneapp"] searchString:@"iOS"];
        }] continueWithExecutor:executor withBlock:^id(BFTask *task) {
            return nil;
        }];
    }
}

#pragma mark - Private

- (void)customiseAppearance {
    [self.counterLabel setBoldFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:55]];
    [self.counterLabel setRegularFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:55]];
    [self.counterLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:25]];
    self.counterLabel.textColor = [UIColor whiteColor];
    [self.counterLabel updateApperance];
}

- (void)updateUIForState:(NSInteger)state {
    switch (state) {
        case kTTCounterRunning:
            [self.startStopButton setTitle:NSLocalizedString(@"Stop", @"Stop") forState:UIControlStateNormal];
            break;
            
        case kTTCounterStopped:
            [self.startStopButton setTitle:NSLocalizedString(@"Start", @"Start") forState:UIControlStateNormal];
            
            [self.urlLabel setText:@""];
            [self.outputLabel setText:@""];
            
            break;
            
        case kTTCounterReset:
            [self.startStopButton setTitle:NSLocalizedString(@"Start", @"Start") forState:UIControlStateNormal];
            self.startStopButton.hidden = NO;
            break;
            
        case kTTCounterEnded:
            self.startStopButton.hidden = YES;
            break;
            
        default:
            break;
    }
}

- (void)updateUIForBFTaskState:(NSInteger)state {
    switch (state) {
        case kTTCounterRunning:
            [self.startStopBFTaskButton setTitle:NSLocalizedString(@"Stop", @"Stop") forState:UIControlStateNormal];
            break;
            
        case kTTCounterStopped:
            [self.startStopBFTaskButton setTitle:NSLocalizedString(@"Start", @"Start") forState:UIControlStateNormal];
            
            [self.urlLabel setText:@""];
            [self.outputLabel setText:@""];
            
            break;
            
        case kTTCounterReset:
            [self.startStopBFTaskButton setTitle:NSLocalizedString(@"Start", @"Start") forState:UIControlStateNormal];
            self.startStopBFTaskButton.hidden = NO;
            break;
            
        case kTTCounterEnded:
            self.startStopBFTaskButton.hidden = YES;
            break;
            
        default:
            break;
    }
}

#pragma mark - Parser
- (BFTask*) parseHTML:(NSURL*)url searchString:(NSString*)searchString {
    BFTaskCompletionSource * tcs = [BFTaskCompletionSource taskCompletionSource];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url
                                              cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                          timeoutInterval:30];
    NSURLResponse * response;
    NSError * error;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (!error) {
        NSString * receivedData = [NSString stringWithUTF8String:[returnData bytes]];
        NSUInteger occurrences = [self countOccurencesOfString:@"iOS" inputString:receivedData];
        [tcs setResult:[NSNumber numberWithInt:occurrences]];
            
#ifdef DEBUG
        NSLog(@"parseHTML: %@ - %d", url.absoluteString, occurrences);
#endif
        
    }
    else {
        [tcs setError:error];
    }
    
    return tcs.task;
}


- (BFTask*) parseHTMLAsync:(NSURL*)url searchString:(NSString*)searchString {
    BFTaskCompletionSource * tcs = [BFTaskCompletionSource taskCompletionSource];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url
                                              cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                          timeoutInterval:30];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error && data) {
            NSString * receivedData = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSUInteger occurrences = [self countOccurencesOfString:@"iOS" inputString:receivedData];
            [tcs setResult:[NSNumber numberWithInt:occurrences]];
#ifdef DEBUG
            NSLog(@"parseHTML: %@ - %d", url.absoluteString, occurrences);
#endif
        }
        else {
            [tcs setError:error];
        }
    }];
    return tcs.task;
}

- (NSUInteger) countOccurencesOfString:(NSString*)string inputString:(NSString*)inputString {
    NSUInteger count = 0;
    NSUInteger length = [inputString length];
    NSRange range = NSMakeRange(0, length);
    while(range.location != NSNotFound)
    {
        range = [inputString rangeOfString:string options:0 range:range];
        if(range.location != NSNotFound)
        {
            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            count++;
        }
    }
    return count;
}

#pragma mark - TTCounterLabelDelegate

- (void)countdownDidEnd {
    [self updateUIForState:kTTCounterEnded];
}

@end