//
//  LoginViewController.m
//  MiniLive
//
//  Created by HEHE on 2017/12/19.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import "LoginViewController.h"
#import "COMMON_MACRO.h"

//[[ for debug
#import "MLRESTClient.h"
//]]

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtUser;
@property (weak, nonatomic) IBOutlet UITextField *txtPasswd;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[[ for debug
    self.txtUser.text = @"13880793994";
    self.txtPasswd.text = @"11";
    //]]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LoginBtnPressed:(UIButton *)sender {
    
    MLRESTClient *restClient = [MLRESTClient shareInstance];
    [restClient requestWithURL:@"http://120.76.128.133:680/iBokerApi/minilive/login?mobile=13980577542&password="
                        method:POST parameters:nil
                       success:^(id responseObject) {
                           WEAK_SELF;
                           dispatch_queue_t queue = dispatch_get_main_queue();
                           dispatch_async(queue, ^{
                               [weakSelf loginResult];
                           });
                           NSLog(@"登录请求成功");
                       }
                       failure:^(NSError *error) {
                           NSLog(@"登录请求失败");
                       }
     ];
}

- (IBAction)RegisterBtnPressed:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册" message:@"请关注我们的微信公众号[直播起]中注册" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    [self.txtUser resignFirstResponder];
    [self.txtPasswd resignFirstResponder];
}

- (void)loginResult {
    NSLog(@"Login Result");
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
