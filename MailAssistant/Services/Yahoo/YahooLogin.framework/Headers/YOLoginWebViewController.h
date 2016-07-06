//
//  YOLoginWebViewController.h
//  YahooSDKDemo
//
//  Created by Dung Vu on 7/5/16.
//  Copyright © 2016 michaelho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YahooSession.h"

@protocol YOLoginWebViewControllerDelegate <NSObject>

- (void)didFinishLogin: (UIViewController *__nonnull)controller;
- (void)didLoginFail: (UIViewController *__nonnull)controller error:(NSError *__nullable)error;
- (void)cancelLogin: (UIViewController *__nonnull)controller;
- (void)requestAgain: (UIViewController *__nonnull)controller;

@end

@interface YOLoginWebViewController : UIViewController

// session
@property (weak, nonatomic, nullable) YahooSession *session;
@property (assign, nonatomic, nullable) id<YOLoginWebViewControllerDelegate> delegate;

@end
