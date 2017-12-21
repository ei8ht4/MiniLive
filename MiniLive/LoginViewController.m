//
//  LoginViewController.m
//  MiniLive
//
//  Created by HEHE on 2017/12/19.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import "LoginViewController.h"
#import "COMMON_MACRO.h"

#import "MLWebApiInvoker.h"
#import "MLResponse.h"
#import "MLToast.h"
#import "MLSession.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtUser;
@property (weak, nonatomic) IBOutlet UITextField *txtPasswd;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@end

@implementation LoginViewController

// 处理密码
-(NSString*) processPassword:(NSString*)password
{
    if(!password || password.length == 0)
        return @"";
    NSData *data = [password dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    
    NSMutableString *result = [[NSMutableString alloc] init];
    
    NSUInteger nLen = base64String.length;
    unichar c;
    for(NSUInteger i = 0; i < nLen; i += 2)
    {
        if(i + 1 < nLen)
        {
            c = [base64String characterAtIndex:i + 1];
            [result appendString:[[NSString alloc] initWithCharacters:&c length:1]];
            c = [base64String characterAtIndex:i];
            [result appendString:[[NSString alloc] initWithCharacters:&c length:1]];
        }
    }
    
    return result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[[ for debug
    self.txtUser.text = @"13980577542";
    self.txtPasswd.text = @"";
    //]]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 登录
- (IBAction)LoginBtnPressed:(UIButton *)sender {
    
    [self.btnLogin setTitle:@"登录中..." forState:UIControlStateNormal];
    
    NSString *userID = self.txtUser.text;
    NSString *passwd = [self processPassword:self.txtPasswd.text];
    
    MLWebApiInvoker *api = [MLWebApiInvoker shareInstance];
    
    [api login:userID
      password:passwd
        finish:^(BOOL success, MLResponse *response, NSString *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            WEAK_SELF;
            
            [weakSelf.btnLogin setTitle:@"登录" forState:UIControlStateNormal];
            
            [[MLSession shareInstance] clear];
            
            if(success)
            {
                if(response.status)  // 登录成功
                {
                    __weak MLLoginResponse *loginResponse = (MLLoginResponse*)response;
                    [MLSession shareInstance].token = loginResponse.token;
                    [MLSession shareInstance].userID = loginResponse.id;
                    [MLSession shareInstance].roomID = loginResponse.roomID;
                    
                    [weakSelf performSegueWithIdentifier:@"login2prepare" sender:weakSelf];
                }
                else
                {
                    [MLToast toast:response.message withTitle:@"登录失败" viewController:weakSelf];
                }
            }
            else
            {
                [MLToast toast:error withTitle:@"登录请求失败" viewController:weakSelf];
            }
        });
    }];
}

// 注册
- (IBAction)RegisterBtnPressed:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册" message:@"请关注我们的微信公众号[直播起]中注册" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}

// 点击空白处
- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    [self.txtUser resignFirstResponder];
    [self.txtPasswd resignFirstResponder];
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
