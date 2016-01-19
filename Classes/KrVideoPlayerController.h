//
//  KrVideoPlayerController.h
//  KrVideoPlayerPlus
//
//  Created by JiaHaiyang on 15/6/19.
//  Copyright (c) 2015年 JiaHaiyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KrVideoPlayerControlView.h"

@import MediaPlayer;

@protocol topBarActionDelegate <NSObject>

- (void)returnFrontPage;
- (void)clickPraiseAction;
- (void)clickMoreBtnAction;

@end


@interface KrVideoPlayerController : MPMoviePlayerController
/** video.view 消失 */
@property (nonatomic, copy)void(^dimissCompleteBlock)(void);
/** 进入最小化状态 */
@property (nonatomic, copy)void(^willBackOrientationPortrait)(void);
@property (nonatomic, strong) KrVideoPlayerControlView *videoControl;
/** 进入全屏状态 */
@property (nonatomic, copy)void(^willChangeToFullscreenMode)(void);
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign)id<topBarActionDelegate> topBarDelegate;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)showInWindow;
- (void)dismiss;
/**
 *  获取视频截图
 */
+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;
@end
