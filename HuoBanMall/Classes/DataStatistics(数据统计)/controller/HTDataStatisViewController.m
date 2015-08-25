//
//  HTDataStatisViewController.m
//  HuoBanMall
//
//  Created by lhb on 15/8/24.
//  Copyright (c) 2015年 HT. All rights reserved.
//  数据统计

#import "HTDataStatisViewController.h"

@interface HTDataStatisViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong) UIPageControl * pageControl;

@property(nonatomic,strong) NSMutableArray * scrollerviews;

@property(nonatomic,strong) NSArray *titlesArray;

@property(nonatomic,strong) UIScrollView * BackScrollerview;


/**一周7天统计数量*/
@property(nonatomic,strong) UILabel * weekNumberLable;
/**本月统计数量*/
@property(nonatomic,strong) UILabel * monthNumberLable;

@end

@implementation HTDataStatisViewController


- (NSArray *)titlesArray{
    if (_titlesArray == nil) {
        _titlesArray = @[@"订单统计",@"销售额统计",@"会员量统计"];
    }
    return _titlesArray;
}

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
    [self setupScrollView];
//    [self setupPageControll];
    
    [self showOrderContrpller];
}


/**
 *  1、数据统计中第一个订单统计页面
 */
- (void)showOrderContrpller{
    UIScrollView * scr = self.scrollerviews[0];
    //添加
    UIPageControl *pageControll = [[UIPageControl alloc] init];
    pageControll.backgroundColor = [UIColor blackColor];
    pageControll.numberOfPages = 3;
    pageControll.frame = CGRectMake(self.view.frame.size.width*0.5-40, 0, 80, 40);
    pageControll.userInteractionEnabled = NO;
    pageControll.currentPage = 0;
    [scr addSubview:pageControll];
    
    UILabel * titleLable = [[UILabel alloc] init];
    titleLable.text = self.titlesArray[scr.tag];
    titleLable.frame = CGRectMake(5, 40, self.view.frame.size.width, 40);
    [scr addSubview:titleLable];
    
    CGFloat timeViewX = 2;
    CGFloat timeViewY = 80;
    CGFloat timeViewW = self.view.frame.size.width-4;
    CGFloat timeViewH = 50;
    UIView * timeView = [[UIView alloc] init];
//    timeView.backgroundColor = [UIColor redColor];
    timeView.frame = CGRectMake(timeViewX, timeViewY, timeViewW, timeViewH);
    [scr addSubview:timeView];
    //本周
    UIView * week = [[UIView alloc] init];
    week.frame = CGRectMake(0, 0, (timeViewW-2)*0.5, timeViewH);
    //week.backgroundColor = [UIColor blackColor];
    [timeView addSubview:week];
    
    UILabel * weekLable = [[UILabel alloc] init];
    weekLable.text = @"本周";
    weekLable.frame = CGRectMake(0, 0, (timeViewW-2)*0.5, timeViewH*0.5);
    weekLable.textAlignment = NSTextAlignmentCenter;
    [week addSubview:weekLable];
    //本周订单数量
    UILabel * weekLableNumber = [[UILabel alloc] init];
    weekLableNumber.text = @"7";
    self.weekNumberLable = weekLableNumber;
    weekLableNumber.textAlignment = NSTextAlignmentCenter;
    weekLableNumber.frame = CGRectMake(0, timeViewH*0.5, (timeViewW-2)*0.5, timeViewH*0.5);
    weekLableNumber.contentMode = UIViewContentModeCenter;
    [week addSubview:weekLableNumber];
    
    //本月
    UIView * month = [[UIView alloc] init];
    month.frame = CGRectMake((timeViewW-2)*0.5+2, 0, (timeViewW-2)*0.5, timeViewH);
    [timeView addSubview:month];
    UILabel * monthLable = [[UILabel alloc] init];
    monthLable.text = @"本月";
    monthLable.frame = CGRectMake(0, 0, (timeViewW-2)*0.5, timeViewH*0.5);
    monthLable.textAlignment = NSTextAlignmentCenter;
    [month addSubview:monthLable];
    //本月订单的数量
    UILabel * monthLableNumber = [[UILabel alloc] init];
    monthLableNumber.text = @"3000";
    self.monthNumberLable = monthLableNumber;
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
    CGFloat pnchartH = self.view.frame.size.height*0.3;
    UIView * pnchartView = [[UIView alloc] init];
    pnchartView.backgroundColor = [UIColor redColor];
    pnchartView.frame = CGRectMake(pnchartX, pnchartY, pnchartW, pnchartH);
    [scr addSubview:pnchartView];
    
    UILabel * topGoodLable = [[UILabel alloc] init];
    topGoodLable.text = @"商品购买量排行 (Top10)";
    CGFloat topGoodLableX = 5;
    CGFloat topGoodLableY = pnchartY+pnchartH+2;
    CGFloat topGoodLableW = timeViewW-2*timeViewX;
    CGFloat topGoodLableH = 40;
    topGoodLable.backgroundColor = [UIColor grayColor];
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
    
    
    scr.contentSize = CGSizeMake(0, topGoodTableViewY+topGoodTableViewH+88);
    scr.contentInset = UIEdgeInsetsMake(0, 0, 0, 20);
}

