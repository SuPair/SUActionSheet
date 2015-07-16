//
//  SUActionSheet.m
//  SUUIWindow
//
//  Created by SuPan on 15/7/16.
//  Copyright © 2015年 SuPan. All rights reserved.
//

#import "SUActionSheet.h"

#define kSUVIEWTAG 2637485 //suView tag value

@implementation SUActionSheet
{

    UITapGestureRecognizer *tap; //点击手势
}

+ (instancetype)sharedManger{

    static SUActionSheet *su = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        su = [[SUActionSheet alloc] init];
    });
    return su;
}
/**
 *  重写初始化方法
 *
 *  @return 返回对象实例
 */
- (instancetype)init{
    
    self = [super init];
    if (self) {
        //初始化window
        self.suWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.suWindow.windowLevel = UIWindowLevelAlert;
    }
    return self;
}
/**
 *  设置内容
 *
 *  @param view block块
 */
- (void)setContentView:(ContentView)view{
    self.suView = view;
}
- (void)setSuView:(ContentView)suView{

    if (suView == nil) {
        NSAssert(YES, @"传入参数不能为空！");
        return;
    }
    if (_suView != suView) {
    
        if (_suView == nil) {
            _suView = suView;
        }else{
            //移除原有的
            [_suView() removeFromSuperview];
        }
        UIView *view = _suView();
        view.tag = kSUVIEWTAG;
        view.frame = CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height + view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        //添加到window
        [self.suWindow addSubview:view];
    }
}

- (void)setAutomaticSwitchWindow:(BOOL)automaticSwitchWindow{

    if (_automaticSwitchWindow != automaticSwitchWindow) {
        _automaticSwitchWindow = automaticSwitchWindow;
        if (_automaticSwitchWindow) {
            //添加点击切换window
            tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(automaticSwitchWindowWhenTap:)];
            [self.suWindow addGestureRecognizer:tap];
        }else{
            if (tap != nil) {
                //移除手势
                [self.suWindow removeGestureRecognizer:tap];
            }
        }
    }
}
/**
 *  tap 点击事件
 *
 *  @param sender 手势实例
 */
- (void)automaticSwitchWindowWhenTap:(UITapGestureRecognizer *)sender{
    [self dismissSUSheetAnimated:YES];
}

/**
 *  显示窗口
 *
 *  @param flag 是否有动画
 */
- (void)showSUSheetAnimated:(BOOL)flag{
    
    if (flag) {
        [UIView animateWithDuration:.2 animations:^{
            if (_suView != nil) {
                UIView *view = [self.suWindow viewWithTag:kSUVIEWTAG];
                view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y-[UIScreen mainScreen].bounds.size.height, view.frame.size.width, view.frame.size.height);
            }
        }];
    }else{
        if (_suView != nil) {
            UIView *view = [self.suWindow viewWithTag:kSUVIEWTAG];
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y-[UIScreen mainScreen].bounds.size.height, view.frame.size.width, view.frame.size.height);
        }
    }
    [self.suWindow setHidden:NO];
    [self.suWindow makeKeyAndVisible];
}
/**
 *  消失窗口
 *
 *  @param flag 是否有动画
 */
- (void)dismissSUSheetAnimated:(BOOL)flag{
    
    if (flag) {
        [UIView animateWithDuration:.2 animations:^{
            if (_suView != nil) {
                UIView *view = [self.suWindow viewWithTag:kSUVIEWTAG];
                view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y+[UIScreen mainScreen].bounds.size.height, view.frame.size.width, view.frame.size.height);
            }
        }];
    }else{
        if (_suView != nil) {
            UIView *view = [self.suWindow viewWithTag:kSUVIEWTAG];
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y+[UIScreen mainScreen].bounds.size.height, view.frame.size.width, view.frame.size.height);
        }
    }
    
    if (flag) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.suWindow setHidden:YES];
            UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
            [keyWindow makeKeyAndVisible];
        });
    }
   
}

@end
