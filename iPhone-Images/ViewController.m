//
//  ViewController.m
//  iPhone-Images
//
//  Created by Cameron Mcleod on 2019-06-13.
//  Copyright © 2019 Cameron Mcleod. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property UIImageView *iPhoneImageView;
@property UIButton *randomButton;

-(void) showImage:(NSString *) imageURL;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _iPhoneImageView = [[UIImageView alloc] initWithFrame: CGRectZero];
    self.iPhoneImageView = _iPhoneImageView;
    self.iPhoneImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.iPhoneImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    UIButton *randomButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [randomButton setTitle:@"Randomize Phone Color" forState:UIControlStateNormal];
    [randomButton addTarget:self action:@selector(randomizePhone) forControlEvents:UIControlEventTouchUpInside];
    randomButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:randomButton];
    self.randomButton = randomButton;

    NSLayoutConstraint *randomButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:self.randomButton
                                                                                    attribute:NSLayoutAttributeBottom
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.view
                                                                                    attribute:NSLayoutAttributeBottom
                                                                                   multiplier:1.0
                                                                                     constant:-50.0];
    randomButtonBottomConstraint.active = YES;
    
    NSLayoutConstraint *randomButtonCenterXConstraint = [NSLayoutConstraint constraintWithItem:self.randomButton
                                                                                    attribute:NSLayoutAttributeCenterX
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.view
                                                                                    attribute:NSLayoutAttributeCenterX
                                                                                   multiplier:1.0
                                                                                     constant:0.0];
    randomButtonCenterXConstraint.active = YES;
    
    [self showImage:@"http://imgur.com/bktnImE.png"];
    
    
    
    
    
}

- (void)randomizePhone {
    switch (arc4random_uniform(5)) {
        case 0:
            [self showImage:@"http://imgur.com/bktnImE.png"];
            break;
        case 1:
            [self showImage:@"http://imgur.com/zdwdenZ.png"];
            break;
        case 2:
            [self showImage:@"http://imgur.com/CoQ8aNl.png"];
            break;
        case 3:
            [self showImage:@"http://imgur.com/2vQtZBb.png"];
            break;
        case 4:
            [self showImage:@"http://imgur.com/y9MIaCS.png"];
            break;
        default:
            break;
    }
}

- (void)showImage:(NSString *) imageURL {
    
    NSURL *url = [NSURL URLWithString:imageURL]; // 1
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 2
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 3
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data]; // 2
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            
            self.iPhoneImageView.image = image; // 4
            [self.view addSubview:self.iPhoneImageView];
            
            NSLayoutConstraint *imageXConstraint = [NSLayoutConstraint constraintWithItem:self.iPhoneImageView
                                                                                       attribute:NSLayoutAttributeCenterX
                                                                                       relatedBy:NSLayoutRelationEqual
                                                                                          toItem:self.view
                                                                                       attribute:NSLayoutAttributeCenterX
                                                                                      multiplier:1.0
                                                                                        constant:0.0];
            imageXConstraint.active = YES;
            
            NSLayoutConstraint *imageWidthConstraint = [NSLayoutConstraint constraintWithItem:self.iPhoneImageView
                                                                                attribute:NSLayoutAttributeWidth
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self.view
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:1.0
                                                                                 constant:0.0];
            imageWidthConstraint.active = YES;
            
            NSLayoutConstraint *imageTopConstraint = [NSLayoutConstraint constraintWithItem:self.iPhoneImageView
                                                                                     attribute:NSLayoutAttributeTop
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:self.view
                                                                                     attribute:NSLayoutAttributeTop
                                                                                    multiplier:1.0
                                                                                      constant:0.0];
            imageTopConstraint.active = YES;
            
            NSLayoutConstraint *imageBottomConstraint = [NSLayoutConstraint constraintWithItem:self.iPhoneImageView
                                                                                       attribute:NSLayoutAttributeBottom
                                                                                       relatedBy:NSLayoutRelationEqual
                                                                                          toItem:self.randomButton
                                                                                       attribute:NSLayoutAttributeTop
                                                                                      multiplier:1.0
                                                                                        constant:0.0];
            imageBottomConstraint.active = YES;
            
            
        }];
        
    }];
    
    [downloadTask resume]; // 5
    
}


@end
