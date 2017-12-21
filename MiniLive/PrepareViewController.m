//
//  PrepareViewController.m
//  MiniLive
//
//  Created by HEHE on 2017/12/19.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import "PrepareViewController.h"
#import "MLWebApiInvoker.h"
#import "MLSession.h"

@interface PrepareViewController ()

@end

@implementation PrepareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[[ for debug
    MLWebApiInvoker *api = [MLWebApiInvoker shareInstance];
    MLSession   *session = [MLSession shareInstance];
    
    NSString *roomID = nil;// [MLSession shareInstance].roomID;
//    if(roomID && roomID.length > 0)
//    {
//        [api getRoom:roomID token:session.token finish:^(BOOL success, MLResponse *response, NSString *error) {
//            //
//        }];
//    }
//    else
//    {
//        [api getRoomList:session.token finish:^(BOOL success, MLResponse *response, NSString *error) {
//            NSLog(@"%@", response);
//        }];
//    }
    [api alive:@"ACA0ADAC-F527-48B6-B5F6-78083EEC3128" token:session.token finish:^(BOOL success, MLResponse *response, NSString *error) {
        NSLog(@"%@", response);
    }];
    //]]
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
