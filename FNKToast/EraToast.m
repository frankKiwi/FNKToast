//
//  EraToast.m
//  HuoPro
//
//  Created by LWW on 2019/6/10.
//  Copyright © 2019 LWW. All rights reserved.
//

#import "EraToast.h"

#define Duration 1.5
#define TextFont [UIFont systemFontOfSize:14]
#define SCREEN_WIDH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

@interface EraToast()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation EraToast


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        self.layer.cornerRadius = 5;
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = TextFont;
        _textLabel.numberOfLines = 0;
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
    }
    return self;
}

+ (instancetype)sharedToast
{
    static EraToast *toast;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toast = [[EraToast alloc] init];
    });
    return toast;
}

+ (void)showToast:(NSString *)text
{
    if (text.length == 0) {
        text = @"No Message";
    }
    [self showToast:text position:EraToastPositionBottom];
}

+ (void)showToast:(NSString *)text position:(EraToastPosition)position
{
    CGSize size = [EraTool sizeWithTexte:text font:TextFont maxSize:CGSizeMake(SCREEN_WIDH-70, 200)];
    EraToast *toast = [EraToast sharedToast];
    toast.textLabel.text = text;
    toast.bounds = CGRectMake(0, 0, size.width + 20, size.height + 20);
    toast.center = CGPointMake(SCREEN_WIDH/2.0, toast.center.y);
    toast.textLabel.mj_size = size;
    toast.textLabel.center = CGPointMake(toast.mj_w/2.0, toast.mj_h/2.0);
    if (position == EraToastPositionCenter) {
        toast.center = CGPointMake(toast.center.x, SCREEN_HEIGHT/2.0);
    }
    else if (position == EraToastPositionTop) {
        toast.mj_y = SafeAreaTopHeight + 20;
    }
    else {
        toast.mj_y = SCREEN_HEIGHT-toast.mj_h - 100;
    }
    [toast show];
}

- (void)show
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hide) object:nil];
    self.alpha = 0.00001;
    self.hidden = NO;
    if (!self.superview) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1.0;
    }];
    [self performSelector:@selector(hide) withObject:nil afterDelay:Duration];
    
}
- (void)hide
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.01;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
