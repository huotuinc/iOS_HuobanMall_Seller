//
//  HTDataStatisViewController.m
//  HuoBanMall
//
//  Created by lhb on 15/8/24.
//  Copyright (c) 2015年 HT. All rights reserved.
//  数据统计

#import "HTDataStatisViewController.h"
#import <BlocksKit.h>
#import <PNChart.h>
#import <POP.h>
#import "OrdorListModel.h"
#import "SaleModel.h"
#import "HTTopTenGoodsController.h"


#define StatisesCount 3
#define PageControllerHeight 20
@interface HTDataStatisViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,PNChartDelegate>


@property(nonatomic,strong) UIPageControl * pageControl;

@property(nonatomic,strong) NSMutableArray * scrollerviews;

@property(nonatomic,strong) UIScrollView * BackScrollerview;

/**---------------------------------------------------------------------*/
/**订单报表背景*/
@property (nonatomic, strong) UIView *OrdorBgView;

@property (nonatomic, strong) UIView *SaleBgView;

/**---------------------------------------------------------------------*/

/**订单总数统计*/
@property (nonatomic, strong) UILabel *ordorTotal;
/**订单当前统计*/
@property (nonatomic, strong) UILabel *ordorNewLabel;

/**销售额总数统计*/
@property (nonatomic, strong) UILabel *saleTotal;
/**订单当前统计*/
@property (nonatomic, strong) UILabel *saleNewLabel;

/**---------------------------------------------------------------------*/
/**图表*/
/**订单*/
@property(nonatomic,strong) PNLineChart * orderlineChart;
/**销售额sale*/
@property(nonatomic,strong) PNLineChart * salelineChart;
/**会员vip*/
@property(nonatomic,strong) PNLineChart * viplineChart;

/**数据模型**/
/**订单数据模型**/
@property (nonatomic, strong) OrdorListModel *ordorModel;
/**销售额数据模型**/
@property (nonatomic, strong) SaleModel *saleModel;

@end

@implementation HTDataStatisViewController

static NSString *popAnimation = @"first";

//- (NSArray *)titlesArray{
//    if (_titlesArray == nil) {
//        ;
//    }
//    return _titlesArray;
//}

- (NSMutableArray *)scrollerviews{
    if (_scrollerviews == nil) {
        _scrollerviews = [NSMutableArray array];
    }
    return _scrollerviews;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化滚地
    [self setupScrollView];
    //添加分页控件

    // 1、数据统计中第一个订单统计页面
    [self showOrderContrpller];
    // 2、数据统计中第二个销售额统计
    [self showSellCountStatistics];
    // 3、数据统计中第三个会员统计
    [self showVipPersonNumber];
    
    if (self.titlesArray.count == 0) {
        _titlesArray = @[@"订单",@"销售额",@"会员"];
    }
    
    
    [self _initSegment];
    
    
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.segment.selectedSegmentIndex = self.selectIndex;
    
    self.BackScrollerview.contentOffset = CGPointMake(ScreenWidth * self.segment.selectedSegmentIndex, 0);
    
    [self getNewData];
    
    
}

/**
 *  初始化头部选择器
 */
- (void)_initSegment
{
    self.segment = [[UISegmentedControl alloc] initWithItems:_titlesArray];
    [self.segment addTarget:self action:@selector(segmentChanged) forControlEvents:UIControlEventValueChanged];
    self.segment.tintColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = self.segment;
}

/**
 *  选择器点击方法
 */
- (void)segmentChanged {
    

    [UIView animateWithDuration:0.35 animations:^{
    self.BackScrollerview.contentOffset = CGPointMake(ScreenWidth * self.segment.selectedSegmentIndex, 0);
    self.BackScrollerview.frame = CGRectMake(0, 0, self.BackScrollerview.frame.size.width, self.BackScrollerview.frame.size.height);
    }];
    [self getNewData];
}


/**
 *添加  pageControll
 */
- (void)setupPageControll
{
    //添加
    UIPageControl *pageControll = [[UIPageControl alloc] init];
    pageControll.numberOfPages = StatisesCount;
//    pageControll.backgroundColor = [UIColor blueColor];
    CGFloat padgeW = 80;
    CGFloat padgeX = (self.view.frame.size.width - padgeW)* 0.5;
    CGFloat padgeY = 64;
    CGFloat padgeH = PageControllerHeight;
    pageControll.frame = CGRectMake(padgeX, padgeY, padgeW, padgeH);
    pageControll.userInteractionEnabled = NO;
    pageControll.bounds = CGRectMake(0, 0, 60, 40);
    [self.view addSubview:pageControll];
    //page
    self.pageControl= pageControll;
    //设置圆点颜色
    pageControll.currentPageIndicatorTintColor = [UIColor grayColor];
    pageControll.pageIndicatorTintColor = [UIColor blueColor];
    
    [self.scrollerviews addObject:pageControll];
    
}

/**
 *  1、数据统计中第一个订单统计页面
 */
- (void)showOrderContrpller{
    UIView * scr = self.scrollerviews[0];
    
    CGFloat imageX = 16;
    CGFloat imageY = 18;
    CGFloat imageW = 36;
    CGFloat imageH = 36;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
    imageView.image = [UIImage imageNamed:@"ddzs"];
    [scr addSubview:imageView];
    
    //数字
    CGFloat titleLableX = imageX + imageW + 8;
    CGFloat titleLableY = imageY;
    CGFloat titleLableW = self.view.frame.size.width-2*titleLableX;
    CGFloat titleLableH = 20;

    self.ordorTotal = [[UILabel alloc] init];
    self.ordorTotal.font = [UIFont systemFontOfSize:20];
    self.ordorTotal.text = [NSString stringWithFormat:@""];
    self.ordorTotal.frame = CGRectMake(titleLableX, titleLableY, titleLableW, titleLableH);
    [scr addSubview:self.ordorTotal];
  
    
    //文字解释
    UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLableX, titleLableY + titleLableH , titleLableW, titleLableH)];
    explainLabel.font = [UIFont systemFontOfSize:12];
    explainLabel.text = [NSString stringWithFormat:@"订单总数"];
    [scr addSubview:explainLabel];
    
    
    CGFloat timeViewX = 2;
    CGFloat timeViewY = imageY + imageH + 16;
    CGFloat timeViewW = ScreenWidth;
    CGFloat timeViewH = ScreenHeight * 0.06;
    UIView * timeView = [[UIView alloc] init];
    
    timeView.frame = CGRectMake(timeViewX, timeViewY, timeViewW, timeViewH);
