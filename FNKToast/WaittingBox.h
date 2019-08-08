//
//  WaittingBox.h
//  huosdkProject
//
//  Created by huosdk on 16/6/6.
//  Copyright © 2016年 huosdk. All rights reserved.
//



#import <UIKit/UIKit.h>


@interface WaittingBox : UIView


+ (void)showBox;

+ (void)dismisBox;
//提示一个Message，若干秒之后消失
+ (void)showBoxWithMessage:(NSString *)message disMisAfterDelay:(double)delayTime;
/***  背景不透明 */
+ (void)showBoxNoalphaWithMessage:(NSString *)message disMisAfterDelay:(double)delayTime;
@end
