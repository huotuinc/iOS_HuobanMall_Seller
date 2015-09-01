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

@interface HTHomeViewController () <UIScrollViewDelegate>



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



@property (nonatomic, strong) NSMutableArray *scorllArray;

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
    
    
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.SBgView.bounds.size.width, self.SBgView.bounds.size.height)];
    
//    self.scrollView.frame = CGRectMake(0, 0, self.SBgView.frame.size.width, self.SBgView.frame.size.height);
    
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
                sc.backgroundColor = [UIColor grayColor];
                break;
            case 1:
                sc.backgroundColor = [UIColor blueColor];
                break;
            default:
                sc.backgroundColor = [UIColor yellowColor];
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
