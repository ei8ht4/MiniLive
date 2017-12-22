//
//  PrepareViewController.m
//  MiniLive
//
//  Created by HEHE on 2017/12/19.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import "PrepareViewController.h"
#import "MLWebApiInvoker.h"
#import "COMMON_MACRO.h"
#import "MLSession.h"
#import "MLResponse.h"
#import "MLToast.h"
#import "LiveViewController.h"

@interface PrepareViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PrepareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MLWebApiInvoker *api = [MLWebApiInvoker shareInstance];
    [api getRoomList:[MLSession shareInstance].token
              finish:^(BOOL success, MLResponse *response, NSString *error) {
                    WEAK_SELF;
                    if(success)
                    {
                        if(response.status)
                        {
                            __weak MLGetRoomListResponse *roomlistResponse = (MLGetRoomListResponse*)response;
                            [MLSession shareInstance].roomList = [roomlistResponse.roomList copy];
                        }
                        else
                        {
                            [MLToast toast:response.message withTitle:@"获取直播间失败" viewController:weakSelf];
                        }
                    }
                    else
                    {
                        [MLToast toast:error withTitle:@"获取直播间请求失败" viewController:weakSelf];
                    }
    }];
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    [super willMoveToParentViewController:parent];
    
    if(!parent)
    {
        [[MLWebApiInvoker shareInstance] logout:[MLSession shareInstance].token finish:^(BOOL success, MLResponse *response, NSString *error) {
            [[MLSession shareInstance] clear];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnLivePressed:(UIButton *)sender {
    UIViewController *liveVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LiveViewController"];
    [self presentViewController:liveVC animated:YES completion:nil];
}

#pragma mark TableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = nil;
    switch(section)
    {
        case 0:
            title = @"直播间";
            break;
        case 1:
            title = @"视频参数";
            break;
        case 2:
            title = @"音频参数";
            break;
        case 3:
            title = @"其它";
            break;
        default:
            break;
    }
    return title;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    switch(section)
    {
        case 0:
            count = 1;
            break;
        case 1:
            count = 3;
            break;
        case 2:
            count = 2;
            break;
        case 3:
            count = 1;
            break;
        default:
            break;
    }
    return count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if(indexPath.section == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"roomCell" forIndexPath:indexPath];
        
        cell.textLabel.text = @"哇哈哈";
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"codecCell" forIndexPath:indexPath];
    }
    
    return cell;
}

#pragma mark TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        [self performSegueWithIdentifier:@"prepare2selectroom" sender:self];
    }
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
