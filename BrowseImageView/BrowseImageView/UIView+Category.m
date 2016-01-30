//
//  UIView+Category.m
//  BrowseImageView
//
//  Created by daisuke on 2016/1/30.
//  Copyright © 2016年 dse12345z. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

- (void)addTapGestureTarget:(id)target action:(SEL)action {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] init];
    touch.numberOfTapsRequired = 1;
    [touch addTarget:target action:action];
    [self addGestureRecognizer:touch];
}

@end