/**
 *  2、数据统计中第二个销售额统计
 */
- (void)showSellCountStatistics{
    
    UIScrollView * scr = self.scrollerviews[1];
    scr.backgroundColor = [UIColor redColor];
    //添加
    UIPageControl *pageControll = [[UIPageControl alloc] init];
    pageControll.backgroundColor = [UIColor blackColor];
    pageControll.numberOfPages = 3;
    pageControll.frame = CGRectMake(self.view.frame.size.width*0.5-40, 0, 80, 40);
    pageControll.userInteractionEnabled = NO;
    pageControll.currentPage = 0;
    [scr addSubview:pageControll];
    
    UILabel * titleLable = [[UILabel alloc] init];
    titleLable.text = self.titlesArray[scr.tag];
    titleLable.frame = CGRectMake(5, 40, self.view.frame.size.width, 40);
    [scr addSubview:titleLable];
    
    CGFloat timeViewX = 2;
    CGFloat timeViewY = 80;
    CGFloat timeViewW = self.view.frame.size.width-4;
    CGFloat timeViewH = 50;
    UIView * timeView = [[UIView alloc] init];
    //    timeView.backgroundColor = [UIColor redColor];
    timeView.frame = CGRectMake(timeViewX, timeViewY, timeViewW, timeViewH);
    [scr addSubview:timeView];
    //本周
    UIView * week = [[UIView alloc] init];
    week.frame = CGRectMake(0, 0, (timeViewW-2)*0.5, timeViewH);
    //week.backgroundColor = [UIColor blackColor];
    [timeView addSubview:week];
    
    UILabel * weekLable = [[UILabel alloc] init];
    weekLable.text = @"本周";
    weekLable.frame = CGRectMake(0, 0, (timeViewW-2)*0.5, timeViewH*0.5);
    weekLable.textAlignment = NSTextAlignmentCenter;
    [week addSubview:weekLable];
    //本周订单数量
    UILabel * weekLableNumber = [[UILabel alloc] init];
    weekLableNumber.text = @"7";
    self.weekNumberLable = weekLableNumber;
    weekLableNumber.textAlignment = NSTextAlignmentCenter;
    weekLableNumber.frame = CGRectMake(0, timeViewH*0.5, (timeViewW-2)*0.5, timeViewH*0.5);
    weekLableNumber.contentMode = UIViewContentModeCenter;
    [week addSubview:weekLableNumber];
    
    //本月
    UIView * month = [[UIView alloc] init];
    month.frame = CGRectMake((timeViewW-2)*0.5+2, 0, (timeViewW-2)*0.5, timeViewH);
    [timeView addSubview:month];
    UILabel * monthLable = [[UILabel alloc] init];
    monthLable.text = @"本月";
    monthLable.frame = CGRectMake(0, 0, (timeViewW-2)*0.5, timeViewH*0.5);
    monthLable.textAlignment = NSTextAlignmentCenter;
    [month addSubview:monthLable];
    //本月订单的数量
    UILabel * monthLableNumber = [[UILabel alloc] init];
    monthLableNumber.text = @"3000";
    self.monthNumberLable = monthLableNumber;
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
    CGFloat pnchartH = self.view.frame.size.height*0.3;
    UIView * pnchartView = [[UIView alloc] init];
    pnchartView.backgroundColor = [UIColor redColor];
    pnchartView.frame = CGRectMake(pnchartX, pnchartY, pnchartW, pnchartH);
    [scr addSubview:pnchartView];
    
    UILabel * topGoodLable = [[UILabel alloc] init];
    topGoodLable.text = @"商品购买量排行 (Top10)";
    CGFloat topGoodLableX = 5;
    CGFloat topGoodLableY = pnchartY+pnchartH+2;
    CGFloat topGoodLableW = timeViewW-2*timeViewX;
    CGFloat topGoodLableH = 40;
    topGoodLable.backgroundColor = [UIColor grayColor];
    topGoodLable.frame = CGRectMake(topGoodLableX, topGoodLableY, topGoodLableW, topGoodLableH);
    [scr addSubview:topGoodLable];
    
    
    
}

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
    self.title = self.titlesArray[padgeInt];
    
}
@end
