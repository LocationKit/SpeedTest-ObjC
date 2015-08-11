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
    [[LocationKit sharedInstance] startWithApiToken:@"your_api_token" andDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationKit:(LocationKit *)locationKit didUpdateLocation:(CLLocation *)location {
    NSLog(@"The user has moved and their location is now (%.6f, %.6f)",
          location.coordinate.latitude,
          location.coordinate.longitude);
}

@end
