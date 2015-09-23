//
//  HTHomeViewController.m
//  HuoBanMall
//
//  Created by lhb on 15/8/28.
//  Copyright (c) 2015年 HT. All rights reserved.
//

//@interface NSNumber (Debug)
//
//- (void)rangeOfCharacterFromSet:(id) a;
//
//- (void)length;
//
//@end
//
//@implementation NSNumber (Debug)
//
//- (void)rangeOfCharacterFromSet:(id)a {
//    NSLog(@"112312312");
//}
//
//- (void)length
//{
//    
//}
//
//@end

#import "HTHomeViewController.h"
#import "SettingViewController.h"
#import "HTDataStatisViewController.h"
#import "MoreDataViewController.h"
#import "ManagementController.h"
#import "NewTodayModel.h"
#import "HTUser.h"
#import <UIImageView+WebCache.h>
#import "WebController.h"
#import <PNChart.h>
#import "OrderManagerDetailsController.h"
#import "HTStatisticsController.h"
#import "OrdorController.h"
#import "HTCheckLogisticsController.h"

@interface HTHomeViewController () <UIScrollViewDelegate,PNChartDelegate>



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
 *  今日销售额
 */
@property (weak, nonatomic) IBOutlet UILabel *todayLabel;
/**
 *  总销售额
 */
@property (weak, nonatomic) IBOutlet UILabel *allLabel;

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
/*********************************************************/
/**
 *  订单的数量
 */
@property (weak, nonatomic) IBOutlet UILabel *ordorLabel;
/**
 *  会员数量
 */
@property (weak, nonatomic) IBOutlet UILabel *memberLabel;
/**
 *  分销商数量
 */
@property (weak, nonatomic) IBOutlet UILabel *distributorLabel;

/*********************************************************/

/**
 *  滑动模块
 */
@property (strong, nonatomic) UIView *scrollImage;
/*********************************************************/

/**
 *  订单视图
 */
@property (weak, nonatomic) IBOutlet UIView *ordorBgView;

/**
 *  会员视图
 */
@property (weak, nonatomic) IBOutlet UIView *menBgView;

/**
 *  分销商视图
 */
@property (weak, nonatomic) IBOutlet UIView *distributorBgView;

@property (weak, nonatomic) IBOutlet UIView *bgView;


/**
 *  数据存储首页数据
 */
@property (nonatomic, strong) NewTodayModel *homeModel;



@end

@implementation HTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    HTHomeViewController * wself = self;
    
    [self.productManager bk_whenTapped:^{
        UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ManagementController * management = [story instantiateViewControllerWithIdentifier:@"ManagementController"];
        [wself.navigationController pushViewController:management animated:YES];
    }];
    
    [self.settingManager bk_whenTapped:^{
       
        UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SettingViewController * setvc = [story instantiateViewControllerWithIdentifier:@"SettingViewController"];
        setvc.title = @"设置中心";
        [wself.navigationController pushViewController:setvc animated:YES];
        
    }];
    
    
    [self.dataStatics bk_whenTapped:^{
        UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MoreDataViewController *more = [story instantiateViewControllerWithIdentifier:@"MoreDataViewController"];
        more.title = @"更多统计";
        [wself.navigationController pushViewController:more animated:YES];
        
    }];
    
    
    [self.orderManager bk_whenTapped:^{
        
        UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        OrdorController *ordor = [story instantiateViewControllerWithIdentifier:@"OrdorController"];
        ordor.title = @"订单管理";
        [wself.navigationController pushViewController:ordor animated:YES];
    }];

    
    
    
    [self showScrollView];
    
    [self _initNav];
    
    [self getNewToday];

    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}
/**
 *  设置导航栏
 */
- (void)_initNav
{
    
    HTHomeViewController * wself = self;
    
    [self _initNavBackgroundColor];
    
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:LocalUserDate];
    HTUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"dp-top"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        //转跳店铺首页
        UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WebController *web = [story instantiateViewControllerWithIdentifier:@"WebController"];
        web.type = 4;
        web.title = @"首页";
        [self.navigationController pushViewController:web animated:YES];
    }];
    
    UIImageView *image = [[UIImageView alloc] init];
    [image sd_setImageWithURL:[NSURL URLWithString:user.logo] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:nil action:nil];
    }];
    
    self.navigationItem.title = user.title;
}

#pragma mark

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
    array = @[[NSString stringWithFormat:@"%ld", i * 25],[NSString stringWithFormat:@"%ld", i * 50],[NSString stringWithFormat:@"%ld", i * 75],[NSString stringWithFormat:@"%ld", i * 100]];
    
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


