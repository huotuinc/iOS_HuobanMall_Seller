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



#define StatisesCount 3
#define PageControllerHeight 20
@interface HTDataStatisViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,PNChartDelegate>


@property(nonatomic,strong) UIPageControl * pageControl;

@property(nonatomic,strong) NSMutableArray * scrollerviews;

@property(nonatomic,strong) UIScrollView * BackScrollerview;

/**---------------------------------------------------------------------*/
//订单order
/**一周7天统计数量*/
@property(nonatomic,strong) UILabel * orderweekNumberLableValue;
/**本月统计数量*/
@property(nonatomic,strong) UILabel * ordermonthNumberLableValue;
//销售额sale
/**一周7天统计数量*/
@property(nonatomic,strong) UILabel * saleweekNumberLableValue;
/**本月统计数量*/
@property(nonatomic,strong) UILabel * salemonthNumberLableValue;
//会员vip
/**会员一周7天统计数量*/
@property(nonatomic,strong) UILabel * vipweekNumberLableValue;
/**小伙伴一周7天统计数量*/
@property(nonatomic,strong) UILabel * partnerweekNumberLableValue;
/**会员本月统计数量*/
@property(nonatomic,strong) UILabel * vipmonthNumberLableValue;
/**小伙伴本月统计数量*/
@property(nonatomic,strong) UILabel * partnermonthNumberLableValue;
/**---------------------------------------------------------------------*/

/**图表*/
/**订单*/
@property(nonatomic,strong) PNLineChart * orderlineChart;
/**销售额sale*/
@property(nonatomic,strong) PNLineChart * salelineChart;
/**会员vip*/
@property(nonatomic,strong) PNLineChart * viplineChart;



@end

@implementation HTDataStatisViewController

static NSString *popAnimation = @"first";

//- (NSArray *)titlesArray{
//    if (_titlesArray == nil) {
//        _titlesArray = @[@"订单",@"销售额",@"会员"];
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
//    [self setupPageControll];
    // 1、数据统计中第一个订单统计页面
    [self showOrderContrpller];
    // 2、数据统计中第二个销售额统计
    [self showSellCountStatistics];
    // 3、数据统计中第三个会员统计
    [self showVipPersonNumber];
    
    [self _initSegment];
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.translucent = NO;
    
//    [self _removeNavBackgroundColor];
}

/**
 *  初始化头部选择器
 */