//    timeView.backgroundColor = [UIColor redColor];
    [scr addSubview:timeView];
    
    //7日
    
    CGFloat weekX = ScreenWidth * 0.4;
    CGFloat weekY = 0;
    CGFloat weekW = ScreenWidth * 0.2;
    CGFloat weekH = timeViewH;
    
    UIView * week = [[UIView alloc] init];
    week.frame = CGRectMake(weekX, weekY, weekW, weekH);
    [timeView addSubview:week];
    
    UILabel * weekLable = [[UILabel alloc] init];
    weekLable.text = @"七日";
    weekLable.textColor = [UIColor blackColor];
    weekLable.frame = CGRectMake(0, 0, weekW, weekH);
    weekLable.textAlignment = NSTextAlignmentCenter;
    [week addSubview:weekLable];
    
    //本月
    
    CGFloat monthX = ScreenWidth * 0.7;
    CGFloat monthY = 0;
    CGFloat monthW = weekW;
    CGFloat monthH = weekH;
    UIView * month = [[UIView alloc] init];
    month.frame = CGRectMake(monthX, monthY, monthW, monthH);
    [timeView addSubview:month];
    
    UILabel * monthLable = [[UILabel alloc] init];
    monthLable.text = @"本月";
    monthLable.textColor = [UIColor blackColor];
    monthLable.frame = CGRectMake(0, 0, monthW, monthH);
    monthLable.textAlignment = NSTextAlignmentCenter;
    [month addSubview:monthLable];
    
    
    //今日
    CGFloat todayX = ScreenWidth * 0.1;
    CGFloat todayY = 0;
    CGFloat todayW = weekW;
    CGFloat todayH = weekH;
    UIView *today = [[UIView alloc] init];
    today.frame = CGRectMake(todayX, todayY, todayW, todayH);
    [timeView addSubview:today];
    
    UILabel *todayLabel = [[UILabel alloc] init];
    todayLabel.text = @"今日";
    todayLabel.textColor = [UIColor blackColor];
    todayLabel.frame = CGRectMake(0, 0, todayW, todayH);
    todayLabel.textAlignment = NSTextAlignmentCenter;
    [today addSubview:todayLabel];
    
    //红色小按钮
    CGFloat selectedY = todayH - 3;
    UIView *selected = [[UIView alloc] initWithFrame:CGRectMake(weekX, selectedY, todayW, 3)];
    selected.backgroundColor = [UIColor redColor];
    [timeView addSubview:selected];
    
#pragma mark 订单的点击事件
    //设置点击事件
    [week bk_whenTapped:^{
        if (selected.frame.origin.x != weekX) {
            [self changeOrdorPNChartWithType:1];
            self.ordorNewLabel.text = [NSString stringWithFormat:@"当前统计:%@", self.ordorModel.weekAmount];
            [UIView animateWithDuration:0.35 animations:^{
                selected.frame = CGRectMake(weekX, selectedY, todayW, 3);
            }];
        }
    }];
    
    [today bk_whenTapped:^{
        if (selected.frame.origin.x != todayX) {
            [self changeOrdorPNChartWithType:0];
            self.ordorNewLabel.text = [NSString stringWithFormat:@"当前统计:%@", self.ordorModel.todayAmount];
            [UIView animateWithDuration:0.35 animations:^{
                selected.frame = CGRectMake(todayX, selectedY, todayW, 3);
            }];
        }
    }];
    
    [month bk_whenTapped:^{
        if (selected.frame.origin.x != monthX) {
            [self changeOrdorPNChartWithType:2];
            self.ordorNewLabel.text = [NSString stringWithFormat:@"当前统计:%@", self.ordorModel.monthAmount];
            [UIView animateWithDuration:0.35 animations:^{
                selected.frame = CGRectMake(monthX, selectedY, todayW, 3);
            }];
        }
    }];
    
    //画灰色线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(-2, 0, timeViewW + 2, 1)];
    line1.backgroundColor = [UIColor colorWithWhite:0.682 alpha:1.000];
    [timeView addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(-2, timeViewH, timeViewW + 2, 1)];
    line2.backgroundColor = [UIColor colorWithWhite:0.682 alpha:1.000];
    [timeView addSubview:line2];
    
    
    
    //设置view显示当前统计等
    CGFloat statisticsX = 0;
    CGFloat statisticsY = timeViewY + timeViewH + 1;
    CGFloat statisticsW = ScreenWidth;
    CGFloat statisticsH = ScreenHeight * .03257;
    
    UIView *statistics = [[UIView alloc] initWithFrame:CGRectMake(statisticsX, statisticsY, statisticsW, statisticsH)];
    statistics.backgroundColor = [UIColor colorWithWhite:0.910 alpha:1.000];
    [scr addSubview:statistics];
    
    self.ordorNewLabel = [[UILabel alloc] init];
    self.ordorNewLabel.text = @"当前统计:";
    self.ordorNewLabel.font = [UIFont systemFontOfSize:12];
    self.ordorNewLabel.frame = CGRectMake(ScreenWidth * .05625, 2, ScreenWidth * .5, statisticsH - 4);
    [statistics addSubview:self.ordorNewLabel];
    
    
    CGFloat pnchartX = 2;
    CGFloat pnchartY = statisticsY + statisticsH;
    CGFloat pnchartW = self.view.frame.size.width-4;
    CGFloat pnchartH = self.view.frame.size.height*0.3;
    self.OrdorBgView = [[UIView alloc] init];
    self.OrdorBgView.frame = CGRectMake(pnchartX, pnchartY, pnchartW, pnchartH);
    
    
    CGFloat seperateLineX = 5;
    CGFloat seperateLineY = pnchartY+pnchartH+3;
    CGFloat seperateLineW = self.view.frame.size.width - 2 * seperateLineX ;
    CGFloat seperateLineH = 0.7;
    UIView * seperateLine = [[UIView alloc] init];
    seperateLine.backgroundColor = [UIColor blackColor];
    seperateLine.alpha = 0.7;
    seperateLine.frame = CGRectMake(seperateLineX, seperateLineY, seperateLineW, seperateLineH);
    [scr addSubview:seperateLine];
    
    
    //设置下方灰框
    CGFloat topGoodLableX = ScreenWidth * 0.05;
    CGFloat topGoodLableY = seperateLineY + seperateLineH + 20;
    CGFloat topGoodLableW = ScreenWidth * 0.9;
    CGFloat topGoodLableH = ScreenHeight * .075;
    UIView *topGoodView = [[UIView alloc] initWithFrame:CGRectMake(topGoodLableX, topGoodLableY, topGoodLableW, topGoodLableH)];
    topGoodView.backgroundColor = [UIColor colorWithWhite:0.890 alpha:1.000];
    topGoodView.layer.borderWidth = 1;
    topGoodView.layer.borderColor = [UIColor colorWithWhite:0.890 alpha:1.000].CGColor;
    topGoodView.layer.cornerRadius = 5;
    
    topGoodView.userInteractionEnabled = YES;
    [topGoodView bk_whenTapped:^{
        HTTopTenGoodsController *top = [[HTTopTenGoodsController alloc] init];
        [self.navigationController pushViewController:top animated:YES];
    }];
    
    [scr addSubview:topGoodView];
    
    
    
    //箭头位置
    UIImageView *JTiamge = [[UIImageView alloc] initWithFrame:CGRectMake(topGoodLableW - topGoodLableH * 0.4 - 10, topGoodLableH * 0.3, topGoodLableH * 0.4, topGoodLableH * 0.4)];
    JTiamge.image = [UIImage imageNamed:@"jt"];
    [topGoodView addSubview:JTiamge];
    
    //框里面的文字位置
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, topGoodLableH * 0.1, topGoodLableW * 0.6, topGoodLableH * 0.8)];
    label.text = @"商品销量前10名排行";
    label.font = [UIFont systemFontOfSize:16];
    [topGoodView addSubview:label];
    
}

/**
 *  2、数据统计中第二个销售额统计
 */
