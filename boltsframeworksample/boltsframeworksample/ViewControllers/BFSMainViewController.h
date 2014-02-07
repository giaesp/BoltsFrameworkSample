//
//  BFSMainViewController.h
//  boltsframeworksample
//
//  Created by gianluca.esposito on 07/02/14.
//  Copyright (c) 2014 Officine K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Bolts/Bolts.h>
#import "TTCounterLabel.h"

@interface BFSMainViewController : UIViewController <TTCounterLabelDelegate>

#pragma mark - Actions

- (IBAction)startStopTapped:(id)sender;
- (IBAction)startStopBFTaskTapped:(id)sender;

@end