#pragma 初始化滑动视图

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
            {
                NSInteger max = [[self getMaxFromArray:self.homeModel.orderAmount] integerValue];
                self.ordorChart.yValueMax = max;
                self.ordorChart = [self PNChartWithView:sc AndXArray:[self getNSStringArrayWithArray:self.homeModel.orderHour] AndYArray:[self getArrayWithY:max] AndDataArray:self.homeModel.orderAmount];
                self.ordorChart.showLabel = YES;
                sc.backgroundColor = [UIColor colorWithWhite:0.973 alpha:1.000];
                [sc addSubview:self.ordorChart];
                break;
            }
            case 1:
            {
                NSInteger max = [[self getMaxFromArray:self.homeModel.memberAmount] integerValue];
                self.memberChart.yValueMax = max;
                self.memberChart = [self PNChartWithView:sc AndXArray:[self getNSStringArrayWithArray:self.homeModel.memberHour] AndYArray:[self getArrayWithY:max] AndDataArray:self.homeModel.memberAmount];
                sc.backgroundColor = [UIColor colorWithWhite:0.973 alpha:1.000];
                [sc addSubview:self.memberChart];
                break;
            }
            default:
            {
                NSInteger max = [[self getMaxFromArray:self.homeModel.partnerAmount] integerValue];
                self.distributorChart.yValueMax = max;
                self.distributorChart = [self PNChartWithView:sc
                                                    AndXArray:[self getNSStringArrayWithArray:self.homeModel.partnerHour]
                                                    AndYArray:[self getArrayWithY:max]
                                                 AndDataArray:self.homeModel.partnerAmount];
                sc.backgroundColor = [UIColor colorWithWhite:0.973 alpha:1.000];
                [sc addSubview:self.distributorChart];
                break;
            }
        }
        
        [self.scorllArray addObject:sc];
        [self.scrollView addSubview:sc];
    }
    
    

    
}

#pragma 网络访问

- (void)getNewToday {
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [UserLoginTool loginRequestGet:@"newToday" parame:nil success:^(id json) {
        
        [SVProgressHUD dismiss];
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1){
            
            self.homeModel = [NewTodayModel objectWithKeyValues:(json[@"resultData"])];
            self.homeModel.todayMemberAmount = json[@"resultData"][@"todayMemberAmount"];
            self.homeModel.todayOrderAmount = json[@"resultData"][@"todayOrderAmount"];
            self.homeModel.todayPartnerAmount = json[@"resultData"][@"todayPartnerAmount"];
            self.homeModel.todaySales = json[@"resultData"][@"todaySales"];
            self.homeModel.totalSales = json[@"resultData"][@"totalSales"];
            
            [self _initAllLabels];
            
            [self _initScrollView];
        }
        
        if ([json[@"resultCode"] intValue] == 56001) {
            
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@",json[@"resultDescription"]]];
            
            LoginViewController *login = [[LoginViewController alloc] init];
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:login];
            [self presentViewController:nav animated:YES completion:^{
                [SVProgressHUD dismiss];
            }];
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"网络异常，请检查网络"];
        
    }];
}

- (void)_initAllLabels {
    if ([self.homeModel.totalSales intValue] > 10000) {
        self.allLabel.text = [NSString stringWithFormat:@"总销售额(万元):%.2f", [self.homeModel.totalSales floatValue] / 10000];
    }else {
        self.allLabel.text = [NSString stringWithFormat:@"总销售额(元):%d", [self.homeModel.totalSales intValue]];
    }
    
    self.todayLabel.text = [NSString stringWithFormat:@"¥:%d", [self.homeModel.todaySales intValue]];
    
    self.ordorLabel.text = [NSString stringWithFormat:@"%d", [self.homeModel.todayOrderAmount intValue]];
    
    self.memberLabel.text = [NSString stringWithFormat:@"%d", [self.homeModel.todayMemberAmount intValue]];
    
    self.distributorLabel.text = [NSString stringWithFormat:@"%d", [self.homeModel.todayPartnerAmount intValue]];
}


#pragma 设置哈懂视图
- (void)showScrollView {
    //设置滚动内容范围尺寸
    
    [self.bgView layoutIfNeeded];
    [self.ordorBgView layoutIfNeeded];
    [self.menBgView layoutIfNeeded];
    [self.distributorBgView layoutIfNeeded];
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth * 3, 0);
    
    
    //隐藏滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces =NO;
    
    