- (void)showSellCountStatistics{
    
    UIView * scr = self.scrollerviews[1];
    
    CGFloat imageX = 16;
    CGFloat imageY = 18;
    CGFloat imageW = 36;
    CGFloat imageH = 36;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
    imageView.image = [UIImage imageNamed:@"xsze"];
    [scr addSubview:imageView];
    
    //数字
    CGFloat titleLableX = imageX + imageW + 8;
    CGFloat titleLableY = imageY;
    CGFloat titleLableW = self.view.frame.size.width-2*titleLableX;
    CGFloat titleLableH = 20;
    self.saleTotal = [[UILabel alloc] init];
    self.saleTotal.font = [UIFont systemFontOfSize:20];
    self.saleTotal.text = [NSString stringWithFormat:@""];
    self.saleTotal.frame = CGRectMake(titleLableX, titleLableY, titleLableW, titleLableH);
    [scr addSubview:self.saleTotal];
    
    //文字解释
    UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLableX, titleLableY + titleLableH , titleLableW, titleLableH)];
    explainLabel.font = [UIFont systemFontOfSize:12];
    explainLabel.text = [NSString stringWithFormat:@"销售总额"];
    [scr addSubview:explainLabel];
    
    
    CGFloat timeViewX = 2;
    CGFloat timeViewY = imageY + imageH + 16;
    CGFloat timeViewW = ScreenWidth;
    CGFloat timeViewH = ScreenHeight * 0.06;
    UIView * timeView = [[UIView alloc] init];
    
    timeView.frame = CGRectMake(timeViewX, timeViewY, timeViewW, timeViewH);
    //    timeView.backgroundColor = [UIColor redColor];
    [scr addSubview:timeView];
    
    //7日
    
    CGFloat weekX = ScreenWidth * 0.4;
    CGFloat weekY = 0;
    CGFloat weekW = ScreenWidth * 0.2;
    CGFloat weekH = timeViewH;
    
    UIView * week = [[UIView alloc] init];
    week.frame = CGRectMake(weekX, weekY, weekW, weekH);
    [timeView addSubview:week];
    
    UILabel * weekLable = [[UILabel alloc] init];
    weekLable.text = @"七日";
    weekLable.textColor = [UIColor blackColor];
    weekLable.frame = CGRectMake(0, 0, weekW, weekH);
    weekLable.textAlignment = NSTextAlignmentCenter;
    [week addSubview:weekLable];
    
    //本月
    
    CGFloat monthX = ScreenWidth * 0.7;
    CGFloat monthY = 0;
    CGFloat monthW = weekW;
    CGFloat monthH = weekH;
    UIView * month = [[UIView alloc] init];
    month.frame = CGRectMake(monthX, monthY, monthW, monthH);
    [timeView addSubview:month];
    
    UILabel * monthLable = [[UILabel alloc] init];
    monthLable.text = @"本月";
    monthLable.textColor = [UIColor blackColor];
    monthLable.frame = CGRectMake(0, 0, monthW, monthH);
    monthLable.textAlignment = NSTextAlignmentCenter;
    [month addSubview:monthLable];
    
    
    //今日
    CGFloat todayX = ScreenWidth * 0.1;
    CGFloat todayY = 0;
    CGFloat todayW = weekW;
    CGFloat todayH = weekH;
    UIView *today = [[UIView alloc] init];
    today.frame = CGRectMake(todayX, todayY, todayW, todayH);
    [timeView addSubview:today];
    
    UILabel *todayLabel = [[UILabel alloc] init];
    todayLabel.text = @"今日";
    todayLabel.textColor = [UIColor blackColor];
    todayLabel.frame = CGRectMake(0, 0, todayW, todayH);
    todayLabel.textAlignment = NSTextAlignmentCenter;
    [today addSubview:todayLabel];
    
    //红色小按钮
    CGFloat selectedY = todayH - 3;
    UIView *selected = [[UIView alloc] initWithFrame:CGRectMake(weekX, selectedY, todayW, 3)];
    selected.backgroundColor = [UIColor redColor];
    [timeView addSubview:selected];
    
#pragma mark 销售额的点击事件
    //设置点击事件
    [week bk_whenTapped:^{
        if (selected.frame.origin.x != weekX) {
            [self changeSalePNChartWithType:1];
            self.saleNewLabel.text = [NSString stringWithFormat:@"当前统计:%@", self.saleModel.weekAmount];
            [UIView animateWithDuration:0.35 animations:^{
                selected.frame = CGRectMake(weekX, selectedY, todayW, 3);
            }];
        }
    }];
    
    [today bk_whenTapped:^{
        if (selected.frame.origin.x != todayX) {
            [self changeSalePNChartWithType:0];
            self.saleNewLabel.text = [NSString stringWithFormat:@"当前统计:%@", self.saleModel.todayAmount];
            [UIView animateWithDuration:0.35 animations:^{
                selected.frame = CGRectMake(todayX, selectedY, todayW, 3);
            }];
        }
    }];
    
    [month bk_whenTapped:^{
        if (selected.frame.origin.x != monthX) {
            [self changeSalePNChartWithType:2];
            self.saleNewLabel.text = [NSString stringWithFormat:@"当前统计:%@", self.saleModel.monthAmount];
            [UIView animateWithDuration:0.35 animations:^{
                selected.frame = CGRectMake(monthX, selectedY, todayW, 3);
            }];
        }
    }];
    
    //画灰色线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(-2, 0, timeViewW + 2, 1)];
    line1.backgroundColor = [UIColor colorWithWhite:0.682 alpha:1.000];
    [timeView addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(-2, timeViewH, timeViewW + 2, 1)];
    line2.backgroundColor = [UIColor colorWithWhite:0.682 alpha:1.000];
    [timeView addSubview:line2];
    
    
    
    //设置view显示当前统计等
    CGFloat statisticsX = 0;
    CGFloat statisticsY = timeViewY + timeViewH + 1;
    CGFloat statisticsW = ScreenWidth;
    CGFloat statisticsH = ScreenHeight * .03257;
    
    UIView *statistics = [[UIView alloc] initWithFrame:CGRectMake(statisticsX, statisticsY, statisticsW, statisticsH)];
    statistics.backgroundColor = [UIColor colorWithWhite:0.910 alpha:1.000];
    [scr addSubview:statistics];
    
    self.saleNewLabel = [[UILabel alloc] init];
    self.saleNewLabel.text = @"当前统计:";
    self.saleNewLabel.font = [UIFont systemFontOfSize:12];
    self.saleNewLabel.frame = CGRectMake(ScreenWidth * .05625, 2, ScreenWidth * .5, statisticsH - 4);
    [statistics addSubview:self.saleNewLabel];
    
    
    CGFloat pnchartX = 2;
    CGFloat pnchartY = statisticsY + statisticsH;
    CGFloat pnchartW = self.view.frame.size.width-4;
    CGFloat pnchartH = self.view.frame.size.height*0.3;
    self.SaleBgView = [[UIView alloc] init];
    self.SaleBgView.frame = CGRectMake(pnchartX, pnchartY, pnchartW, pnchartH);

    
    CGFloat seperateLineX = 5;
    CGFloat seperateLineY = pnchartY+pnchartH+3;
    CGFloat seperateLineW = self.view.frame.size.width - 2 * seperateLineX ;
    CGFloat seperateLineH = 0.7;
    UIView * seperateLine = [[UIView alloc] init];
    seperateLine.backgroundColor = [UIColor blackColor];
    seperateLine.alpha = 0.7;
    seperateLine.frame = CGRectMake(seperateLineX, seperateLineY, seperateLineW, seperateLineH);
    [scr addSubview:seperateLine];
    
    
    //设置下方灰框
    CGFloat topGoodLableX = ScreenWidth * 0.05;
    CGFloat topGoodLableY = seperateLineY + seperateLineH + 20;
    CGFloat topGoodLableW = ScreenWidth * 0.9;
    CGFloat topGoodLableH = ScreenHeight * .075;
    UIView *topGoodView = [[UIView alloc] initWithFrame:CGRectMake(topGoodLableX, topGoodLableY, topGoodLableW, topGoodLableH)];
    topGoodView.backgroundColor = [UIColor colorWithWhite:0.890 alpha:1.000];
    topGoodView.layer.borderWidth = 1;
    topGoodView.layer.borderColor = [UIColor colorWithWhite:0.890 alpha:1.000].CGColor;
    topGoodView.layer.cornerRadius = 5;
    [scr addSubview:topGoodView];
    
    //箭头位置
    UIImageView *JTiamge = [[UIImageView alloc] initWithFrame:CGRectMake(topGoodLableW - topGoodLableH * 0.4 - 10, topGoodLableH * 0.3, topGoodLableH * 0.4, topGoodLableH * 0.4)];
    JTiamge.image = [UIImage imageNamed:@"jt"];
    [topGoodView addSubview:JTiamge];
    
    //框里面的图片
    UIImageView *HeadImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, topGoodLableH * 0.3, topGoodLableH * .4, topGoodLableH * .4)];
    HeadImage.image = [UIImage imageNamed:@"ddzs"];
    [topGoodView addSubview:HeadImage];
    
    //框里面的文字位置
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 + topGoodLableH * .4 + 10, topGoodLableH * 0.1, topGoodLableW * 0.6, topGoodLableH * 0.8)];
    label.text = @"销售明细";
    label.font = [UIFont systemFontOfSize:16];
    [topGoodView addSubview:label];
    
}

