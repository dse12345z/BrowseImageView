//
//  ViewController.m
//  BrowseImageView
//
//  Created by daisuke on 2016/1/29.
//  Copyright © 2016年 dse12345z. All rights reserved.
//

#import "ViewController.h"
#import "BrowseImageView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet BrowseImageView *browseImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.browseImageView saveCompletion:^(UIImage *image, NSError *error, void *contextInfo) {
        if (error) {
            NSLog(@"error");
        }
        else {
            NSLog(@"success");
        }
    }];
    
    CGRect imageFrame = self.browseImageView.frame;
    CGRect newFrame = CGRectMake(CGRectGetMinX(imageFrame), CGRectGetMinY(imageFrame) + CGRectGetHeight(imageFrame), CGRectGetWidth(imageFrame), CGRectGetHeight(imageFrame));
    BrowseImageView *browseImageView2 = [[BrowseImageView alloc] initWithFrame:newFrame];
    browseImageView2.image = [UIImage imageNamed:@"daisuke"];
    browseImageView2.browseImage = [UIImage imageNamed:@"moumtain"];
    [browseImageView2 saveCompletion:^(UIImage *image, NSError *error, void *contextInfo) {
        if (error) {
            NSLog(@"error");
        }
        else {
            NSLog(@"success");
        }
    }];
    [self.view addSubview:browseImageView2];
}

@end
