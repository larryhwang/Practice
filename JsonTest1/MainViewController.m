//
//  MainViewController.m
//  JsonTest1
//
//  Created by Larry.Hwang on 15/7/15.
//  Copyright (c) 2015年 Larry.Hwang. All rights reserved.
//

#import "MainViewController.h"
#import "video.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     NSString *StrUl = @"http://localhost/Server_Json/video.php";
    NSURL *Url = [NSURL URLWithString:StrUl];
     NSURLRequest *rqe = [NSURLRequest requestWithURL:Url];
    
  
    NSURLResponse  *response=nil;
    NSError  *erro = nil;
    
    NSData  *data  =  [NSURLConnection sendSynchronousRequest:rqe returningResponse:&response error:&erro];
    

//  Server data transform to dit
    NSDictionary *dit = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil ];
    
 //   NSLog(@"dit from data%@",dit);
    
#warning  usages of mutiply dictionnary
    
  //  NSLog(@"dictionary log out %@ ",dit[@"videos"][@"video"][@"name"]);
    
    
   
    
// Server data tranform to array
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"array log out %@",array);
    
    
    NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers
                                                          error:nil];
    NSMutableArray *Marray = [[NSMutableArray alloc]init];
 //   NSArray *values=[dict1 allValues];
 //   NSLog(@"all values from dict%@",values);
//    
//   for (NSDictionary *dit in array) {
//        NSLog(@"plus+");
//       [Marray addObject:dit];
//       NSLog(@"%@",dit[@"0"][@"name"]);
//    }
    
    for (NSDictionary *dit in array) {
        NSLog(@"plus+");
        [Marray addObject:dit];
        
#warning crash 的地方
        NSLog(@"%@",dit[@"name"]);
   }
    
    
    
//    NSLog(@"%d",Marray.count);
//    NSMutableArray *Marray = [[NSMutableArray alloc]init];
//    NSInteger i = 0;
//    for (NSDictionary *dict in array) {
//        i++;
//        NSLog(@"plus +");
//     //   NSLog(@"%@",dict);
//        NSArray *values=[dict1 allValues];
//        NSLog(@"%@",values);
//    }
//    NSLog(@"%i",i);
}





#pragma  mark    DataHandler





@end
