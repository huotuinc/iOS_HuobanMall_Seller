//
//  ManagementController.m
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/8/24.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "ManagementController.h"
#import "ManagementModel.h"
#import "ManagementCell.h"

@interface ManagementController ()<UITableViewDelegate, UITableViewDataSource>

/**
 *  商品列表
 */
@property NSMutableArray *goods;

/**
 *  商品列表
 */
@property NSMutableArray *selectGoods;

/**
 *  表数据
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;





@end

@implementation ManagementController

static NSString * ManagementIdentifier = @"ManagementCellIdentifier";

#pragma 数据初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectGoods = [NSMutableArray array];
    
    self.goods = [NSMutableArray array];
    
    
    //tableView
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.editing = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ManagementCell" bundle:nil] forCellReuseIdentifier:ManagementIdentifier];
    
    [self.tableView removeSpaces];
    
    //设置选项卡
    NSArray *temp = @[@"已上架",@"已下架"];
    self.segment = [[UISegmentedControl alloc] initWithItems:temp];
    [self.segment addTarget:self action:@selector(segmentChanged) forControlEvents:UIControlEventValueChanged];
    self.segment.selectedSegmentIndex = 0;
    [self.navigationItem setTitleView:self.segment];
    
    /**
     设置右上角编辑按钮
     */
    UIBarButtonItem *right = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"bj"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        self.tableView.editing = !self.tableView.editing;
        
        /**
         *  设置底部视图隐藏显示动画
         */
        [self showButtomView];
        
    }];
    self.navigationItem.rightBarButtonItem = right;
    
    
    //设置上下架按钮
    self.putaway.layer.cornerRadius = 5;
    self.putaway.layer.borderColor = [UIColor colorWithWhite:0.784 alpha:1.000].CGColor;
    self.putaway.layer.borderWidth = 1;
 
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getNewGoodList];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 网络访问

- (void)getNewGoodList {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.segment.selectedSegmentIndex) {
        dic[@"type"] = @2;
    }else {
        dic[@"type"] = @1;
    }
    
    
    [UserLoginTool loginRequestGet:@"goodsList" parame:dic success:^(id json) {
        NSLog(@"%@",json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {

            NSArray *temp = [ManagementModel objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            
            [self.goods removeAllObjects];
            
            [self.goods addObjectsFromArray:temp];
            
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)getMoreGoodList {
    
}

- (void)exchangeGoodWithType:(int) type {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    NSMutableString *string = [NSMutableString string];
    
    for (ManagementModel  *model in self.selectGoods) {
        [string  appendFormat:@"%@,", model.goodsId];
    }
    NSString *toserverStr = [string substringToIndex:string.length - 1];
    
    dic[@"type"] = @(type);
    dic[@"goods"] = toserverStr;
    
}

#pragma tableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  100;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goods.count;
}

/**
 *  解决滑动的时候的勾选取消问题
 *
 *  @param tableView
 *  @param cell
 *  @param indexPath
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManagementModel *model = nil;
    if (self.goods.count) {
        model = self.goods[indexPath.row];
    }
    if (model) {
        if ([self.selectGoods containsObject:model]) {
            if (self.tableView.editing == YES) {
                [cell setSelected:YES];
            }
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManagementCell *cell = [tableView dequeueReusableCellWithIdentifier:ManagementIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ManagementCell" owner:nil options:nil] lastObject];
    }
    
    cell.model = self.goods[indexPath.row];
    
    
    return cell;
}

/**
 *  编辑模式选中
 *
 *  @param tableView
 *  @param indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManagementModel *model = nil;
    
    if (self.tableView.editing == YES) {
        
        model = self.goods[indexPath.row];
        
        [self.selectGoods addObject:model];
    }
}

/**
 *  编辑模式取消选中
 *
 *  @param tableView
 *  @param indexPath
 */

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManagementModel *model = nil;
    
    if (self.tableView.editing == YES) {
        
        model = self.goods[indexPath.row];
        
        [self.selectGoods removeObject:model];
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [cell setSelected:NO];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView.editing == YES) {
        return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    }else {
        return UITableViewCellEditingStyleNone;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma 按钮操作

- (void)segmentChanged {
    if (self.segment.selectedSegmentIndex == 0) {
#warning 已上架
    }else {
#warning 已下架
    }
}

- (void)showButtomView {
    if (self.tableView.editing) {
        [UIView animateWithDuration:0.5 animations:^{
            self.buttomView.hidden = NO;
        }];
    }else {
        [UIView animateWithDuration:0.35 animations:^{
            self.buttomView.hidden = YES;
        }];
    }
}


- (IBAction)putawayAction:(id)sender {
    
}

- (IBAction)deleteGood:(id)sender {
    
}

- (IBAction)allSelected:(id)sender {
    if (self.selectGoods.count != self.goods.count) {
        [self.selectGoods removeAllObjects];
        self.selectGoods = self.goods;
        self.selectImage.image = [UIImage imageNamed:@"yxz"];
        [self.tableView reloadData];
    }else {
        [self.selectGoods removeAllObjects];
        self.selectImage.image = [UIImage imageNamed:@"wxz"];
        [self.tableView reloadData];
    }
}
@end
