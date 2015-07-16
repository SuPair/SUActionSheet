//
//  SUActionSheet.h
//  SUUIWindow
//
//  Created by SuPan on 15/7/16.
//  Copyright © 2015年 SuPan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef UIView *(^ContentView)();
//样式
typedef NS_ENUM(NSInteger,NSSUActionSheetStyle) {
    NSSUActionSheetStyleNormal = 0,
    NSSUActionSheetStyleCustom,
    NSSUActionSheetStyleHeader
};

@interface SUActionSheet : NSObject

@property (nonatomic, strong) UIWindow *suWindow;  //window
@property (nonatomic, strong) ContentView suView;  //内容视图
@property (nonatomic, assign) BOOL automaticSwitchWindow; //是否自动切换窗口

+ (instancetype)sharedManger;
/**
 *  显示
 *
 *  @param flag 是否动画
 */
- (void)showSUSheetAnimated:(BOOL)flag;
/**
 *  消失
 *
 *  @param flag 是否动画
 */
- (void)dismissSUSheetAnimated:(BOOL)flag;
/**
 *  设置内容
 *
 *  @param view 内容View
 */
- (void)setContentView:(ContentView)view;
@end