/**
 *  3、数据统计中第三个会员统计
 */
- (void)showVipPersonNumber{
    UIView * scr = self.scrollerviews[2];
    
    CGFloat imageX = 16;
    CGFloat imageY = 18;
    CGFloat imageW = 36;
    CGFloat imageH = 36;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
    imageView.image = [UIImage imageNamed:@"zchyzrs"];
    [scr addSubview:imageView];
    
    //数字
    CGFloat titleLableX = imageX + imageW + 8;
    CGFloat titleLableY = imageY;
    CGFloat titleLableW = self.view.frame.size.width-2*titleLableX;
    CGFloat titleLableH = 20;
    UILabel * titleLable = [[UILabel alloc] init];
    titleLable.font = [UIFont systemFontOfSize:20];
    titleLable.text = [NSString stringWithFormat:@"123123123"];
    titleLable.frame = CGRectMake(titleLableX, titleLableY, titleLableW, titleLableH);
    [scr addSubview:titleLable];
    
    //文字解释
    UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLableX, titleLableY + titleLableH , titleLableW, titleLableH)];
    explainLabel.font = [UIFont systemFontOfSize:12];
    explainLabel.text = [NSString stringWithFormat:@"注册总人数"];
    [scr addSubview:explainLabel];
    
    //右侧文字 分销商
    CGFloat distriX = ScreenWidth * 0.48;
    CGFloat distriY = titleLableY + titleLableH;
    CGFloat distriW = ScreenWidth * 0.5;
    CGFloat distriH = 20;
    UILabel *distriLabel = [[UILabel alloc] initWithFrame:CGRectMake(distriX, distriY, distriW, distriH)];
    distriLabel.text = @"升级为分销商:35786";
    distriLabel.font = [UIFont systemFontOfSize:12];
    distriLabel.textAlignment = NSTextAlignmentRight;
    [scr addSubview:distriLabel];
    
    //会员
//    UILabel *memLabel = [[UILabel alloc] initWithFrame:CGRectMake(distriX, distriY + distriH + 2, distriW, distriH)];
//    memLabel.text = @"会员:1231321";
//    memLabel.font = [UIFont systemFontOfSize:12];
//    [scr addSubview:memLabel];
    
    
    CGFloat timeViewX = 2;
    CGFloat timeViewY = imageY + imageH + 16;
    CGFloat timeViewW = ScreenWidth;
    CGFloat timeViewH = ScreenHeight * 0.06;
    
    UIView * timeView = [[UIView alloc] init];
    
    timeView.frame = CGRectMake(timeViewX, timeViewY, timeViewW, timeViewH);
    //    timeView.backgroundColor = [UIColor redColor];
    [scr addSubview:timeView];
    
    //7日
    
    CGFloat weekX = ScreenWidth * 0.4;
    CGFloat weekY = 0;
    CGFloat weekW = ScreenWidth * 0.2;
    CGFloat weekH = timeViewH;
    
    UIView * week = [[UIView alloc] init];
    week.frame = CGRectMake(weekX, weekY, weekW, weekH);
    [timeView addSubview:week];
    
    UILabel * weekLable = [[UILabel alloc] init];
    weekLable.text = @"七日";
    weekLable.textColor = [UIColor blackColor];
    weekLable.frame = CGRectMake(0, 0, weekW, weekH);
    weekLable.textAlignment = NSTextAlignmentCenter;
    [week addSubview:weekLable];
    
    //本月
    
    CGFloat monthX = ScreenWidth * 0.7;
    CGFloat monthY = 0;
    CGFloat monthW = weekW;
    CGFloat monthH = weekH;
    UIView * month = [[UIView alloc] init];
    month.frame = CGRectMake(monthX, monthY, monthW, monthH);
    [timeView addSubview:month];
    
    UILabel * monthLable = [[UILabel alloc] init];
    monthLable.text = @"本月";
    monthLable.textColor = [UIColor blackColor];
    monthLable.frame = CGRectMake(0, 0, monthW, monthH);
    monthLable.textAlignment = NSTextAlignmentCenter;
    [month addSubview:monthLable];
    
    
    //今日
    CGFloat todayX = ScreenWidth * 0.1;
    CGFloat todayY = 0;
    CGFloat todayW = weekW;
    CGFloat todayH = weekH;
    UIView *today = [[UIView alloc] init];
    today.frame = CGRectMake(todayX, todayY, todayW, todayH);
    [timeView addSubview:today];
    
    UILabel *todayLabel = [[UILabel alloc] init];
    todayLabel.text = @"今日";
    todayLabel.textColor = [UIColor blackColor];
    todayLabel.frame = CGRectMake(0, 0, todayW, todayH);
    todayLabel.textAlignment = NSTextAlignmentCenter;
    [today addSubview:todayLabel];
    
    //红色小按钮
    CGFloat selectedY = todayH - 3;
    UIView *selected = [[UIView alloc] initWithFrame:CGRectMake(weekX, selectedY, todayW, 3)];
    selected.backgroundColor = [UIColor redColor];
    [timeView addSubview:selected];
    
