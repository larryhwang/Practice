//
//  video.h
//  JsonTest1
//
//  Created by Larry.Hwang on 15/7/16.
//  Copyright (c) 2015年 Larry.Hwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface video : NSObject

@property (assign, nonatomic) NSInteger videoId;
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger length;
@property (strong, nonatomic) NSString *videoURL;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *teacher;

@property (strong, nonatomic) UIImage *cacheImage;
//  视频时长的字符串
@property (strong, nonatomic, readonly) NSString *lengthStr;


@end
