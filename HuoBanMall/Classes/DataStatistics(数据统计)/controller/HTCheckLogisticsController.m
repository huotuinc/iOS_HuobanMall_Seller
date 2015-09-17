//
//  HTCheckLogisticsController.m
//  HuoBanMall
//
//  Created by lhb on 15/9/16.
//  Copyright (c) 2015年 HT. All rights reserved.
//  查看物流

#import "HTCheckLogisticsController.h"
#import "ExpressCompany.h"
#import "NewOrdorCell.h"

@interface HTCheckLogisticsController ()

@end

@implementation HTCheckLogisticsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物流查看";
    
     [self.tableView registerNib:[UINib nibWithNibName:@"ExpressCompany" bundle:nil]   forCellReuseIdentifier:@"aa"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewOrdorCell" bundle:nil]   forCellReuseIdentifier:@"bb"];
    
//    self.tableView.userInteractionEnabled = NO;
//    self.tableView.
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    if (section == 0 || section == 1) {
        return 1;
    }else{
       return 4;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ExpressCompany * aa = [tableView dequeueReusableCellWithIdentifier:@"aa"];
        if (aa == nil) {
            
            aa = [[ExpressCompany alloc] init];
            aa.userInteractionEnabled = NO;
            
        }
        [aa setDateWithStatus:0 withCompany:@"顺丰" withOderNumber:@"111" withIconUrl:nil];
        aa.userInteractionEnabled = NO;
        return aa;
    }else if (indexPath.section == 1){
        
        NewOrdorCell * bb = [tableView dequeueReusableCellWithIdentifier:@"bb"];
        if (bb== nil) {
            
            bb = [[NewOrdorCell alloc] init];
                     }
        [bb setDate:@"xxxcxxxfhahsdasdklasdfkalshfdlkasfhlkafhklafhlkjashflkasfasfasfjdasfjkal" withPrice:@"1999" WithBuyNum:@"x1" withDesc:@"xxxxx" withIconUrl:nil];
        bb.userInteractionEnabled = NO;

        return bb;
    }else{
        
        static NSString * Id = @"xxxxxxx";
        UITableViewCell * cc = [tableView dequeueReusableCellWithIdentifier:Id];
        if (cc == nil) {
            
            cc = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Id];
            cc.textLabel.numberOfLines = 0;
            
           
        }
        if(indexPath.row == 0){
            
            cc.imageView.image = [UIImage imageNamed:@"green"];
//            cc.imageView.contentMode = UIViewContentModeScaleAspectFit;
        }else if(indexPath.row == 3){
            
            cc.imageView.image = [UIImage imageNamed:@"gray-2"];
        }else{
            cc.imageView.image = [UIImage imageNamed:@"gray"];
        }
        cc.textLabel.text = @"dahasdajsdhasjkdajsd\ndjasdjaskdaksdll";
        cc.detailTextLabel.text = @"2012-01-11";
        cc.userInteractionEnabled = NO;

        return cc;
    }
    
   
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return [self myselfSectionHeadViewWithTitle:@"物品信息"];
    }else if(section == 2) {
        
        return [self myselfSectionHeadViewWithTitle:@"查看物流"];
    }
    return nil;
}
- (UIView *)myselfSectionHeadViewWithTitle:(NSString *)title{
    
    UIView * vi = [[UIView alloc] init];
    vi.backgroundColor = [UIColor blackColor];
    vi.bounds = CGRectMake(10, 0,self.tableView.frame.size.width, 60);
    vi.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, self.tableView.frame.size.width, 20)];
    label.font = [UIFont systemFontOfSize:16.0f];  //UILabel的字体大小
    label.numberOfLines = 0;  //必须定义这个属性，否则UILabel不会换行
    label.textColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:76/255.0 alpha:1.000];
    label.textAlignment = NSTextAlignmentLeft;  //文本对齐方式
    [label setBackgroundColor:[UIColor clearColor]];
    label.text = title;
    [vi addSubview:label];
    return vi;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    if (section == 1) {
        return 30;
    }else if (section == 2){
        return 30;
    }
    return 2 ;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    return 80;
 
 }

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return @"物品信息";
    }
    return nil;
}
@end
