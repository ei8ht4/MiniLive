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
#import "MLParameters.h"
#import "CodecCell.h"
#import "LiveViewController.h"

@interface PrepareViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

enum CellSection
{
    SECTION_ROOM    = 0,
    SECTION_VIDEO,
    SECTION_AUDIO,
    SECTION_OTHER,
};

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
                            __weak MLSession *session = [MLSession shareInstance];
                            
                            session.roomList = [roomlistResponse.roomList copy];
                            
                            //[[ 刷新直播间
                            if(session.roomID.length == 0 && session.roomList.count > 0)
                            {
                                session.roomID = ((MLRoom*)session.roomList[0]).id;
                            }
                            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                            NSArray *paths = [NSArray arrayWithObject:indexPath];
                            [weakSelf.tableView reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationNone];
                            //]]
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

- (void)viewWillAppear:(BOOL)animated
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSArray *paths = [NSArray arrayWithObject:indexPath];
    [self.tableView reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationNone];
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
        case SECTION_ROOM:
            title = @"直播间";
            break;
        case SECTION_VIDEO:
            title = @"视频参数";
            break;
        case SECTION_AUDIO:
            title = @"音频参数";
            break;
        case SECTION_OTHER:
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
        case SECTION_ROOM:         // 直播间
            count = 1;
            break;
        case SECTION_VIDEO:
            count = 3;
            break;
        case SECTION_AUDIO:
            count = 2;
            break;
        case SECTION_OTHER:
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
    if(indexPath.section == SECTION_ROOM)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"roomCell" forIndexPath:indexPath];
        
        cell.textLabel.text = [MLSession shareInstance].roomName;
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"paramCell" forIndexPath:indexPath];
        
        CodecCell *codecCell = (CodecCell*)cell;
        
        __weak MLParameter *parameter = nil;
        __weak MLParameters *parameters = [MLParameters shareInstance];
        
        switch(indexPath.section)
        {
            case SECTION_VIDEO:
            {
                switch(indexPath.row)
                {
                    case 0:
                        parameter = parameters.videoResolution;
                        break;
                    case 1:
                        parameter = parameters.videoBitrate;
                        break;
                    case 2:
                        parameter = parameters.videoFrameRate;
                        break;
                    default:
                        break;
                }
            } break;
            case SECTION_AUDIO:
            {
                switch(indexPath.row)
                {
                    case 0:
                        parameter = parameters.audioSampleRate;
                        break;
                    case 1:
                        parameter = parameters.audioBitrate;
                        break;
                    default:
                        break;
                        
                }
            } break;
            case SECTION_OTHER:
            {
                switch(indexPath.row)
                {
                    case 0:
                        parameter = parameters.camera;
                        break;
                    default:
                        break;
                }
            } break;
        }
        
        [codecCell updateContentWithParameter:parameter];
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