#pragma 设置滑动块
    
    CGFloat SIY = (ScreenHeight - 64) * 0.1 - 2;
    CGFloat ORX = self.ordorBgView.frame.size.width / 2 - ScreenWidth * 0.33 * 0.35 + self.ordorBgView.frame.origin.x;
    CGFloat MEMX = self.menBgView.frame.size.width / 2 - ScreenWidth * 0.33 * 0.35 + self.menBgView.frame.origin.x;
    CGFloat DISX = self.distributorBgView.frame.size.width / 2 - ScreenWidth * 0.33 * 0.35 + self.distributorBgView.frame.origin.x;
    
    
    NSLog(@"%f",self.ordorBgView.frame.origin.x);
    NSLog(@"%f", self.ordorBgView.frame.size.width);
    
    NSLog(@"%f", ORX);
    NSLog(@"%f", SIY);
    NSLog(@"%f", ScreenWidth * 0.33 * 0.7);
    
    self.scrollImage = [[UIView alloc] initWithFrame:CGRectMake( ORX, SIY, ScreenWidth * 0.33 * 0.7, 2)];
    self.scrollImage.backgroundColor = [UIColor colorWithRed:1.000 green:0.235 blue:0.000 alpha:1.000];
    
    
    [self.bgView addSubview:self.scrollImage];
    
    
    
    [self.ordorBgView bk_whenTapped:^{
        if (self.scrollImage.frame.origin.x != ORX) {
            [UIView animateWithDuration:0.35 animations:^{
                self.scrollImage.frame = CGRectMake(ORX, SIY, ScreenWidth * 0.33 * 0.7, 2);
                self.scrollView.contentOffset = CGPointMake(0, 0);
            }];
           
        }
    }];
    
    [self.menBgView bk_whenTapped:^{
        if (self.scrollImage.frame.origin.x != MEMX) {
            [UIView animateWithDuration:0.35 animations:^{
                self.scrollImage.frame = CGRectMake(MEMX, SIY, ScreenWidth * 0.33 * 0.7, 2);
                self.scrollView.contentOffset = CGPointMake(ScreenWidth, 0);
            }];
            
            
        }
        
    }];
    
    [self.distributorBgView bk_whenTapped:^{
        if (self.scrollImage.frame.origin.x != DISX) {
            [UIView animateWithDuration:0.35 animations:^{
                self.scrollImage.frame = CGRectMake(DISX, SIY, ScreenWidth * 0.33 * 0.7, 2);
                self.scrollView.contentOffset = CGPointMake(2 * ScreenWidth, 0);
            }];
            
           
        }
    }];
}

#pragma 滑动视图代理

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat SIY = self.ordorBgView.frame.size.height - 2;
    CGFloat ORX = self.ordorBgView.frame.size.width / 2 - ScreenWidth * 0.33 * 0.35 + self.ordorBgView.frame.origin.x;
    CGFloat MEMX = self.menBgView.frame.size.width / 2 - ScreenWidth * 0.33 * 0.35 + self.menBgView.frame.origin.x;
    CGFloat DISX = self.distributorBgView.frame.size.width / 2 - ScreenWidth * 0.33 * 0.35 + self.distributorBgView.frame.origin.x;
    
    CGFloat x =  scrollView.contentOffset.x;
    int padgeDouble = x / scrollView.frame.size.width;
    
    if (padgeDouble == 0) {
        [UIView animateWithDuration:0.15 animations:^{
            self.scrollImage.frame = CGRectMake(ORX, SIY, ScreenWidth * 0.33 * 0.7, 2);
        }];
    }else if (padgeDouble == 1) {
        [UIView animateWithDuration:0.15 animations:^{
            self.scrollImage.frame = CGRectMake(MEMX, SIY, ScreenWidth * 0.33 * 0.7, 2);
        }];
    }else {
        [UIView animateWithDuration:0.15 animations:^{
            self.scrollImage.frame = CGRectMake(DISX, SIY, ScreenWidth * 0.33 * 0.7, 2);
        }];
    }
    
}


#pragma PNChart

- (PNLineChart *)PNChartWithView:(UIView *)view AndXArray:(NSArray *) xArray AndYArray:(NSArray *) yArray AndDataArray: (NSArray *) dataArray;
{
    PNLineChart *lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 10, view.bounds.size.width, view.bounds.size.height - 20)];
    lineChart.yLabelFormat = @"%1.1f";
    lineChart.backgroundColor = [UIColor clearColor];
    [lineChart setXLabels:xArray];
    lineChart.showCoordinateAxis = YES;
    

    
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
