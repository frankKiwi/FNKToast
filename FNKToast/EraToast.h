//
//  EraToast.h
//  HuoPro
//
//  Created by LWW on 2019/6/10.
//  Copyright © 2019 LWW. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EraToastPosition) {
    
    /** 底部 */
    EraToastPositionBottom,
    
    /** 中间 */
    EraToastPositionCenter,
    
    /** 顶部 */
    EraToastPositionTop
};



NS_ASSUME_NONNULL_BEGIN

@interface EraToast : UIView
///显示提示文本，默认位置底部
+ (void)showToast:(NSString *)text;


+ (void)showToast:(NSString *)text position:(EraToastPosition)position;
@end

NS_ASSUME_NONNULL_END
