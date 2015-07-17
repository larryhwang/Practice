//
//  ViewController.m
//  PHP后台_前台登陆
//
//  Created by Larry.Hwang on 15/7/10.
//  Copyright (c) 2015年 Larry.Hwang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>

@property (weak , nonatomic) UITextField *nameTextFiled;
@property (weak,  nonatomic) UITextField *passwordTextFiled;
@property (strong ,nonatomic) NSMutableData *ServerData;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
	 
}

- (void)setupUI {
    NSMutableArray *arrayM =[[NSMutableArray alloc]initWithCapacity:4];
    for (int i=0; i<2; i++) {
        UITextField *text  =  [[UITextField alloc]initWithFrame:CGRectMake(75, 40+40*i, 200, 30)];
        [text setBorderStyle:UITextBorderStyleRoundedRect];  //边框设定
        [text setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];  //文字剧中
        [arrayM addObject:text];
        [self.view addSubview:text];
    }
    
    
    for (int i=0; i<2; i++) {
        UILabel *lable  =  [[UILabel alloc]initWithFrame:CGRectMake(15, 33+40*i, 60, 40)];
        [arrayM addObject:lable];
        [self.view addSubview:lable];
    }
    [(UILabel *)arrayM[2] setText:@"用户名"];   //数组里面的成员对象调用方法
    [(UILabel *)arrayM[3] setText:@"密  码"];
    
 
    self.nameTextFiled = arrayM[0];
    self.passwordTextFiled = arrayM[1];
    
   [self.passwordTextFiled setSecureTextEntry:YES];   //密码星号
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(130, 140, 60, 30)];    //I4-
    
    [btn setTitle:@"登陆" forState:UIControlStateNormal];
    btn.layer.borderWidth =1.5;
    
   btn.layer.cornerRadius = 4.5;
    // 设置颜色空间为rgb，用于生成ColorRef
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){0.6824f, 0.7882f, 1.0f, 1});
    // 设置边框颜色
    btn.layer.borderColor = borderColorRef;
    
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    

}


-(void) click {
    
    //建立请求
    
    NSString  *name  = self.nameTextFiled.text;
    NSString  *pwd = self.passwordTextFiled.text;
    
 //  [self loginWithGetWithName:name pwd:pwd];
   [self loginWithPostWithName:name pwd:pwd];

}



#pragma  mark  -代理方法

    // 1.得到接到服务器的响应第一个执行的方法，服务器要传送数据   初始化接受过来的数据
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {


}

     //2.接受服务器数据
-(void)connection:(NSURLConnection *) connection didReceiveData:(NSData *)data {
    [self.ServerData  appendData:data];    //不断接受数据，可能多次执行
    // NSData *responseData=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
}

     //3.数据接受完成后，做后续处理
-(void) connectionDidFinishLoading:(NSURLConnection *)connection {

    NSString *str = [[NSString alloc]initWithData:self.ServerData encoding:NSUTF8StringEncoding];
    
    
       //由字符串转换为字典
//    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:self.ServerData
                                                        options:NSJSONReadingMutableContainers
                                                        error:nil];
#warning wrote by myself
    NSLog(@"传值方式是%@",dic[@"Type"]);
      NSLog(@"%@",dic);
    NSString *WecomeMsg = [NSString stringWithFormat:@"欢迎回来,%@",dic[@"userName"]];
    
    
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:WecomeMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    self.ServerData = nil;   //清理数据
}

     //4.获取网络错误时的信息
-(void)connection:(NSURLConnection *) connection diFailWithError : (NSError *) error{
    NSLog(@"网络请求错误:%@",error.localizedDescription);
}

    //向服务器发送资源 ， 仅适合 POST   现在多数用第三方框架了
-(void) connection:(NSURLConnection *) connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
    NSLog(@"send data to sever");
}






- (void)loginWithPostWithName:(NSString *)userName pwd:(NSString *)pwd
{
    // 1. 确定地址NSURL
    NSString *urlString = [NSString stringWithFormat:@"http://localhost/IOS_Server/login.php"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2. 建立请求NSURLRequest(POST)
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];   //可变地址的请求
    
   NSURLResponse *response =nil;
   NSError *error = nil;
    
   
    //同步请求
  //  [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];    //引用指针的指针
    
    
    
    //异步请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *reponse, NSData *data, NSError *error) {
        
        if (data != nil) {
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", str);
        } else if (data == nil && error == nil) {
            NSLog(@"接收到空数据");
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
    // 1) 请求方式
    [request setHTTPMethod:@"POST"];
    
    NSString *bodyStr = [NSString stringWithFormat:@"username=%@&password=%@", userName, pwd];
    // 将NSString转换为NSData
    NSData *body = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:body];
    
    // 3. 建立并启动连接NSURLConnection
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    // 启动连接，异步连接请求
    [conn start];
    
    // 服务器通知准备，准备中转数据
    self.serverData = [NSMutableData data];
}




#pragma mark Get登录
- (void)loginWithGetWithName:(NSString *)userName pwd:(NSString *)pwd
{
    // 1. 确定地址NSURL
    NSString *urlString = [NSString stringWithFormat:@"http://localhost/IOS_Server/login.php?username=%@&password=%@", userName, pwd];
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2. 建立请求NSURLRequest
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    

    //异步请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *reponse, NSData *data, NSError *error) {
        
        if (data != nil) {
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", str);
        } else if (data == nil && error == nil) {
            NSLog(@"接收到空数据");
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
    // 3. 建立并启动连接NSURLConnection
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    // 启动连接，异步连接请求
    [conn start];
    
    // 服务器通知准备，准备中转数据
    self.serverData = [NSMutableData data];
}


@end