- (void)_initSegment
{
    self.segment = [[UISegmentedControl alloc] initWithItems:_titlesArray];
    self.segment.selectedSegmentIndex = 0;
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
    UILabel * titleLable = [[UILabel alloc] init];
    titleLable.font = [UIFont systemFontOfSize:20];
    titleLable.text = [NSString stringWithFormat:@"123123123"];
    titleLable.frame = CGRectMake(titleLableX, titleLableY, titleLableW, titleLableH);
    [scr addSubview:titleLable];
    
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
    [week bk_whenTapped:^{
        [self changeValue];
    }];
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
    [month bk_whenTapped:^{
        
    }];
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
    [today bk_whenTapped:^{
        
    }];
    [timeView addSubview:today];
    
    UILabel *todayLabel = [[UILabel alloc] init];
    todayLabel.text = @"今日";
    todayLabel.textColor = [UIColor blackColor];
    todayLabel.frame = CGRectMake(0, 0, todayW, todayH);
    todayLabel.textAlignment = NSTextAlignmentCenter;
    [today addSubview:todayLabel];
    
    //画灰色线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, timeViewW, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    
    
    
    
    UILabel * title1Lable = [[UILabel alloc] init];
    title1Lable.text = @"数据分析（本周/本月）";
    CGFloat title1LableX = 5;
    CGFloat title1LableY = timeViewY + timeViewH;
    CGFloat title1LableW = timeViewW-2*timeViewX;
    CGFloat title1LableH = 40;
    title1Lable.frame = CGRectMake(title1LableX, title1LableY, title1LableW, title1LableH);
    
    [scr addSubview:title1Lable];
    
    
    CGFloat pnchartX = 2;
    CGFloat pnchartY = title1LableY+title1LableH;
    CGFloat pnchartW = self.view.frame.size.width-4;
    CGFloat pnchartH = self.view.frame.size.height*0.3;
    UIView * pnchartView = [[UIView alloc] init];
    pnchartView.frame = CGRectMake(pnchartX, pnchartY, pnchartW, pnchartH);
    
    //创建绘图
    self.orderlineChart = [self linePNChartWithFrame:pnchartView.frame];
    self.orderlineChart.tag = 1;
//    self.orderlineChart.backgroundColor = [UIColor colorWithRed:0.004 green:0.553 blue:1.000 alpha:1.000];
    [pnchartView addSubview:self.orderlineChart];
    [scr addSubview:pnchartView];
    
    UILabel * topGoodLable = [[UILabel alloc] init];
    topGoodLable.text = @"商品购买量排行 (Top10)";
    CGFloat topGoodLableX = 5;
    CGFloat topGoodLableY = pnchartY+pnchartH+2;
    CGFloat topGoodLableW = timeViewW-2*timeViewX;
    CGFloat topGoodLableH = 40;
    topGoodLable.frame = CGRectMake(topGoodLableX, topGoodLableY, topGoodLableW, topGoodLableH);
    [scr addSubview:topGoodLable];
    
    
    CGFloat seperateLineX = 5;
    CGFloat seperateLineY = topGoodLableY+topGoodLableH+3;
    CGFloat seperateLineW = self.view.frame.size.width - 2 * seperateLineX ;
    CGFloat seperateLineH = 0.7;
    UIView * seperateLine = [[UIView alloc] init];
    seperateLine.backgroundColor = [UIColor blackColor];
    seperateLine.alpha = 0.7;
    seperateLine.frame = CGRectMake(seperateLineX, seperateLineY, seperateLineW, seperateLineH);
    [scr addSubview:seperateLine];
    
    
    CGFloat topGoodTableViewX = 5;
    CGFloat topGoodTableViewY = seperateLineY + 3+10;
    CGFloat topGoodTableViewW = self.view.frame.size.width - 2 * seperateLineX ;
    CGFloat topGoodTableViewH = 10 * 44;
    UITableView * topGoodTableView = [[UITableView alloc] init];
    topGoodTableView.delegate = self;
    topGoodTableView.dataSource = self;
    topGoodTableView.frame = CGRectMake(topGoodTableViewX, topGoodTableViewY, topGoodTableViewW, topGoodTableViewH);
    topGoodTableView.scrollEnabled = NO;
    topGoodTableView.backgroundColor = [UIColor redColor];
    [scr addSubview:topGoodTableView];
    
    
    
}

/**
 *  2、数据统计中第二个销售额统计
 */
