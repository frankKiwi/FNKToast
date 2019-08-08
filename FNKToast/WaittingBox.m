//
//  WaittingBox.m
//  huosdkProject
//
//  Created by huosdk on 16/6/6.
//  Copyright © 2016年 huosdk. All rights reserved.
//

#define SG_BOX_LENGTH (100.0f)
#define SG_BOX_EDGE (20.0f)
#define FONTARIAL @"Arial"

#define SCREEN_WIDH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

#import "WaittingBox.h"

@interface WaittingBox ()
{
    UIActivityIndicatorView *indicator;
    UIView *blackView;
}
@property (nonatomic, strong) UILabel *messageLabel;

@end
static WaittingBox *waitBox = nil;
@implementation WaittingBox

- (instancetype)initWithMessage:(NSString *)message
{
    self = [super init];
    if (self) {
        
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        self.backgroundColor = [UIColor clearColor];
        self.frame = [UIScreen mainScreen].bounds;
        
        blackView = [[UIView alloc] init];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 0.6;
        blackView.frame = CGRectMake(0, 0, SG_BOX_LENGTH, SG_BOX_LENGTH);
        blackView.center = CGPointMake(screenSize.width/2, screenSize.height/2);
        blackView.layer.cornerRadius = 7;
        [self addSubview:blackView];
        
        
        
        if (message && ![message isEqualToString:@""]) {
            _messageLabel = [[UILabel alloc] init];
            UIFont *messageFont = [UIFont fontWithName:FONTARIAL size:17];
            CGRect labelBounds = [message boundingRectWithSize:CGSizeMake(320.0 - SG_BOX_EDGE, 320.0 - SG_BOX_EDGE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:messageFont} context:nil];
            _messageLabel.numberOfLines = 0;
            blackView.frame = CGRectMake(0, 0, labelBounds.size.width + SG_BOX_EDGE, labelBounds.size.height + SG_BOX_EDGE);
            _messageLabel.frame = CGRectMake(SG_BOX_EDGE/2, SG_BOX_EDGE/2, labelBounds.size.width, labelBounds.size.height);
            _messageLabel.center = CGPointMake(blackView.frame.size.width/2, blackView.frame.size.height/2);
            _messageLabel.font = messageFont;
            _messageLabel.text = message;
            _messageLabel.textColor = [UIColor whiteColor];
            self.frame = CGRectMake(0, 0, labelBounds.size.width + SG_BOX_EDGE, labelBounds.size.height + SG_BOX_EDGE);
            self.center = CGPointMake(screenSize.width/2, screenSize.height/2);
            blackView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
            [blackView addSubview:_messageLabel];
            
        }
        else
        {
            indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator setCenter:CGPointMake(screenSize.width/2, screenSize.height/2)];
            [self addSubview:indicator];
            [indicator startAnimating];
        }
        
    }
    return self;
}
- (instancetype)initWithMesage:(NSString *)message
{
    self = [super init];
    if (self) {
        
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        self.backgroundColor = [UIColor clearColor];
        self.frame = [UIScreen mainScreen].bounds;
        
        blackView = [[UIView alloc] init];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 1;
        blackView.frame = CGRectMake(0, 0, SG_BOX_LENGTH, SG_BOX_LENGTH);
        blackView.center = CGPointMake(screenSize.width/2, screenSize.height/2);
        blackView.layer.cornerRadius = 7;
        [self addSubview:blackView];
        
        
        if (message && ![message isEqualToString:@""]) {
            _messageLabel = [[UILabel alloc] init];
            UIFont *messageFont = [UIFont fontWithName:FONTARIAL size:13];
            CGRect labelBounds = [message boundingRectWithSize:CGSizeMake(320.0 - SG_BOX_EDGE, 320.0 - SG_BOX_EDGE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:messageFont} context:nil];
            _messageLabel.numberOfLines = 0;
            blackView.frame = CGRectMake(0, 0, labelBounds.size.width + SG_BOX_EDGE, labelBounds.size.height + SG_BOX_EDGE);
            _messageLabel.frame = CGRectMake(SG_BOX_EDGE/2, SG_BOX_EDGE/2, labelBounds.size.width, labelBounds.size.height);
            _messageLabel.center = CGPointMake(blackView.frame.size.width/2, blackView.frame.size.height/2);
            _messageLabel.font = messageFont;
            _messageLabel.text = message;
            _messageLabel.textColor = [UIColor whiteColor];
            self.frame = CGRectMake(0, 0, labelBounds.size.width + SG_BOX_EDGE, labelBounds.size.height + SG_BOX_EDGE);
            self.center = CGPointMake(screenSize.width/2, screenSize.height/2);
            blackView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
            [blackView addSubview:_messageLabel];
            
        }
        else
        {
            indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator setCenter:CGPointMake(screenSize.width/2, screenSize.height/2)];
            [self addSubview:indicator];
            [indicator startAnimating];
        }
        
    }
    return self;
}

/***  背景不透明 */
+ (void)showBoxNoalphaWithMessage:(NSString *)message disMisAfterDelay:(double)delayTime
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!waitBox) {
            waitBox = [[WaittingBox alloc] initWithMesage:message];
            [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:waitBox];
            [[UIApplication sharedApplication].keyWindow.rootViewController.view bringSubviewToFront:waitBox];
            [NSTimer scheduledTimerWithTimeInterval:delayTime target:[WaittingBox class] selector:@selector(fadeOutBox) userInfo:nil repeats:NO];
        }
        else
        {
            [waitBox removeFromSuperview];
            waitBox = nil;
            waitBox = [[WaittingBox alloc] initWithMesage:message];
            [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:waitBox];
            [NSTimer scheduledTimerWithTimeInterval:delayTime target:[WaittingBox class] selector:@selector(fadeOutBox) userInfo:nil repeats:NO];
        }
        
    });
}


+ (void)showBox
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!waitBox) {
            waitBox = [[WaittingBox alloc] initWithMessage:nil];
            [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:waitBox];
        }
    });
    
    
}

+ (void)showBoxWithMessage:(NSString *)message disMisAfterDelay:(double)delayTime
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!waitBox) {
            waitBox = [[WaittingBox alloc] initWithMessage:message];
            [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:waitBox];
            [[UIApplication sharedApplication].keyWindow.rootViewController.view bringSubviewToFront:waitBox];
            [NSTimer scheduledTimerWithTimeInterval:delayTime target:[WaittingBox class] selector:@selector(fadeOutBox) userInfo:nil repeats:NO];
        }
        else
        {
            [waitBox removeFromSuperview];
            waitBox = nil;
            waitBox = [[WaittingBox alloc] initWithMessage:message];
            [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:waitBox];
            [NSTimer scheduledTimerWithTimeInterval:delayTime target:[WaittingBox class] selector:@selector(fadeOutBox) userInfo:nil repeats:NO];
        }
        
    });
}

+ (void)fadeOutBox
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:1.0f animations:^{
            if (waitBox) {
                waitBox.alpha = 0.f;
                
            }
        } completion:^(BOOL finished) {
            if (waitBox) {
                [waitBox removeFromSuperview];
                waitBox = nil;
                
            }
            
        }];
        
    });
}

+ (void)dismisBox
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (waitBox) {
            [waitBox removeFromSuperview];
            waitBox = nil;
        }
    });
    
}

@end
