//
//  AGShareSDKSampleViewController.m
//  ShareSDKCustomActionSheetSample
//
//  Created by Nogard on 13-10-10.
//  Copyright (c) 2013年 ShareSDK. All rights reserved.
//

#import "AGShareSDKSampleViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <AGCommon/UIDevice+Common.h>
#import <AGCommon/UIView+Common.h>

@interface AGShareSDKSampleViewController ()

@end

@implementation AGShareSDKSampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIButton *anchorButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [anchorButton setTitle:@"分享" forState:UIControlStateNormal];
    [anchorButton sizeToFit];
    [anchorButton addTarget:self
                     action:@selector(buttonClicked:)
           forControlEvents:UIControlEventTouchDown];

    CGFloat x = (self.view.width - anchorButton.width) /2;
    CGFloat y = self.view.height * 0.33333;
    CGFloat w = anchorButton.width;
    CGFloat h = anchorButton.height;
    anchorButton.frame = CGRectMake(x, y, w, h);

    [self.view addSubview:anchorButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Button Event Handle

- (void)buttonClicked:(id)sender
{
    //TODO: 1.构造一个Container（iPhone可省略）
    id<ISSContainer> container = [ShareSDK container];

    if ([[UIDevice currentDevice] isPad])
        [container setIPadContainerWithView:sender
                                arrowDirect:UIPopoverArrowDirectionUp];
    else
        [container setIPhoneContainerWithViewController:self];

    //TODO: 2.构造shareList，项目的顺序也会反映在菜单顺序之中
    NSArray *shareList = [ShareSDK getShareListWithType:
                          ShareTypeWeixiSession,
                          ShareTypeWeixiTimeline,
                          ShareTypeSinaWeibo,
                          ShareTypeTencentWeibo,
                          ShareTypeQQ,
                          ShareTypeCopy,
                          nil];

    id<ISSContent> publishContent = nil;

    NSString *contentString = @"This is a sample";
    NSString *titleString   = @"title";
    NSString *urlString     = @"http://www.ShareSDK.cn";
    NSString *description   = @"Sample";

    publishContent = [ShareSDK content:contentString
                        defaultContent:@""
                                 image:nil
                                 title:titleString
                                   url:urlString
                           description:description
                             mediaType:SSPublishContentMediaTypeText];

    id<ISSShareOptions> shareOptions =
            [ShareSDK simpleShareOptionsWithTitle:@"分享内容"
                                shareViewDelegate:nil];

    //TODO: 3.将构造好的container（iPhone上可为nil）和shareList传入 showShareActionSheet 方法
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:NO
                       authOptions:nil
                      shareOptions:shareOptions
                            result:nil];
}

@end
