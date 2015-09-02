//
//  HTHomeViewController.m
//  HuoBanMall
//
//  Created by lhb on 15/8/28.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "HTHomeViewController.h"
#import "SettingViewController.h"
#import "HTDataStatisViewController.h"
#import "ManagementController.h"
#import <PNChart.h>

@interface HTHomeViewController () <UIScrollViewDelegate,PNChartDelegate>



/**
 *  滑动视图的背景
 */
@property (weak, nonatomic) IBOutlet UIView *SBgView;

/**
 *  滑动视图
 */
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
/**产品管理*/
@property (weak, nonatomic) IBOutlet UIImageView *productManager;
/**订单管理*/
@property (weak, nonatomic) IBOutlet UIImageView *orderManager;
/**周月统计*/
@property (weak, nonatomic) IBOutlet UIImageView *dataStatics;
/**设置管理*/
@property (weak, nonatomic) IBOutlet UIImageView *settingManager;

/**更多数据*/
@property (weak, nonatomic) IBOutlet UIImageView *moreData;
/**店铺首页*/
@property (weak, nonatomic) IBOutlet UIImageView *mallHome;


//滑动视图中的元素数组
@property (nonatomic, strong) NSMutableArray *scorllArray;
/*****************************************************/
/**
 *  订单
 */
@property (nonatomic, strong) PNLineChart *ordorChart;

/**
 *  会员
 */
@property (nonatomic, strong) PNLineChart *memberChart;

/**
 *  分销商
 */
@property (nonatomic, strong) PNLineChart *distributorChart;

@end

@implementation HTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    HTHomeViewController * wself = self;
    
    [self.productManager bk_whenTapped:^{
        ManagementController *management = [[ManagementController alloc] init];
        [wself.navigationController pushViewController:management animated:YES];
    }];
    
    [self.settingManager bk_whenTapped:^{
       
        UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SettingViewController * setvc = [story instantiateViewControllerWithIdentifier:@"SettingViewController"];
        setvc.title = @"设置中心";
        [wself.navigationController pushViewController:setvc animated:YES];
        
    }];
    
    
    [self.dataStatics bk_whenTapped:^{
        HTDataStatisViewController * dataStatics = [[HTDataStatisViewController alloc] init];
        dataStatics.titlesArray = @[@"订单",@"销售额",@"会员"];
        
        [wself.navigationController pushViewController:dataStatics animated:YES];
        
    }];
    
    [self _initScrollView];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self _initNav];
    
}
/**
 *  设置导航栏
 */
- (void)_initNav
{
    
    HTHomeViewController * wself = self;
    
    [self _initNavBackgroundColor];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"dp-top"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        //转跳店铺首页
        UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
    }];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"sz-top"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SettingViewController * setvc = [story instantiateViewControllerWithIdentifier:@"SettingViewController"];
        [wself.navigationController pushViewController:setvc animated:YES];
    }];
    
    
    
}




- (void)_initScrollView
{
    
    
    
    [self.scrollView layoutIfNeeded];
    
    NSLog(@"%f",self.scrollView.bounds.size.width);
    NSLog(@"%f",self.scrollView.bounds.size.height);
    
    self.scrollView.delegate = self;
    self.scrollView.userInteractionEnabled = YES;
    
//    [self.SBgView addSubview:_scrollView];
    //2、添加图片
    CGFloat scrollW = self.scrollView.bounds.size.width;
    CGFloat scrollH = self.scrollView.bounds.size.height;
    for (int index = 0; index < 3; index++) {
        CGFloat scX = scrollW * index;
        CGFloat scY = 0;
        UIView * sc = [[UIView alloc] init];
        sc.tag = index;
        sc.frame = CGRectMake(scX, scY, scrollW, scrollH);
        switch (index) {
            case 0:
                self.ordorChart = [self PNChartWithView:sc AndXArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"] AndYArray:@[@"75",@"150",@"225",@"300",] AndDataArray:@[@0,@0, @0, @0, @0.0, @0, @0, @176.2]];
                sc.backgroundColor = [UIColor colorWithWhite:0.973 alpha:1.000];
                [sc addSubview:self.ordorChart];
                break;
            case 1:
                self.memberChart = [self PNChartWithView:sc AndXArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"] AndYArray:@[@"50",@"100",@"150",@"200",@"250",@"300",] AndDataArray:@[@0,@0, @0, @0, @0.0, @0, @0, @176.2]];
                sc.backgroundColor = [UIColor colorWithWhite:0.973 alpha:1.000];
                [sc addSubview:self.memberChart];
                break;
            default:
                self.distributorChart = [self PNChartWithView:sc AndXArray:@[@"6-10",@"2",@"3",@"4",@"5",@"6",@"7"] AndYArray:@[@"50",@"100",@"150",@"200",] AndDataArray:@[@1,@55, @22, @0, @33, @0, @0, @176.2]];
                sc.backgroundColor = [UIColor colorWithWhite:0.973 alpha:1.000];
                [sc addSubview:self.distributorChart];
                break;
        }
        
        [self.scorllArray addObject:sc];
        [self.scrollView addSubview:sc];
    }
    
    
    //设置滚动内容范围尺寸
    self.scrollView.contentSize = CGSizeMake(ScreenWidth * 3, 0);

    
    //隐藏滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces =NO;
    
}

- (PNLineChart *)PNChartWithView:(UIView *)view AndXArray:(NSArray *) xArray AndYArray:(NSArray *) yArray AndDataArray: (NSArray *) dataArray;
{
    PNLineChart *lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 10, view.bounds.size.width, view.bounds.size.height - 20)];
    lineChart.yLabelFormat = @"%1.1f";
    lineChart.backgroundColor = [UIColor clearColor];
    [lineChart setXLabels:xArray];
    lineChart.showCoordinateAxis = YES;
    
//    lineChart.xLabelWidth =
    
    lineChart.yFixedValueMax = 300;
    lineChart.yFixedValueMin = 0.0;
    lineChart.yValueMin = 0;
    [lineChart setYLabels:yArray];
    
    PNLineChartData *data01 = [PNLineChartData new];
    data01.dataTitle = @"Alpha";
    data01.color = [UIColor colorWithRed:1.000 green:0.235 blue:0.000 alpha:1.000];
    data01.alpha = 1;
    data01.itemCount = dataArray.count;
    data01.inflexionPointStyle = PNLineChartPointStyleCircle;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [dataArray[index] floatValue];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
