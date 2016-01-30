//
//  BrowseImageView.h
//  BrowseImageView
//
//  Created by daisuke on 2016/1/29.
//  Copyright © 2016年 dse12345z. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SaveCompletion)(UIImage *image, NSError *error, void *contextInfo);

@interface BrowseImageView : UIImageView

@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIImage *browseImage;

- (void)saveCompletion:(SaveCompletion)saveCompletion;

@end