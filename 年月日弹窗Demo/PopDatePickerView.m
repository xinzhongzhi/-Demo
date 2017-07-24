//
//  PopDatePickerView.m
//  yoyo
//
//  Created by 辛忠志 on 2017/6/1.
//  Copyright © 2017年 辛忠志. All rights reserved.
//

#import "PopDatePickerView.h"

@implementation PopDatePickerView
#pragma mark - ---------- Lazy Loading（懒加载） ----------

#pragma mark - ----------   Lifecycle（生命周期） ----------
- (void)awakeFromNib{
    [super awakeFromNib];
    // 圆角
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 6.0;
    self.backView.layer.borderWidth = 1.0;
    self.backView.layer.borderColor = [[UIColor whiteColor] CGColor];
    // 本地化
    self.popDatePickerView.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    self.popDatePickerView.datePickerMode = UIDatePickerModeDate;
}
#pragma mark - ---------- Private Methods（私有方法） ----------
- (void)fadeIn{
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.hidden = NO;
    }];
}
- (void)fadeOut{
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 0.0;
    }completion:^(BOOL finished) {
        if (finished){
            self.hidden = YES;
        }
    }];
}
#pragma mark initliaze data(初始化数据)
//计算某个时间与此刻的时间间隔（天）
- (NSString *)dayIntervalFromNowtoDate:(NSString *)dateString
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd"];
    NSDate *d=[date dateFromString:dateString];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate *dat = [NSDate date];
    NSString *nowStr = [date stringFromDate:dat];
    NSDate *nowDate = [date dateFromString:nowStr];
    
    NSTimeInterval now=[nowDate timeIntervalSince1970]*1;
    
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    timeString = [NSString stringWithFormat:@"%f", cha/86400];
    timeString = [timeString substringToIndex:timeString.length-7];
    
    if ([timeString intValue] < 0) {
        
        timeString = [NSString stringWithFormat:@"%d",-[timeString intValue]];
    }
    
    return timeString;
    
}
#pragma mark config control（布局控件）

#pragma mark networkRequest (网络请求)

#pragma mark actions （点击事件）

#pragma mark IBActions （点击事件xib）
- (IBAction)cancelBtnClick:(UIButton *)sender {
    [self fadeOut];
}

- (IBAction)sureBtnClick:(UIButton *)sender {
    
    if (sender.tag==2) {
        
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy-MM-dd"];
        NSString *choseDateString = [dateformatter stringFromDate:self.popDatePickerView.date];
                
        //计算出剩余多久生日
        //拿到生日中的 月&日 年份为今年 拼接起来 转化为时间 与今天相减
        NSArray *tempArr = [choseDateString componentsSeparatedByString:@"-"];
        
        NSDateFormatter *currentFormatter = [[NSDateFormatter alloc] init];
        [currentFormatter setDateFormat:@"yyyy"];
        NSString *currentYear = [currentFormatter stringFromDate:[NSDate date]];
        
        NSString *appendString = [NSString stringWithFormat:@"%@-%@-%@",currentYear,tempArr[1],tempArr[2]];
        
        
        NSDate *appendDate = [dateformatter dateFromString:appendString];
        
        //将此刻时间转换为与选择时间格式一致
        NSDate *now = [NSDate date];
        NSString *nowStr = [dateformatter stringFromDate:now];
        NSDate *nowDate = [dateformatter dateFromString:nowStr];
        
        
        //判断拼接后的时间与此刻时间对比
        if ([[nowDate earlierDate:appendDate] isEqualToDate:appendDate]) {
            //拼接后在当前时间之前 重新拼接 年份+1
            if (![nowDate isEqualToDate:appendDate]) {
                
                appendString = [NSString stringWithFormat:@"%d-%@-%@",[currentYear intValue]+1,tempArr[1],tempArr[2]];
            }
            
        }
        
        NSString *intercalStr = [self dayIntervalFromNowtoDate:appendString];
        
        self.confirmBlock(choseDateString,intercalStr);
        
        NSLog(@"intercalStr==%@",intercalStr);
        
    }
}

#pragma mark - ---------- Public Methods（公有方法） ----------
- (IBAction)backTap:(UITapGestureRecognizer *)sender {
    [self fadeOut];
}
#pragma mark self declare （本类声明）

#pragma mark override super （重写父类）

#pragma mark setter （重写set方法）

#pragma mark - ---------- Protocol Methods（代理方法） ----------
#pragma mark ----------------UITableViewDataSource---------------------
#pragma mark ----------------UITableViewDelegate---------------------


@end

