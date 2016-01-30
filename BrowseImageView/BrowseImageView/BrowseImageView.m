//
//  BrowseImageView.m
//  BrowseImageView
//
//  Created by daisuke on 2016/1/29.
//  Copyright © 2016年 dse12345z. All rights reserved.
//

#import "BrowseImageView.h"
#import "UIView+Category.h"

#define mainScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define mainScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

@interface BrowseImageView ()

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *toolsView;
@property (nonatomic, strong) UIImageView *browseImageView;
@property (nonatomic, copy) SaveCompletion saveCompletion;

@end

@implementation BrowseImageView

#pragma mark - instance method

- (void)saveCompletion:(SaveCompletion)saveCompletion {
    self.saveCompletion = saveCompletion;
}

#pragma mark - private instance method

#pragma mark * init

- (void)setupGesture {
    [self addTapGestureTarget:self action:@selector(showBrowse:)];
}

- (void)setupBackgroundView {
    self.window = [UIApplication sharedApplication].keyWindow;
    
    // setup backgroundView
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
    self.backgroundView.alpha = 0.0f;
    self.backgroundView.backgroundColor = self.bgColor ? : [UIColor blackColor];
    [self.backgroundView addTapGestureTarget:self action:@selector(showTools:)];
    [self.window addSubview:self.backgroundView];
    
    // animate
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5f animations: ^{
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.backgroundView.alpha = 1.0f;
    } completion:nil];
}

- (void)setupBrowseImageView {
    self.browseImageView = [[UIImageView alloc] initWithFrame:[self browseFrame]];
    self.browseImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.browseImageView.center = self.window.center;
    self.browseImageView.image = self.browseImage ? : self.image;
    [self.backgroundView addSubview:self.browseImageView];
}

- (void)setupToolsView {
    self.toolsView = [[UIView alloc] initWithFrame:self.backgroundView.frame];
    self.toolsView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5];
    
    // setup doneButton
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *xImage = [UIImage imageNamed:@"x"];
    [doneButton setImage:xImage forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    doneButton.frame = CGRectMake(xImage.size.width / 2, 20, xImage.size.width, xImage.size.height);
    [self.toolsView addSubview:doneButton];
    
    // setup line
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, mainScreenHeight - 55, mainScreenWidth, 1)];
    line.backgroundColor = [UIColor whiteColor];
    [self.toolsView addSubview:line];
    
    // setup downloadButton
    UIButton *downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *downloadImage = [UIImage imageNamed:@"download"];
    [downloadButton setImage:downloadImage forState:UIControlStateNormal];
    [downloadButton addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
    CGFloat x = (mainScreenWidth / 2) - (downloadImage.size.width / 2);
    downloadButton.frame = CGRectMake(x, mainScreenHeight - downloadImage.size.height, downloadImage.size.width, downloadImage.size.height);
    [self.toolsView addSubview:downloadButton];
    [self.backgroundView addSubview:self.toolsView];
}

#pragma mark * button action

- (void)done {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5f animations: ^{
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.backgroundView.alpha = 0.0f;
    } completion: ^(BOOL finished) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.backgroundView performSelector:@selector(removeFromSuperview)];
    }];
}

- (void)download {
    UIImage *image = self.browseImage ? : self.image;
    NSData *imageData =  UIImagePNGRepresentation(image);
    UIImage *pngImage = [UIImage imageWithData:imageData];
    UIImageWriteToSavedPhotosAlbum(pngImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    [self done];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (self.saveCompletion) {
        self.saveCompletion(image, error, contextInfo);
    }
}

#pragma mark * gesture action

- (void)showBrowse:(UIGestureRecognizer *)sender {
    [self setupBackgroundView];
    [self setupBrowseImageView];
    [self setupToolsView];
}

- (void)showTools:(UIGestureRecognizer *)sender {
    self.toolsView.hidden = !self.toolsView.hidden;
}

#pragma mark * misc

- (CGRect)browseFrame {
    UIImage *image = self.browseImage ? : self.image;
    if (image.size.width > mainScreenWidth || image.size.height > mainScreenHeight) {
        CGFloat percentWide = mainScreenWidth / image.size.width;
        CGFloat percentHeight = mainScreenHeight / image.size.height;
        CGFloat percent = percentWide > percentHeight ? percentHeight : percentWide;
        return CGRectMake(0, 0, image.size.width * percent, image.size.height * percent);
    }
    else {
        return CGRectMake(0, 0, image.size.width, image.size.height);
    }
}

#pragma mark - life cycle

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupGesture];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    if (self) {
        [self setupGesture];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupGesture];
    }
    return self;
}

@end
