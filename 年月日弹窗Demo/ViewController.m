//
//  ViewController.m
//  年月日弹窗Demo
//
//  Created by 辛忠志 on 2017/7/19.
//  Copyright © 2017年 辛忠志. All rights reserved.
//

#define kSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define HRWeak(weakSelf) __weak typeof(self) weakSelf = self
#define HRXIB(Class) [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([Class class]) owner:nil options:nil] firstObject];
#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#import "ViewController.h"
#import "PopDatePickerView.h"

@interface ViewController ()
{
    NSString * BJStartTime;/*开始时间戳*/
    NSString * BJEndTime;/*结束时间戳*/
}
@property (strong,nonatomic)PopDatePickerView * popDataPicker;/*时间弹出*/
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

@end

@implementation ViewController
#pragma mark - ---------- Lazy Loading（懒加载） ----------
- (PopDatePickerView *)popDataPicker{
    if (!_popDataPicker) {
        _popDataPicker =HRXIB(PopDatePickerView);
    }
    return _popDataPicker;
}
#pragma mark - ----------   Lifecycle（生命周期） ----------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.popDataPicker];
    self.popDataPicker.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - ---------- Private Methods（私有方法） ----------

#pragma mark initliaze data(初始化数据)

#pragma mark config control（布局控件）

#pragma mark networkRequest (网络请求)

#pragma mark actions （点击事件）

#pragma mark IBActions （点击事件xib）

#pragma mark - ---------- Public Methods（公有方法） ----------

#pragma mark self declare （本类声明）

#pragma mark override super （重写父类）

#pragma mark setter （重写set方法）

#pragma mark - ---------- Protocol Methods（代理方法） ----------
#pragma mark ----------------UITableViewDataSource---------------------
#pragma mark ----------------UITableViewDelegate---------------------
- (IBAction)startTimeClick:(UIButton *)sender {
    switch (sender.tag) {
        case 100:
        {
            [self.popDataPicker fadeIn];
            HRWeak(weakSelf);
            self.popDataPicker.confirmBlock = ^(NSString *choseDate, NSString *restDate) {
                weakSelf.startTimeLabel.text =  choseDate;//选择的生日

                NSString * timeSp = [weakSelf date:choseDate];
                NSLog(@"timeSp:%@",timeSp);
                BJStartTime = timeSp;
                /*在这计算时间 获得的时间戳是十位的 需要除以 ／3600/24 这样才能获得两个月份的 数*/
                NSInteger timeC = [BJEndTime integerValue]-[BJStartTime integerValue];
                NSInteger time = (timeC/3600/24)+1;
                if (time>=0) {
                    weakSelf.dayLabel.textColor = kUIColorFromRGB(0X323232);
                    weakSelf.dayLabel.text = [NSString stringWithFormat:@"请假天数为:%ld天",time];
                }
                else{
                    weakSelf.dayLabel.text = @"请选择正确的时间节点";
                    weakSelf.dayLabel.textColor = [UIColor redColor];
                }
                [weakSelf.popDataPicker fadeOut];
            };
            self.popDataPicker.cannelBlock = ^(){
                [weakSelf.popDataPicker fadeOut];
            };
        }
            break;
        case 101:
        {
            
            [self.popDataPicker fadeIn];
            HRWeak(weakSelf);
            self.popDataPicker.confirmBlock = ^(NSString *choseDate, NSString *restDate) {
                weakSelf.endTimeLabel.text =  choseDate;//选择的生日
                
                NSString * timeSp = [weakSelf date:choseDate];
                NSLog(@"timeSp:%@",timeSp);
                BJEndTime = timeSp;
                /*在这计算时间 获得的时间戳是十位的 需要除以 ／3600/24 这样才能获得两个月份的 数*/
                NSInteger timeC = [BJEndTime integerValue]-[BJStartTime integerValue];
                NSInteger time = (timeC/3600/24)+1;
                if (time>=0) {
                    weakSelf.dayLabel.textColor = kUIColorFromRGB(0X323232);
                    weakSelf.dayLabel.text = [NSString stringWithFormat:@"请假天数为:%ld天",time];
                }
                else{
                    weakSelf.dayLabel.text = @"请选择正确的时间节点";
                    weakSelf.dayLabel.textColor = [UIColor redColor];
                }
                [weakSelf.popDataPicker fadeOut];
            };
            self.popDataPicker.cannelBlock = ^(){
                [weakSelf.popDataPicker fadeOut];
            };
        }
            break;
            
        default:
            break;
    }
}
-(NSString*)date:(NSString*)choseDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:choseDate];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