#pragma mark 会员的点击事件
    //设置点击事件
    [week bk_whenTapped:^{
        if (selected.frame.origin.x != weekX) {
            [self changeValue2];
            [UIView animateWithDuration:0.35 animations:^{
                selected.frame = CGRectMake(weekX, selectedY, todayW, 3);
            }];
        }
    }];
    
    [today bk_whenTapped:^{
        if (selected.frame.origin.x != todayX) {
            [self changeValue2];
            [UIView animateWithDuration:0.35 animations:^{
                selected.frame = CGRectMake(todayX, selectedY, todayW, 3);
            }];
        }
    }];
    
    [month bk_whenTapped:^{
        if (selected.frame.origin.x != monthX) {
            [self changeValue2];
            [UIView animateWithDuration:0.35 animations:^{
                selected.frame = CGRectMake(monthX, selectedY, todayW, 3);
            }];
        }
    }];
    
    //画灰色线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(-2, 0, timeViewW + 2, 1)];
    line1.backgroundColor = [UIColor colorWithWhite:0.682 alpha:1.000];
    [timeView addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(-2, timeViewH, timeViewW + 2, 1)];
    line2.backgroundColor = [UIColor colorWithWhite:0.682 alpha:1.000];
    [timeView addSubview:line2];
    
    
    
    //设置view显示当前统计等
    CGFloat statisticsX = 0;
    CGFloat statisticsY = timeViewY + timeViewH + 1;
    CGFloat statisticsW = ScreenWidth;
    CGFloat statisticsH = ScreenHeight * .03257;
    
    UIView *statistics = [[UIView alloc] initWithFrame:CGRectMake(statisticsX, statisticsY, statisticsW, statisticsH)];
    statistics.backgroundColor = [UIColor colorWithWhite:0.910 alpha:1.000];
    [scr addSubview:statistics];
    
    
    CGFloat title1LableX = 10;
    CGFloat title1LableY =  2;
    CGFloat title1LableW =  60;
    CGFloat title1LableH =  statisticsH - 4;
    UILabel * title1Lable = [[UILabel alloc] init];
//    title1Lable.backgroundColor = [UIColor greenColor];
    title1Lable.text = @"当前统计:";
    title1Lable.font = [UIFont systemFontOfSize:12];
    title1Lable.frame = CGRectMake(title1LableX,title1LableY, title1LableW, title1LableH);
    [statistics addSubview:title1Lable];
    
    CGFloat redViewX = title1LableX+title1LableW;
    CGFloat redViewW = title1LableH-4;
    CGFloat redViewH = title1LableH-4;
    CGFloat redViewY = (statisticsH-redViewW)*0.5;
    UIView * redView = [[UIView alloc] init];
    redView.frame = CGRectMake(redViewX, redViewY, redViewW, redViewH);
    redView.backgroundColor = [UIColor redColor];
    [statistics addSubview:redView];
    
    //会员
    CGFloat vipLableX = redViewX+redViewW+2;
    CGFloat vipLableY = 2;
    CGFloat vipLableW = 40;
    CGFloat vipLableH = title1LableH;
    UILabel * vipLable = [[UILabel alloc] init];
    vipLable.text = @"会员:";
    vipLable.frame = CGRectMake(vipLableX, vipLableY, vipLableW, vipLableH);
    vipLable.font = [UIFont systemFontOfSize:12];
    [statistics addSubview:vipLable];
    
    CGFloat redNumberX = vipLableX+vipLableW-4;
    CGFloat redNumberY = 2;
    CGFloat redNumberW = 60;
    CGFloat redNumberH = title1LableH;
    UILabel * redNumber = [[UILabel alloc] init];
//    redNumber.backgroundColor = [UIColor redColor];
    redNumber.frame = CGRectMake(redNumberX, redNumberY, redNumberW, redNumberH);
    redNumber.font = [UIFont systemFontOfSize:12];
    redNumber.text = @"123";
    [statistics addSubview:redNumber];
    
    CGFloat blueViewX = redNumberX+redNumberW;
    CGFloat blueViewW = title1LableH-4;
    CGFloat blueViewH = title1LableH-4;
    CGFloat blueViewY = (statisticsH-redViewW)*0.5;
    UIView * blueView = [[UIView alloc] init];
    blueView.frame = CGRectMake(blueViewX, blueViewY, blueViewW, blueViewH);
    blueView.backgroundColor = [UIColor blueColor];
    [statistics addSubview:blueView];
    
    //会员
    CGFloat fenxiaoX = blueViewX+blueViewW+2;
    CGFloat fenxiaoY = 2;
    CGFloat fenxiaoW = 40;
    CGFloat fenxiaoH = title1LableH;
    UILabel * fenxiao = [[UILabel alloc] init];
    fenxiao.text = @"分销商:";
    fenxiao.frame = CGRectMake(fenxiaoX, fenxiaoY, fenxiaoW, fenxiaoH);
    fenxiao.font = [UIFont systemFontOfSize:12];
    [statistics addSubview:fenxiao];
    
    CGFloat fenxiaonX = fenxiaoX+fenxiaoW-2;
    CGFloat fenxiaonY = 2;
    CGFloat fenxiaonW = 60;
    CGFloat fenxiaonH = title1LableH;
    UILabel * fenxiaon = [[UILabel alloc] init];
//    fenxiaon.backgroundColor = [UIColor redColor];
    fenxiaon.frame = CGRectMake(fenxiaonX, fenxiaonY, fenxiaonW, fenxiaonH);
    fenxiaon.font = [UIFont systemFontOfSize:12];
    fenxiaon.text = @"123";
    [statistics addSubview:fenxiaon];
    
