//
//  PopDatePickerView.h
//  yoyo
//
//  Created by 辛忠志 on 2017/6/1.
//  Copyright © 2017年 辛忠志. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ConfirmBlock)(NSString *choseDate,NSString *restDate);
typedef void(^CannelBlock)();


@interface PopDatePickerView : UIView
@property (weak, nonatomic) IBOutlet UIDatePicker *popDatePickerView;
@property (weak, nonatomic) IBOutlet UIView *backView;

/**
 控件出现
 */
- (void)fadeIn;
/**
 控件显示
 */
- (void)fadeOut;

@property (nonatomic,copy) ConfirmBlock confirmBlock;

@property (nonatomic,copy) CannelBlock cannelBlock;

//- (PopDatePickerView *)initWithCustomeHeight:(CGFloat)height;
@end