- (void)showSellCountStatistics{
    
    UIScrollView * scr = self.scrollerviews[1];

    CGFloat titleLableX = 2;
    CGFloat titleLableY = 0;
    CGFloat titleLableW = self.view.frame.size.width-2*titleLableX;
    CGFloat titleLableH = 40;

    UILabel * titleLable = [[UILabel alloc] init];
    titleLable.text = [NSString stringWithFormat:@"总销售额:123123123"];
    titleLable.frame = CGRectMake(titleLableX, titleLableY, titleLableW, titleLableH);
    [scr addSubview:titleLable];
    
    CGFloat timeViewX = 2;
    CGFloat timeViewY = CGRectGetMaxY(titleLable.frame)+2;
    CGFloat timeViewW = self.view.frame.size.width-4;
    CGFloat timeViewH = 50;
    UIView * timeView = [[UIView alloc] init];
    //    timeView.backgroundColor = [UIColor redColor];
    timeView.frame = CGRectMake(timeViewX, timeViewY, timeViewW, timeViewH);
    [scr addSubview:timeView];
    //本周
    UIView * week = [[UIView alloc] init];
    week.frame = CGRectMake(0, 0, (timeViewW-2)*0.5, timeViewH);
    week.backgroundColor = [UIColor colorWithRed:195/255.0 green:43/255.0 blue:149/255.0 alpha:1.000];
    [timeView addSubview:week];
    
    UILabel * weekLable = [[UILabel alloc] init];
    weekLable.text = @"本周";
    weekLable.textColor = [UIColor whiteColor];
    weekLable.frame = CGRectMake(0, 0, (timeViewW-2)*0.5, timeViewH*0.5);
    weekLable.textAlignment = NSTextAlignmentCenter;
    [week addSubview:weekLable];
    //本周订单数量
    UILabel * weekLableNumber = [[UILabel alloc] init];
    weekLableNumber.text = @"7";
    weekLableNumber.textColor = [UIColor whiteColor];
    self.saleweekNumberLableValue = weekLableNumber;
    weekLableNumber.textAlignment = NSTextAlignmentCenter;
    weekLableNumber.frame = CGRectMake(0, timeViewH*0.5, (timeViewW-2)*0.5, timeViewH*0.5);
    weekLableNumber.contentMode = UIViewContentModeCenter;
    [week addSubview:weekLableNumber];
    
    //本月
    UIView * month = [[UIView alloc] init];
    month.backgroundColor = [UIColor colorWithRed:0/255.0 green:102/255.0 blue:255/255.0 alpha:1.000];
    month.frame = CGRectMake((timeViewW-2)*0.5+2, 0, (timeViewW-2)*0.5, timeViewH);
    [timeView addSubview:month];
    UILabel * monthLable = [[UILabel alloc] init];
    monthLable.textColor = [UIColor whiteColor];
    monthLable.text = @"本月";
    monthLable.frame = CGRectMake(0, 0, (timeViewW-2)*0.5, timeViewH*0.5);
    monthLable.textAlignment = NSTextAlignmentCenter;
    [month addSubview:monthLable];
    //本月订单的数量
    UILabel * monthLableNumber = [[UILabel alloc] init];
    monthLableNumber.text = @"3000";
    monthLableNumber.textColor = [UIColor whiteColor];
    self.salemonthNumberLableValue = monthLableNumber;
    monthLableNumber.textAlignment = NSTextAlignmentCenter;
    monthLableNumber.frame = CGRectMake(0, timeViewH*0.5, (timeViewW-2)*0.5, timeViewH*0.5);
    monthLableNumber.contentMode = UIViewContentModeCenter;
    [month addSubview:monthLableNumber];
    
    
    UILabel * title1Lable = [[UILabel alloc] init];
    title1Lable.text = @"数据分析（本周/本月）";
    CGFloat title1LableX = 5;
    CGFloat title1LableY = timeViewY + timeViewH;
    CGFloat title1LableW = timeViewW-2*timeViewX;
    CGFloat title1LableH = 40;
    title1Lable.frame = CGRectMake(title1LableX, title1LableY, title1LableW, title1LableH);
    [scr addSubview:title1Lable];
    
    
    CGFloat pnchartX = 2;
    CGFloat pnchartY = title1LableY+title1LableH;
    CGFloat pnchartW = self.view.frame.size.width-4;
    CGFloat pnchartH = self.view.frame.size.height*0.35;
    UIView * pnchartView = [[UIView alloc] init];
//    pnchartView.backgroundColor = [UIColor redColor];
    pnchartView.frame = CGRectMake(pnchartX, pnchartY, pnchartW, pnchartH);
    self.salelineChart = [self linePNChartWithFrame:pnchartView.frame];
    self.salelineChart.tag = 2;
    [pnchartView addSubview:self.salelineChart];
    
    [scr addSubview:pnchartView];
    
    UILabel * topGoodLable = [[UILabel alloc] init];
    topGoodLable.text = @"销售明细";
    CGFloat topGoodLableX = 5;
    CGFloat topGoodLableY = pnchartY+pnchartH+5;
    CGFloat topGoodLableW = timeViewW-2*timeViewX;
    CGFloat topGoodLableH = 40;
    topGoodLable.backgroundColor = [UIColor grayColor];
    topGoodLable.frame = CGRectMake(topGoodLableX, topGoodLableY, topGoodLableW, topGoodLableH);
    [scr addSubview:topGoodLable];
    
    
    
}

/**
 *  3、数据统计中第三个会员统计
 */