#warning 加方块和文字
    
    CGFloat pnchartX = 2;
    CGFloat pnchartY = statisticsY + statisticsH;
    CGFloat pnchartW = self.view.frame.size.width-4;
    CGFloat pnchartH = self.view.frame.size.height*0.3;
    UIView * pnchartView = [[UIView alloc] init];
    pnchartView.frame = CGRectMake(pnchartX, pnchartY, pnchartW, pnchartH);
    
    //创建绘图
    self.viplineChart = [self lineTwoPNChartWithFrame:pnchartView.frame];
    self.viplineChart.tag = 1;
    [pnchartView addSubview:self.viplineChart];
    [scr addSubview:pnchartView];
    
    CGFloat seperateLineX = 5;
    CGFloat seperateLineY = pnchartY+pnchartH+3;
    CGFloat seperateLineW = self.view.frame.size.width - 2 * seperateLineX ;
    CGFloat seperateLineH = 0.7;
    UIView * seperateLine = [[UIView alloc] init];
    seperateLine.backgroundColor = [UIColor blackColor];
    seperateLine.alpha = 0.7;
    seperateLine.frame = CGRectMake(seperateLineX, seperateLineY, seperateLineW, seperateLineH);
    [scr addSubview:seperateLine];
    
    
    //设置下方灰框
    CGFloat topGoodLableX = ScreenWidth * 0.05;
    CGFloat topGoodLableY = seperateLineY + seperateLineH + 20;
    CGFloat topGoodLableW = ScreenWidth * 0.9;
    CGFloat topGoodLableH = ScreenHeight * .075;
    UIView *topGoodView = [[UIView alloc] initWithFrame:CGRectMake(topGoodLableX, topGoodLableY, topGoodLableW, topGoodLableH)];
    topGoodView.backgroundColor = [UIColor colorWithWhite:0.890 alpha:1.000];
    topGoodView.layer.borderWidth = 1;
    topGoodView.layer.borderColor = [UIColor colorWithWhite:0.890 alpha:1.000].CGColor;
    topGoodView.layer.cornerRadius = 5;
    [scr addSubview:topGoodView];
    
    //箭头位置
    UIImageView *JTiamge = [[UIImageView alloc] initWithFrame:CGRectMake(topGoodLableW - topGoodLableH * 0.4 - 10, topGoodLableH * 0.3, topGoodLableH * 0.4, topGoodLableH * 0.4)];
    JTiamge.image = [UIImage imageNamed:@"jt"];
    [topGoodView addSubview:JTiamge];
    
    //框里面的图片
    UIImageView *HeadImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, topGoodLableH * 0.3, topGoodLableH * .4, topGoodLableH * .4)];
    HeadImage.image = [UIImage imageNamed:@"hyxhbfljftj"];
    [topGoodView addSubview:HeadImage];
    
    //框里面的文字位置
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 + topGoodLableH * .4 + 10, topGoodLableH * 0.1, topGoodLableW * 0.6, topGoodLableH * 0.8)];
    label.text = @"返利积分统计";
    label.font = [UIFont systemFontOfSize:16];
    [topGoodView addSubview:label];
    
    CGFloat topGood2X = topGoodLableX;
    CGFloat topGood2Y = topGoodLableY +  topGoodLableH + 5;
    CGFloat topGood2W = topGoodLableW;
    CGFloat topGood2H = topGoodLableH;
    
    //第二个框
    UIView *topGood2View = [[UIView alloc] initWithFrame:CGRectMake(topGood2X, topGood2Y, topGood2W, topGood2H)];
    topGood2View.backgroundColor = [UIColor colorWithWhite:0.890 alpha:1.000];
    topGood2View.layer.borderWidth = 1;
    topGood2View.layer.borderColor = [UIColor colorWithWhite:0.890 alpha:1.000].CGColor;
    topGood2View.layer.cornerRadius = 5;
    [scr addSubview:topGood2View];
    
    //箭头位置
    UIImageView *JTiamge1 = [[UIImageView alloc] initWithFrame:CGRectMake(topGoodLableW - topGoodLableH * 0.4 - 10, topGoodLableH * 0.3, topGoodLableH * 0.4, topGoodLableH * 0.4)];
    JTiamge1.image = [UIImage imageNamed:@"jt"];
    [topGood2View addSubview:JTiamge1];
    
    //框里面的图片
    UIImageView *HeadImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, topGoodLableH * 0.3, topGoodLableH * .4, topGoodLableH * .4)];
    HeadImage2.image = [UIImage imageNamed:@"hyxhbxftj"];
    [topGood2View addSubview:HeadImage2];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10 + topGoodLableH * .4 + 10, topGoodLableH * 0.1, topGoodLableW * 0.6, topGoodLableH * 0.8)];
    label1.text = @"返利积分统计";
    label1.font = [UIFont systemFontOfSize:16];
    [topGood2View addSubview:label1];

}

/**
 *  绘图新建PNChart
 *
 *  @param frame
 */
- (PNLineChart *)linePNChartWithOodorPNChartFrame:(CGRect)frame{
    
    
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, frame.size.height)];
    lineChart.yLabelFormat = @"%1.1f";
    lineChart.backgroundColor = [UIColor clearColor];
    [lineChart setXLabels:[self getNSNumberArrayWithArray:self.ordorModel.weekTimes]];
    lineChart.showCoordinateAxis = YES;
    
    lineChart.yValueMax = [[self getMaxFromArray:self.ordorModel.weekAmounts] floatValue] ;
    lineChart.yFixedValueMin = 0.0;
    lineChart.yValueMin = 0;
    
    [lineChart setYLabels:[self getArrayWithY:[[self getMaxFromArray:self.ordorModel.weekAmounts] integerValue]]];
    
//     Line Chart #1
    NSArray * data01Array = self.ordorModel.weekAmounts;
    PNLineChartData *data01 = [PNLineChartData new];
    data01.dataTitle = @"Alpha";
    data01.color = [UIColor colorWithRed:1.000 green:0.235 blue:0.000 alpha:1.000];
//    data01.alpha = 0.3f;
    data01.itemCount = data01Array.count;
    data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    lineChart.chartData = @[data01];
    [lineChart strokeChart];
    lineChart.delegate = self;
    
    return lineChart;
}

- (PNLineChart *)linePNChartWithSalePNChartFrame:(CGRect)frame{
    
    
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, frame.size.height)];
    lineChart.yLabelFormat = @"%1.1f";
    lineChart.backgroundColor = [UIColor clearColor];
    [lineChart setXLabels:[self getNSNumberArrayWithArray:self.saleModel.weekTimes]];
    lineChart.showCoordinateAxis = YES;
    
    lineChart.yValueMax = [[self getMaxFromArray:self.saleModel.weekAmounts] floatValue] ;
    lineChart.yFixedValueMin = 0.0;
    lineChart.yValueMin = 0;
    
    [lineChart setYLabels:[self getArrayWithY:[[self getMaxFromArray:self.saleModel.weekAmounts] integerValue]]];
    
    //     Line Chart #1
    NSArray * data01Array = self.saleModel.weekAmounts;
    PNLineChartData *data01 = [PNLineChartData new];
    data01.dataTitle = @"Alpha";
    data01.color = [UIColor colorWithRed:1.000 green:0.235 blue:0.000 alpha:1.000];
    //    data01.alpha = 0.3f;
    data01.itemCount = data01Array.count;
    data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    lineChart.chartData = @[data01];
    [lineChart strokeChart];
    lineChart.delegate = self;
    
    return lineChart;
}


- (PNLineChart *)lineTwoPNChartWithFrame:(CGRect)frame {
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, frame.size.height)];
    lineChart.yLabelFormat = @"%1.1f";
    lineChart.backgroundColor = [UIColor clearColor];
    [lineChart setXLabels:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"]];
    lineChart.showCoordinateAxis = YES;
    
    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
    lineChart.yFixedValueMax = 300.0;
    lineChart.yFixedValueMin = 0.0;
    lineChart.yValueMin = 0;
    
    [lineChart setYLabels:@[
                            @"50",
                            @"100",
                            @"150",
                            @"200",
                            ]
     ];
    
    // Line Chart #1
    NSArray * data01Array = @[@0,@0, @0, @0, @0.0, @0, @0, @176.2];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.dataTitle = @"Alpha";
    data01.color = [UIColor colorWithRed:1.000 green:0.235 blue:0.000 alpha:1.000];
//    data01.alpha = 0.3f;
    data01.itemCount = data01Array.count;
    data01.inflexionPointStyle = PNLineChartPointStyleSquare;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    NSArray *data02Array = @[@1,@1,@1,@1, @1,@1,@1,@136];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.dataTitle = @"Alphb";
    data02.color = [UIColor colorWithRed:0.004 green:0.553 blue:1.000 alpha:1.000];
//    data02.alpha = 0.3f;
    data02.itemCount = data02Array.count;
    data02.inflexionPointStyle = PNLineChartPointStyleCircle;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[data01,data02];
    [lineChart strokeChart];
    lineChart.delegate = self;
    
    return lineChart;
}


