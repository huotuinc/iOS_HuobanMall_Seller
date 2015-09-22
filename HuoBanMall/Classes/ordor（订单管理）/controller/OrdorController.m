//
//  OrdorController.m
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/15.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "OrdorController.h"
#import "HeadView.h"
#import "OrdorCell.h"
#import "NewFootView.h"
#import "OrderManagerDetailsController.h"
#import "HTCheckLogisticsController.h"
@interface OrdorController ()<UITableViewDelegate,UITableViewDataSource,NewFootViewDelegate>

/**
 *  滑块视图
 */
@property (nonatomic, strong) UIView *screenView;

//订单数组
@property (nonatomic, strong) NSArray *ordors;

//全部的x值
@property (nonatomic, assign) CGFloat ALLX;

@end

@implementation OrdorController

static NSString *ordorIdentifier = @"ordorCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrdorCell" bundle:nil] forCellReuseIdentifier:ordorIdentifier];
//    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self _initScreenView];
    
    self.tableView.tableFooterView.userInteractionEnabled = YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"ss"] style:UIBarButtonItemStylePlain handler:^(id sender) {
 
    }];
    
    [self getNewOrdorList];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getNewOrdorList {
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    dic[@"status"] = @0;
    
    [UserLoginTool loginRequestGet:@"" parame:nil success:^(id json) {
        
        NSLog(@"%@", json);
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@", error);
        
    }];
    
}

- (void)_initScreenView {
    
    [self.bgView layoutIfNeeded];
    [self.allView layoutIfNeeded];
    [self.obligationView layoutIfNeeded];
    [self.waitView layoutIfNeeded];
    [self.finishView layoutIfNeeded];
    
    CGFloat SVW = ScreenWidth * 0.1;
    CGFloat SIY = (ScreenHeight - 64) * 0.08 - 2;
    
    self.ALLX = (self.allView.frame.size.width - SVW) / 2 + self.allView.frame.origin.x;
    CGFloat OBX = (self.obligationView.frame.size.width - SVW) / 2 + self.obligationView.frame.origin.x;
    CGFloat WTX = (self.waitView.frame.size.width - SVW) / 2 + self.waitView.frame.origin.x;
    CGFloat FIX = (self.finishView.frame.size.width - SVW) / 2 + self.finishView.frame.origin.x;
    
    
    self.screenView = [[UIView alloc] initWithFrame:CGRectMake(self.ALLX, SIY, SVW, 2)];
    self.screenView.backgroundColor = NavBackgroundColor;
    
    [self.bgView addSubview:self.screenView];
    
    
    [self.allView bk_whenTapped:^{
        if (self.screenView.frame.origin.x != self.ALLX) {
            
            [UIView animateWithDuration:0.35 animations:^{
                [self setLabelsColorBlack];
                self.allLabel.textColor = NavBackgroundColor;
                self.screenView.frame = CGRectMake(self.ALLX, SIY, SVW, 2);
            }];
        }
    }];
    
    [self.obligationView bk_whenTapped:^{
        if (self.screenView.frame.origin.x != OBX) {
            
            [UIView animateWithDuration:0.35 animations:^{
                [self setLabelsColorBlack];
                self.obligationLabel.textColor = NavBackgroundColor;
                self.screenView.frame = CGRectMake(OBX, SIY, SVW, 2);
            }];
        }
    }];
    
    [self.waitView bk_whenTapped:^{
        if (self.screenView.frame.origin.x != WTX) {
            
            [UIView animateWithDuration:0.35 animations:^{
                [self setLabelsColorBlack];
                self.waitLabel.textColor = NavBackgroundColor;
                self.screenView.frame = CGRectMake(WTX, SIY, SVW, 2);
            }];
        }
    }];
    
    [self.finishView bk_whenTapped:^{
        if (self.screenView.frame.origin.x != FIX) {
            
            [UIView animateWithDuration:0.35 animations:^{
                [self setLabelsColorBlack];
                self.finishLabel.textColor = NavBackgroundColor;
                self.screenView.frame = CGRectMake(FIX, SIY, SVW, 2);
            }];
        }
    }];
    
    
    
}


- (void)setLabelsColorBlack {
    self.allLabel.textColor = [UIColor blackColor];
    self.obligationLabel.textColor = [UIColor blackColor];
    self.waitLabel.textColor = [UIColor blackColor];
    self.finishLabel.textColor = [UIColor blackColor];
}



#pragma mark －tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
        default:
            return 3;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 83;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeadView *head = [[[NSBundle mainBundle] loadNibNamed:@"HeadView" owner:nil options:nil] lastObject];
    return head;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NewFootView *foot = [[[NSBundle mainBundle] loadNibNamed:@"NewFootView" owner:nil options:nil] lastObject];
    foot.delegate = self;
    return foot;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrdorCell *cell = [tableView dequeueReusableCellWithIdentifier:ordorIdentifier forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderManagerDetailsController *man = [[OrderManagerDetailsController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:man animated:YES];
}


- (void)NewFootViewCheckMaterialWith:(NewFootView *)newfootView{
    
    HTCheckLogisticsController * vc = [[HTCheckLogisticsController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
