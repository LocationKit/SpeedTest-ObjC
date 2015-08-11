//
//  ViewController.m
//  SpeedTest-ObjC
//
//  Created by admin on 8/11/15.
//  Copyright (c) 2015 SocialRadar. All rights reserved.
//

#import "ViewController.h"
#import <LocationKit/LocationKit.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *speedDisplay;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[LocationKit sharedInstance] startWithApiToken:@"your_api_token_here" delegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationKit:(LocationKit *)locationKit didUpdateLocation:(CLLocation *)location {
    if (location.speed > 1) {
        double speed = location.speed * 2.236936;
        self.speedDisplay.text = [NSString stringWithFormat:@"%.2f MPH", speed];
    } else if (location.speed >= 0 && location.speed < 1) {
      self.speedDisplay.text = @"Stopped";
    } else {
      self.speedDisplay.text = @"Unknown";
    }
}

- (void)locationKit:(LocationKit *)locationKit willChangeActivityMode:(LKActivityMode)mode {
    // LocationKit has engaged driving mode, we want to crank up the GPS to high from its default (low)
    LKSetting* setting;
    if (mode == 5) {
        NSLog(@"Detected user likely driving, changing operation mode to high");
        setting = [[LKSetting alloc] initWithType:LKSettingTypeHigh];
    } else {
        NSLog(@"Detected user likely not driving, changing operation mode to auto");
        setting = [[LKSetting alloc] initWithType:LKSettingTypeAuto];
    }
    [[LocationKit sharedInstance] applyOperationMode:(setting)];
}

@end