#pragma mark PNChart代理方法
- (void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex pointIndex:(NSInteger)pointIndex{//点击关键点
    NSLog(@"Click Key on line %f, %f line index is %d and point index is %d",point.x, point.y,(int)lineIndex, (int)pointIndex);
    
}

- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{//点击线上点
    NSLog(@"Click on line %f, %f, line index is %d",point.x, point.y, (int)lineIndex);
}

#pragma mark PNChart表改变值方法

- (void)changeValue1{
    // Line Chart #1
    NSArray * data01Array = @[@(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300)];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = [UIColor colorWithRed:1.000 green:0.235 blue:0.000 alpha:1.000];
    data01.itemCount = data01Array.count;
    data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    [self.salelineChart setXLabels:@[@"1",@"",@"",@"",@"",@"",@"7"]];
    [self.salelineChart updateChartData:@[data01]];
}

- (void)changeValue2{
    // Line Chart #1
    NSArray * data01Array = @[@(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300)];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = [UIColor colorWithRed:1.000 green:0.235 blue:0.000 alpha:1.000];;
    data01.itemCount = data01Array.count;
    data01.inflexionPointStyle = PNLineChartPointStyleSquare;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    NSArray * data02Array = @[@(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300)];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = [UIColor colorWithRed:0.004 green:0.553 blue:1.000 alpha:1.000];
    data02.itemCount = data01Array.count;
    data02.inflexionPointStyle = PNLineChartPointStyleCircle;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    [self.viplineChart setXLabels:@[@"1",@"",@"",@"",@"",@"",@"7"]];
    [self.viplineChart updateChartData:@[data01,data02]];
}

#pragma mark 添加滚地视图
/**
 *  scrollView image
 */
- (void)setupScrollView
{
    
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    self.BackScrollerview = scrollView;
    [self.view addSubview:scrollView];
    
    
    
    //2、添加图片
    CGFloat scrollW = scrollView.frame.size.width;
    CGFloat scrollH = scrollView.frame.size.height;
    for (int index = 0; index < 3; index++) {
        CGFloat scX = scrollW * index;
        CGFloat scY = 0;
        UIScrollView * sc = [[UIScrollView alloc] init];
        sc.tag = index;
        sc.frame = CGRectMake(scX, scY, scrollW, scrollH);
        [self.scrollerviews addObject:sc];
        [scrollView addSubview:sc];
        
    }
    //设置滚动内容范围尺寸
    scrollView.contentSize = CGSizeMake(scrollW*3, 0);
    
    //隐藏滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces =NO;
}



#pragma mark scorllView 代理方法

/**
 *  只要滚地就掉用这个方法
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat x =  scrollView.contentOffset.x;
    double padgeDouble = x / scrollView.frame.size.width;
    int padgeInt = (int)(padgeDouble + 0.5);
    if (self.segment.selectedSegmentIndex != padgeInt) {
        self.segment.selectedSegmentIndex = padgeInt;
        [self getNewData];
    }
    
}




#pragma mark 网络请求

- (void)getNewData {
    
    NSString *temp = [[NSString alloc] init];
    
    if (self.segment.selectedSegmentIndex == 0) {
        temp = @"orderReport";
    }else if (self.segment.selectedSegmentIndex == 1){
        temp = @"salesReport";
    }else {
        temp = @"userReport";
    }
    
    NSLog(@"%@", temp);
    
    [UserLoginTool loginRequestGet:temp parame:nil success:^(id json) {
        
        NSLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            switch (self.segment.selectedSegmentIndex) {
                case 0:
                {
                    self.ordorModel = [[OrdorListModel alloc] init];
                    
                    self.ordorModel.totalAmount = json[@"resultData"][@"totalAmount"];
                    self.ordorModel.todayAmount = json[@"resultData"][@"todayAmount"];
                    self.ordorModel.weekAmount = json[@"resultData"][@"weekAmount"];
                    self.ordorModel.monthAmount = json[@"resultData"][@"monthAmount"];
                    self.ordorModel.todayTimes = json[@"resultData"][@"todayTimes"];
                    self.ordorModel.todayAmounts = json[@"resultData"][@"todayAmounts"];
                    self.ordorModel.weekTimes = json[@"resultData"][@"weekTimes"];
                    self.ordorModel.weekAmounts = json[@"resultData"][@"weekAmounts"];
                    self.ordorModel.monthTimes = json[@"resultData"][@"monthTimes"];
                    self.ordorModel.monthAmounts = json[@"resultData"][@"monthAmounts"];
                    
                    self.ordorTotal.text = [NSString stringWithFormat:@"%@", self.ordorModel.totalAmount];
                    
                    if (self.orderlineChart) {
                        
                    }else {
                        [self _initOrdorPNchart];
                    }
                    
                    
                    
                    break;
                }
                case 1:
                {
                    self.saleModel = [[SaleModel alloc] init];
                    
                    self.saleModel.totalAmount = json[@"resultData"][@"totalAmount"];
                    self.saleModel.todayAmount = json[@"resultData"][@"todayAmount"];
                    self.saleModel.weekAmount = json[@"resultData"][@"weekAmount"];
                    self.saleModel.monthAmount = json[@"resultData"][@"monthAmount"];
                    self.saleModel.todayTimes = json[@"resultData"][@"todayTimes"];
                    self.saleModel.todayAmounts = json[@"resultData"][@"todayAmounts"];
                    self.saleModel.weekTimes = json[@"resultData"][@"weekTimes"];
                    self.saleModel.weekAmounts = json[@"resultData"][@"weekAmounts"];
                    self.saleModel.monthTimes = json[@"resultData"][@"monthTimes"];
                    self.saleModel.monthAmounts = json[@"resultData"][@"monthAmounts"];
                    
                    self.saleTotal.text = [NSString stringWithFormat:@"%@", self.saleModel.totalAmount];
                    
                    if (self.salelineChart) {
                        
                    }else {
                        [self _initSalePNchart];
                    }
                    
                    break;
                }
                case 2:
                {
                    break;
                }
                default:
                    break;
            }
        }

        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}


#pragma mark 初始化

- (void)_initSalePNchart {
    //创建绘图
    
    self.saleNewLabel.text = [NSString stringWithFormat:@"当前统计:%@", self.saleModel.weekAmount];
    
    UIView * scr = self.scrollerviews[1];
    
    [self getNSNumberArrayWithArray:self.saleModel.weekTimes];
    
    self.salelineChart = [self linePNChartWithSalePNChartFrame:self.SaleBgView.frame];
    self.salelineChart.tag = 2;
    [self.SaleBgView addSubview:self.salelineChart];
    [scr addSubview:self.SaleBgView];
}

- (void)changeSalePNChartWithType: (NSInteger)type {
    
    if (type == 0) {
        
        self.salelineChart.yValueMax = [[self getMaxFromArray:self.saleModel.todayAmounts] floatValue];
        [self.salelineChart setYLabels:[self getArrayWithY:[[self getMaxFromArray:self.saleModel.todayAmounts] integerValue]]];
        [self.salelineChart setXLabels:[self getNSStringArrayWithArray:self.saleModel.todayTimes]];
  
        NSArray * data01Array = self.saleModel.todayAmounts;
        PNLineChartData *data01 = [PNLineChartData new];
        data01.dataTitle = @"Alpha";
        data01.color = [UIColor colorWithRed:1.000 green:0.235 blue:0.000 alpha:1.000];
        //    data01.alpha = 0.3f;
        data01.itemCount = data01Array.count;
        data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [data01Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        self.salelineChart.chartData = @[data01];
        [self.salelineChart strokeChart];
        
    }else if (type == 1) {
        
        self.salelineChart.yValueMax = [[self getMaxFromArray:self.saleModel.weekAmounts] floatValue];
        [self.salelineChart setYLabels:[self getArrayWithY:[[self getMaxFromArray:self.saleModel.weekAmounts] integerValue]]];
        [self.salelineChart setXLabels:[self getNSNumberArrayWithArray:self.saleModel.weekTimes]];
        
        NSArray * data01Array = self.saleModel.weekAmounts;
        PNLineChartData *data01 = [PNLineChartData new];
        data01.dataTitle = @"Alpha";
        data01.color = [UIColor colorWithRed:1.000 green:0.235 blue:0.000 alpha:1.000];
        //    data01.alpha = 0.3f;
        data01.itemCount = data01Array.count;
        data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [data01Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        self.salelineChart.chartData = @[data01];
        [self.salelineChart strokeChart];
        
    }else {
        
        self.salelineChart.yValueMax = [[self getMaxFromArray:self.saleModel.monthAmounts] floatValue];
        [self.salelineChart setYLabels:[self getArrayWithY:[[self getMaxFromArray:self.saleModel.monthAmounts] integerValue]]];
        [self.salelineChart setXLabels:[self getNSNumberArrayWithArray:self.saleModel.monthTimes]];
        
        NSArray * data01Array = self.saleModel.monthAmounts;
        PNLineChartData *data01 = [PNLineChartData new];
        data01.dataTitle = @"Alpha";
        data01.color = [UIColor colorWithRed:1.000 green:0.235 blue:0.000 alpha:1.000];
        //    data01.alpha = 0.3f;
        data01.itemCount = data01Array.count;
        data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [data01Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        self.salelineChart.chartData = @[data01];
        [self.salelineChart strokeChart];
        
    }
    
}

- (void)_initOrdorPNchart {
    //创建绘图
    
    self.ordorNewLabel.text = [NSString stringWithFormat:@"当前统计:%@", self.ordorModel.weekAmount];
    
    UIView * scr = self.scrollerviews[0];
    
    [self getNSNumberArrayWithArray:self.ordorModel.weekTimes];
    
    self.orderlineChart = [self linePNChartWithOodorPNChartFrame:self.OrdorBgView.frame];
    self.orderlineChart.tag = 1;
    [self.OrdorBgView addSubview:self.orderlineChart];
    [scr addSubview:self.OrdorBgView];
}

- (void)changeOrdorPNChartWithType: (NSInteger)type {
    
    if (type == 0) {
        
        self.orderlineChart.yValueMax = [[self getMaxFromArray:self.ordorModel.todayAmounts] floatValue];
        [self.orderlineChart setYLabels:[self getArrayWithY:[[self getMaxFromArray:self.ordorModel.todayAmounts] integerValue]]];
        [self.orderlineChart setXLabels:[self getNSStringArrayWithArray:self.ordorModel.todayTimes]];
        
        NSArray * data01Array = self.ordorModel.todayAmounts;
        PNLineChartData *data01 = [PNLineChartData new];
        data01.dataTitle = @"Alpha";
        data01.color = [UIColor colorWithRed:1.000 green:0.235 blue:0.000 alpha:1.000];
        //    data01.alpha = 0.3f;
        data01.itemCount = data01Array.count;
        data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [data01Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        self.orderlineChart.chartData = @[data01];
        [self.orderlineChart strokeChart];
        
    }else if (type == 1) {
        
        self.orderlineChart.yValueMax = [[self getMaxFromArray:self.ordorModel.weekAmounts] floatValue];
        [self.orderlineChart setYLabels:[self getArrayWithY:[[self getMaxFromArray:self.ordorModel.weekAmounts] integerValue]]];
        [self.orderlineChart setXLabels:[self getNSNumberArrayWithArray:self.ordorModel.weekTimes]];
        
        NSArray * data01Array = self.ordorModel.weekAmounts;
        PNLineChartData *data01 = [PNLineChartData new];
        data01.dataTitle = @"Alpha";
        data01.color = [UIColor colorWithRed:1.000 green:0.235 blue:0.000 alpha:1.000];
        //    data01.alpha = 0.3f;
        data01.itemCount = data01Array.count;
        data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [data01Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        self.orderlineChart.chartData = @[data01];
        [self.orderlineChart strokeChart];
        
    }else {
        
        self.orderlineChart.yValueMax = [[self getMaxFromArray:self.ordorModel.monthAmounts] floatValue];
        [self.orderlineChart setYLabels:[self getArrayWithY:[[self getMaxFromArray:self.ordorModel.monthAmounts] integerValue]]];
        [self.orderlineChart setXLabels:[self getNSNumberArrayWithArray:self.ordorModel.monthTimes]];
        
        NSArray * data01Array = self.ordorModel.monthAmounts;
        PNLineChartData *data01 = [PNLineChartData new];
        data01.dataTitle = @"Alpha";
        data01.color = [UIColor colorWithRed:1.000 green:0.235 blue:0.000 alpha:1.000];
        //    data01.alpha = 0.3f;
        data01.itemCount = data01Array.count;
        data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [data01Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        self.orderlineChart.chartData = @[data01];
        [self.orderlineChart strokeChart];
        
    }
    
}


#pragma mark 计算操作
- (NSNumber *)getMaxFromArray:(NSArray *)array {
    
    NSNumber *a = 0;
    
    for (NSNumber *num in array) {
        
        if (num > a) {
            a = num;
        }
    }
    
    return a;
}

- (NSArray *)getArrayWithY:(NSInteger) num {
    NSArray *array = [NSArray array];
    
    NSInteger i;
    
    if (num % 100 == 0) {
        i = num / 100;
    }else {
        i = num / 100 + 1;
    }
    array = @[[NSString stringWithFormat:@"%d", i * 25],[NSString stringWithFormat:@"%d", i * 50],[NSString stringWithFormat:@"%d", i * 75],[NSString stringWithFormat:@"%d", i * 100]];
    
    return array;
}

- (NSArray *)getNSStringArrayWithArray:(NSArray *)array {
    
    NSMutableArray *temp = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        [temp addObject:[NSString stringWithFormat:@"%@时", array[i]]];
    }
    
    NSArray *temp1 = temp;
    
    return temp1;
}

- (NSArray *)getNSNumberArrayWithArray:(NSArray *) array {
    
    NSMutableArray *temp = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[array[i] doubleValue] / 1000];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd"];
        NSString *str = [dateFormatter stringFromDate:date];
        NSString *str1 = [NSString stringWithFormat:@"%@日", str];
        [temp addObject:str1];
    }
    
    return temp;
}

@end