- (void)showVipPersonNumber{
    UIScrollView * scr = self.scrollerviews[2];
   
    CGFloat titleLableX = 2;
    CGFloat titleLableY = 0;
    CGFloat titleLableW = self.view.frame.size.width-2*titleLableX;
    CGFloat titleLableH = 40;
    UILabel * titleLable = [[UILabel alloc] init];
    titleLable.text = [NSString stringWithFormat:@"总会员数:123123123"];
    titleLable.frame = CGRectMake(titleLableX, titleLableY, titleLableW, titleLableH);
    [scr addSubview:titleLable];
    
    CGFloat timeViewX = 2;
    CGFloat timeViewY = CGRectGetMaxY(titleLable.frame)+2;
    CGFloat timeViewW = self.view.frame.size.width-4;
    CGFloat timeViewH = 80;
    UIView * timeView = [[UIView alloc] init];
    //    timeView.backgroundColor = [UIColor redColor];
    timeView.frame = CGRectMake(timeViewX, timeViewY, timeViewW, timeViewH);
    [scr addSubview:timeView];
    //本周
    UIView * week = [[UIView alloc] init];
    week.frame = CGRectMake(0, 0, (timeViewW-2)*0.5, timeViewH);
    week.backgroundColor = [UIColor colorWithRed:195/255.0 green:43/255.0 blue:149/255.0 alpha:1.000];
    [timeView addSubview:week];
    
    UILabel * weekLable = [[UILabel alloc] init];
    weekLable.textColor = [UIColor whiteColor];
    weekLable.text = @"本周";
    weekLable.frame = CGRectMake(0, 0, (timeViewW-2)*0.5, timeViewH/3);
    weekLable.textAlignment = NSTextAlignmentCenter;
    [week addSubview:weekLable];
    //本周订单数量
    CGFloat leftX = 0;
    CGFloat leftY = CGRectGetMaxY(weekLable.frame);
    CGFloat leftW = week.frame.size.width*0.5;
    CGFloat leftH = week.frame.size.height/3;
    UILabel * weekLableNumber = [[UILabel alloc] init];
    weekLableNumber.text = @"小伙伴";
    weekLableNumber.textColor = [UIColor whiteColor];
//    self.weekNumberLable = weekLableNumber;
    weekLableNumber.textAlignment = NSTextAlignmentCenter;
    weekLableNumber.frame = CGRectMake(leftX, leftY, leftW, leftH);
    weekLableNumber.contentMode = UIViewContentModeCenter;
    [week addSubview:weekLableNumber];
    
    CGFloat rightX = leftW;
    CGFloat rightY = CGRectGetMaxY(weekLable.frame);
    CGFloat rightW = week.frame.size.width*0.5;
    CGFloat rightH = week.frame.size.height/3;
    UILabel * weekLableNumber1 = [[UILabel alloc] init];
    weekLableNumber1.textColor = [UIColor whiteColor];
    weekLableNumber1.text = @"777";
    self.partnerweekNumberLableValue = weekLableNumber1;
    weekLableNumber1.textAlignment = NSTextAlignmentCenter;
    weekLableNumber1.frame = CGRectMake(rightX, rightY, rightW, rightH);
    weekLableNumber1.contentMode = UIViewContentModeCenter;
    [week addSubview:weekLableNumber1];
    
    
    CGFloat left1X = 0;
    CGFloat left1Y = CGRectGetMaxY(weekLableNumber1.frame);
    CGFloat left1W = week.frame.size.width*0.5;
    CGFloat left1H = week.frame.size.height/3;
    UILabel * weekLableNumber2 = [[UILabel alloc] init];
    weekLableNumber2.textColor = [UIColor whiteColor];
    weekLableNumber2.text = @"会员";
//    self.weekNumberLable = weekLableNumber2;
    weekLableNumber2.textAlignment = NSTextAlignmentCenter;
    weekLableNumber2.frame = CGRectMake(left1X, left1Y, left1W, left1H);
    weekLableNumber2.contentMode = UIViewContentModeCenter;
    [week addSubview:weekLableNumber2];
    
    CGFloat right1X = left1W;
    CGFloat right1Y = CGRectGetMaxY(weekLableNumber1.frame);
    CGFloat right1W = week.frame.size.width*0.5;
    CGFloat right1H = week.frame.size.height/3;
    UILabel * weekLableNumber3 = [[UILabel alloc] init];
    weekLableNumber3.text = @"777";
    weekLableNumber3.textColor = [UIColor whiteColor];
    self.vipweekNumberLableValue = weekLableNumber3;
    weekLableNumber3.textAlignment = NSTextAlignmentCenter;
    weekLableNumber3.frame = CGRectMake(right1X, right1Y, right1W, right1H);
    weekLableNumber3.contentMode = UIViewContentModeCenter;
    [week addSubview:weekLableNumber3];
    
    //本月
    UIView * month = [[UIView alloc] init];
    month.backgroundColor = [UIColor colorWithRed:0/255.0 green:102/255.0 blue:255/255.0 alpha:1.000];
    month.frame = CGRectMake((timeViewW-2)*0.5+2, 0, (timeViewW-2)*0.5, timeViewH);
    [timeView addSubview:month];
    [month bk_whenTapped:^{
        NSLog(@"xxxxx");
    }];
    
    UILabel * monthweekLable = [[UILabel alloc] init];
    monthweekLable.textColor = [UIColor whiteColor];
    monthweekLable.text = @"本月";
    monthweekLable.frame = CGRectMake(0, 0, (timeViewW-2)*0.5, timeViewH/3);
    monthweekLable.textAlignment = NSTextAlignmentCenter;
    [month addSubview:monthweekLable];
    //本周订单数量
    CGFloat monthleftX = 0;
    CGFloat monthleftY = CGRectGetMaxY(monthweekLable.frame);
    CGFloat monthleftW = month.frame.size.width*0.5;
    CGFloat monthleftH = month.frame.size.height/3;
    UILabel * monthweekLableNumber = [[UILabel alloc] init];
    monthweekLableNumber.textColor = [UIColor whiteColor];
    monthweekLableNumber.text = @"小伙伴";
//    self.weekNumberLable = monthweekLableNumber;
    monthweekLableNumber.textAlignment = NSTextAlignmentCenter;
    monthweekLableNumber.frame = CGRectMake(monthleftX, monthleftY, monthleftW, monthleftH);
    monthweekLableNumber.contentMode = UIViewContentModeCenter;
    [month addSubview:monthweekLableNumber];
    
    CGFloat monthrightX = monthleftW;
    CGFloat monthrightY = CGRectGetMaxY(weekLable.frame);
    CGFloat monthrightW = week.frame.size.width*0.5;
    CGFloat monthrightH = week.frame.size.height/3;
    UILabel * monthweekLableNumber1 = [[UILabel alloc] init];
    monthweekLableNumber1.textColor = [UIColor whiteColor];
    monthweekLableNumber1.text = @"777";
    self.partnermonthNumberLableValue = monthweekLableNumber1;
    monthweekLableNumber1.textAlignment = NSTextAlignmentCenter;
    monthweekLableNumber1.frame = CGRectMake(monthrightX, monthrightY, monthrightW, monthrightH);
    monthweekLableNumber1.contentMode = UIViewContentModeCenter;
    [month addSubview:monthweekLableNumber1];
    
    
    CGFloat monthleft1X = 0;
    CGFloat monthleft1Y = CGRectGetMaxY(monthweekLableNumber1.frame);
    CGFloat monthleft1W = week.frame.size.width*0.5;
    CGFloat monthleft1H = week.frame.size.height/3;
    UILabel * monthweekLableNumber2 = [[UILabel alloc] init];
    monthweekLableNumber2.textColor = [UIColor whiteColor];
    monthweekLableNumber2.text = @"会员";
//    self.weekNumberLable = monthweekLableNumber2;
    monthweekLableNumber2.textAlignment = NSTextAlignmentCenter;
    monthweekLableNumber2.frame = CGRectMake(monthleft1X, monthleft1Y, monthleft1W, monthleft1H);
    monthweekLableNumber2.contentMode = UIViewContentModeCenter;
    [month addSubview:monthweekLableNumber2];
    
    CGFloat monthright1X = left1W;
    CGFloat monthright1Y = CGRectGetMaxY(monthweekLableNumber1.frame);
    CGFloat monthright1W = week.frame.size.width*0.5;
    CGFloat monthright1H = week.frame.size.height/3;
    UILabel * monthweekLableNumber3 = [[UILabel alloc] init];
    monthweekLableNumber3.text = @"777";
    monthweekLableNumber3.textColor = [UIColor whiteColor];
    self.vipmonthNumberLableValue = monthweekLableNumber3;
    monthweekLableNumber3.textAlignment = NSTextAlignmentCenter;
    monthweekLableNumber3.frame = CGRectMake(monthright1X, monthright1Y, monthright1W, monthright1H);
    monthweekLableNumber3.contentMode = UIViewContentModeCenter;
    [month addSubview:monthweekLableNumber3];
    
    
    UILabel * title1Lable = [[UILabel alloc] init];
    title1Lable.text = @"数据分析（本周/本月）";
    CGFloat title1LableX = 5;
    CGFloat title1LableY = timeViewY + timeViewH;
    CGFloat title1LableW = timeViewW-2*timeViewX;
    CGFloat title1LableH = 40;
    title1Lable.frame = CGRectMake(title1LableX, title1LableY, title1LableW, title1LableH);
    [scr addSubview:title1Lable];
    
    
    CGFloat pnchartX = 2;
    CGFloat pnchartY = title1LableY+title1LableH;
    CGFloat pnchartW = self.view.frame.size.width-4;
    CGFloat pnchartH = self.view.frame.size.height*0.35;
    UIView * pnchartView = [[UIView alloc] init];
//    pnchartView.backgroundColor = [UIColor redColor];
    pnchartView.frame = CGRectMake(pnchartX, pnchartY, pnchartW, pnchartH);
    //创建绘图
    self.viplineChart = [self linePNChartWithFrame:pnchartView.frame];
    self.viplineChart.tag = 1;
    [pnchartView addSubview:self.viplineChart];
    [scr addSubview:pnchartView];
    
    CGFloat bottomView1X = 0;
    CGFloat bottomView1Y = pnchartY+pnchartH+10;
    CGFloat bottomView1W = timeViewW-2*bottomView1X;
    CGFloat bottomView1H = 40;
    UIView * bottomView1 = [[UIView alloc] init];
    bottomView1.frame = CGRectMake(bottomView1X, bottomView1Y, bottomView1W, bottomView1H);
    bottomView1.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.000];
    
    CGFloat arrowViewY = 0;
    CGFloat arrowViewH = bottomView1H;
    CGFloat arrowViewW = bottomView1H;
    CGFloat arrowViewX = CGRectGetMaxX(bottomView1.frame) - arrowViewW;
    UIImageView * arrowView = [[UIImageView alloc] init];
    arrowView.frame = CGRectMake(arrowViewX, arrowViewY, arrowViewW, arrowViewH);
    
    CGFloat firstLableY = 0;
    CGFloat firstLableH = bottomView1H;
    CGFloat firstLableW = bottomView1W-arrowViewW;
    CGFloat firstLableX = 0;
    UILabel * firstLable = [[UILabel alloc] init];
    firstLable.frame = CGRectMake(firstLableX, firstLableY, firstLableW, firstLableH);
    firstLable.text = @"  会员小伙伴返利积分统计";
    [bottomView1 addSubview:firstLable];
    [bottomView1 addSubview:arrowView];
    [scr addSubview:bottomView1];
    
    CGFloat bottomView2X = 0;
    CGFloat bottomView2Y = CGRectGetMaxY(bottomView1.frame)+10;
    CGFloat bottomView2W = timeViewW-2*bottomView1X;
    CGFloat bottomView2H = 40;
    UIView * bottomView2 = [[UIView alloc] init];
    bottomView2.frame = CGRectMake(bottomView2X, bottomView2Y, bottomView2W, bottomView2H);
    bottomView2.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.000];
    CGFloat arrowView2Y = 0;
    CGFloat arrowView2H = bottomView2H;
    CGFloat arrowView2W = bottomView2H;
    CGFloat arrowView2X = CGRectGetMaxX(bottomView2.frame) - arrowView2W;
    UIImageView * arrowView2 = [[UIImageView alloc] init];
    arrowView2.frame = CGRectMake(arrowView2X, arrowView2Y, arrowView2W, arrowView2H);
    
    CGFloat firstLable2Y = 0;
    CGFloat firstLable2H = bottomView2H;
    CGFloat firstLable2W = bottomView2W-arrowView2W;
    CGFloat firstLable2X = 0;
    UILabel * firstLable2 = [[UILabel alloc] init];
    firstLable2.frame = CGRectMake(firstLable2X, firstLable2Y, firstLable2W, firstLable2H);
    firstLable2.text = @"  会员小伙伴消费统计";
    [bottomView2 addSubview:firstLable2];
    [bottomView2 addSubview:arrowView2];
    [scr addSubview:bottomView2];
    
    int ScrW = (int)[UIScreen mainScreen].bounds.size.height;
    NSLog(@"%d",ScrW);
    if (ScrW==480) {
       scr.contentSize = CGSizeMake(0, self.view.frame.size.height+80);
    }

    
}

/**
 *  绘图新建PNChart
 *
 *  @param frame <#frame description#>
 */
- (PNLineChart *)linePNChartWithFrame:(CGRect)frame{
    
    
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
    data01.color = PNFreshGreen;
    data01.alpha = 0.3f;
    data01.itemCount = data01Array.count;
    data01.inflexionPointStyle = PNLineChartPointStyleNone;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    lineChart.chartData = @[data01];
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
- (void)changeValue{
    // Line Chart #1
    NSArray * data01Array = @[@(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300)];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNDarkBlue;
    data01.itemCount = data01Array.count;
    data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    [self.orderlineChart setXLabels:@[@"1",@"",@"",@"",@"",@"",@"7"]];
    [self.orderlineChart updateChartData:@[data01]];
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

#pragma tableview 代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentiler = @"topCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentiler];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentiler];
    }
    cell.textLabel.text = @"23131";
    return cell;
}

#pragma scorllView 代理方法

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
    }
}
@end
