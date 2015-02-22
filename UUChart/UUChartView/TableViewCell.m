//
//  TableViewCell.m
//  UUChartView
//
//  Created by shake on 15/1/4.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import "TableViewCell.h"
#import "UUChart.h"

@interface TableViewCell ()<UUChartDataSource>
{
    NSIndexPath *path;
    UUChart *chartView;
}
@end

@implementation TableViewCell

- (void)configUI:(NSIndexPath *)indexPath
{
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    
    path = indexPath;
    
    chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 150)
                                              withSource:self
                                               withStyle:indexPath.section==1?UUChartBarStyle:UUChartLineStyle];
    [chartView showInView:self.contentView];
}

- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array];
    for (int i=0; i<num; i++) {
        NSString * str = [NSString stringWithFormat:@"R-%d",i];
        [xTitles addObject:str];
    }
    return xTitles;
}

- (NSArray *)getXNames
{
    return @[@"Sports", @"Tech", @"Financial", @"Art", @"Tour"];
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)UUChart_xLableArray:(UUChart *)chart
{

    if (path.section==0) {
        return [self getDateArray];
    }else{
        return [self getXNames];
    }
    return [self getXTitles:20];
}

- (NSArray*)getDateArray{
    NSMutableArray *dateary = [[NSMutableArray alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    int week = (int)[comps week];
    for (int j = week - 4; j <= week; j ++) {
        int weekday = (j + 8) % 7;
        switch (weekday) {
            case 1:
                NSLog(@"星期一");
                [dateary addObject:@"星期一"];
                break;
            case 2:
                NSLog(@"星期二");
                [dateary addObject:@"星期二"];
                break;
            case 3:
                NSLog(@"星期三");
                [dateary addObject:@"星期三"];
                break;
            case 4:
                NSLog(@"星期四");
                [dateary addObject:@"星期四"];
                break;
            case 5:
                NSLog(@"星期五");
                [dateary addObject:@"星期五"];
                break;
            case 6:
                NSLog(@"星期六");
                [dateary addObject:@"星期六"];
                break;
            case 0:
                NSLog(@"星期日");
                [dateary addObject:@"星期日"];
                break;
            default:
                break;
        }
    }
    return (NSArray*)dateary;
}

//数值多重数组
- (NSArray *)UUChart_yValueArray:(UUChart *)chart
{
    NSArray *ary = @[@"22",@"44",@"15",@"40",@"42"];
    NSArray *ary1 = @[@"22",@"54",@"15",@"30",@"42"];
    NSArray *ary2 = @[@"76",@"34",@"54",@"23",@"15"];
    NSArray *ary3 = @[@"23",@"12",@"25",@"55",@"52"];
    
    if (path.section==0) {
        return @[ary, ary1, ary3];
    }else{
        return @[ary2];
    }
}

#pragma mark - @optional
//颜色数组
- (NSArray *)UUChart_ColorArray:(UUChart *)chart
{
    return @[UUGreen,UURed,UUTwitterColor, UUWeiboColor];
}
//显示数值范围
- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart
{
    if (path.section==0 && (path.row==0|path.row==1)) {
        return CGRangeMake(60, 10);
    }
    if (path.section==1 && path.row==0) {
        return CGRangeMake(60, 10);
    }
    if (path.row==2) {
        return CGRangeMake(100, 0);
    }
    return CGRangeZero;
}

#pragma mark 折线图专享功能

//判断显示横线条

- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}
@end
