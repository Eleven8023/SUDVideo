//
//  KrVideoPlayerControlView.m
//  KrVideoPlayerPlus
//
//  Created by JiaHaiyang on 15/6/19.
//  Copyright (c) 2015年 JiaHaiyang. All rights reserved.
//

#import "KrVideoPlayerControlView.h"

static const CGFloat kVideoControlBarHeight = 40.0;
static const CGFloat kVideoControlAnimationTimeinterval = 0.3;
static const CGFloat kVideoControlTimeLabelFontSize = 10.0;
static const CGFloat kVideoControlBarAutoFadeOutTimeinterval = 5.0;

@interface KrVideoPlayerControlView()

@property (nonatomic, strong) UIView *topBar;
@property (nonatomic, strong) UIView *bottomBar;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIButton *pauseButton;
@property (nonatomic, strong) UIButton *fullScreenButton;
@property (nonatomic, strong) UIButton *shrinkScreenButton;
@property (nonatomic, strong) UISlider *progressSlider;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, assign) BOOL isBarShowing;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UIButton *returnBtn;
@property (nonatomic, strong) UIButton *loveBtn;
@property (nonatomic, strong) UIButton *viewsBtn;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *loveCountLable;
@property (nonatomic, strong) UILabel *viewsCountLabel;
@end
@implementation KrVideoPlayerControlView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.topBar];
        [self addSubview:self.bottomBar];
        [self.bottomBar addSubview:self.playButton];
        [self.bottomBar addSubview:self.pauseButton];
        self.pauseButton.hidden = YES;
//        [self.bottomBar addSubview:self.fullScreenButton];
        [self.bottomBar addSubview:self.shrinkScreenButton];
        self.shrinkScreenButton.hidden = YES;
        [self.bottomBar addSubview:self.progressSlider];
        [self.bottomBar addSubview:self.timeLabel];
        [self.topBar addSubview:self.returnBtn];
        [self.topBar addSubview:self.titleLabel];
        [self.topBar addSubview:self.loveBtn];
        [self.topBar addSubview:self.loveCountLable];
        [self.topBar addSubview:self.viewsBtn];
        [self.topBar addSubview:self.viewsCountLabel];
        [self.topBar addSubview:self.moreBtn];
        [self addSubview:self.indicatorView];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.topBar.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), kVideoControlBarHeight);
    self.closeButton.frame = CGRectMake(CGRectGetWidth(self.topBar.bounds) - CGRectGetWidth(self.closeButton.bounds), CGRectGetMinX(self.topBar.bounds), CGRectGetWidth(self.closeButton.bounds), CGRectGetHeight(self.closeButton.bounds));
    self.returnBtn.frame = CGRectMake(CGRectGetWidth(self.returnBtn.bounds), CGRectGetHeight(self.topBar.bounds)/2 - CGRectGetHeight(self.returnBtn.bounds)/2, CGRectGetWidth(self.returnBtn.bounds), CGRectGetHeight(self.returnBtn.bounds));
    self.titleLabel.frame = CGRectMake(CGRectGetWidth(self.returnBtn.bounds) * 2 + 12, CGRectGetHeight(self.topBar.bounds) / 2 - CGRectGetHeight(self.returnBtn.bounds)/2, CGRectGetWidth(self.titleLabel.bounds), CGRectGetHeight(self.titleLabel.bounds));
    self.loveBtn.frame = CGRectMake(CGRectGetWidth(self.returnBtn.bounds) * 2 + CGRectGetWidth(self.titleLabel.bounds) + 30, CGRectGetHeight(self.topBar.bounds) / 2 - CGRectGetHeight(self.returnBtn.bounds) / 2, CGRectGetWidth(self.loveBtn.bounds), CGRectGetHeight(self.loveBtn.bounds));
    self.loveCountLable.frame = CGRectMake(CGRectGetWidth(self.returnBtn.bounds) * 2 + CGRectGetWidth(self.titleLabel.bounds) + CGRectGetWidth(self.loveBtn.bounds) + 35, CGRectGetHeight(self.topBar.bounds) / 2 - CGRectGetHeight(self.returnBtn.bounds) / 2, CGRectGetWidth(self.loveCountLable.bounds), CGRectGetHeight(self.loveCountLable.bounds));
    self.viewsBtn.frame = CGRectMake(self.loveCountLable.frame.origin.x + self.loveCountLable.frame.size.width + 5, CGRectGetHeight(self.topBar.bounds) / 2 - CGRectGetHeight(self.returnBtn.bounds) / 2, CGRectGetWidth(self.viewsBtn.bounds), CGRectGetHeight(self.viewsBtn.bounds));
    self.viewsCountLabel.frame = CGRectMake(self.viewsBtn.frame.origin.x + self.viewsBtn.frame.size.width + 5, CGRectGetHeight(self.topBar.bounds) / 2 - CGRectGetHeight(self.returnBtn.bounds) / 2, CGRectGetWidth(self.viewsCountLabel.bounds), CGRectGetHeight(self.viewsCountLabel.bounds));
    self.moreBtn.frame = CGRectMake(self.viewsCountLabel.frame.origin.x + self.viewsCountLabel.frame.size.width + 25,  CGRectGetHeight(self.topBar.bounds) / 2 - CGRectGetHeight(self.returnBtn.bounds) / 2 + 6, CGRectGetWidth(self.moreBtn.bounds), CGRectGetHeight(self.moreBtn.bounds));
    
    self.bottomBar.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetHeight(self.bounds) - kVideoControlBarHeight, CGRectGetWidth(self.bounds), kVideoControlBarHeight);
    self.playButton.frame = CGRectMake(CGRectGetMinX(self.bottomBar.bounds), CGRectGetHeight(self.bottomBar.bounds)/2 - CGRectGetHeight(self.playButton.bounds)/2, CGRectGetWidth(self.playButton.bounds), CGRectGetHeight(self.playButton.bounds));
    self.pauseButton.frame = self.playButton.frame;
    self.fullScreenButton.frame = CGRectMake(CGRectGetWidth(self.bottomBar.bounds) - CGRectGetWidth(self.fullScreenButton.bounds), CGRectGetHeight(self.bottomBar.bounds)/2 - CGRectGetHeight(self.fullScreenButton.bounds)/2, CGRectGetWidth(self.fullScreenButton.bounds), CGRectGetHeight(self.fullScreenButton.bounds));
    self.shrinkScreenButton.frame = self.fullScreenButton.frame;
    self.progressSlider.frame = CGRectMake(CGRectGetMaxX(self.playButton.frame), CGRectGetHeight(self.bottomBar.bounds)/2 - CGRectGetHeight(self.progressSlider.bounds)/2, CGRectGetMinX(self.fullScreenButton.frame) - CGRectGetMaxX(self.playButton.frame), CGRectGetHeight(self.progressSlider.bounds));
    self.timeLabel.frame = CGRectMake(CGRectGetMidX(self.progressSlider.frame), CGRectGetHeight(self.bottomBar.bounds) - CGRectGetHeight(self.timeLabel.bounds) - 2.0, CGRectGetWidth(self.progressSlider.bounds)/2, CGRectGetHeight(self.timeLabel.bounds));
    self.indicatorView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    self.isBarShowing = YES;
}

- (void)animateHide
{
    if (!self.isBarShowing) {
        return;
    }
    [UIView animateWithDuration:kVideoControlAnimationTimeinterval animations:^{
        self.topBar.alpha = 0.0;
        self.bottomBar.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.isBarShowing = NO;
    }];
}

- (void)animateShow
{
    if (self.isBarShowing) {
        return;
    }
    [UIView animateWithDuration:kVideoControlAnimationTimeinterval animations:^{
        self.topBar.alpha = 1.0;
        self.bottomBar.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.isBarShowing = YES;
        [self autoFadeOutControlBar];
    }];
}

- (void)autoFadeOutControlBar
{
    if (!self.isBarShowing) {
        return;
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(animateHide) object:nil];
    [self performSelector:@selector(animateHide) withObject:nil afterDelay:kVideoControlBarAutoFadeOutTimeinterval];
}

- (void)cancelAutoFadeOutControlBar
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(animateHide) object:nil];
}

- (void)onTap:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        if (self.isBarShowing) {
            [self animateHide];
        } else {
            [self animateShow];
        }
    }
}

#pragma mark - Property

- (UIView *)topBar
{
    if (!_topBar) {
        _topBar = [UIView new];
        _topBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
    return _topBar;
}

- (UIView *)bottomBar
{
    if (!_bottomBar) {
        _bottomBar = [UIView new];
        _bottomBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
    return _bottomBar;
}

- (UIButton *)playButton
{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"kr-video-player-play"] forState:UIControlStateNormal];
        _playButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _playButton;
}

- (UIButton *)pauseButton
{
    if (!_pauseButton) {
        _pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pauseButton setImage:[UIImage imageNamed:@"kr-video-player-pause"] forState:UIControlStateNormal];
        _pauseButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _pauseButton;
}

- (UIButton *)fullScreenButton
{
    if (!_fullScreenButton) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenButton setImage:[UIImage imageNamed:@"kr-video-player-fullscreen"] forState:UIControlStateNormal];
        _fullScreenButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _fullScreenButton;
}

- (UIButton *)shrinkScreenButton
{
    if (!_shrinkScreenButton) {
        _shrinkScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shrinkScreenButton setImage:[UIImage imageNamed:@"kr-video-player-shrinkscreen"] forState:UIControlStateNormal];
        _shrinkScreenButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _shrinkScreenButton;
}

- (UISlider *)progressSlider
{
    if (!_progressSlider) {
        _progressSlider = [[UISlider alloc] init];
        [_progressSlider setThumbImage:[UIImage imageNamed:@"kr-video-player-point"] forState:UIControlStateNormal];
        [_progressSlider setMinimumTrackTintColor:[UIColor whiteColor]];
        [_progressSlider setMaximumTrackTintColor:[UIColor lightGrayColor]];
        _progressSlider.value = 0.f;
        _progressSlider.continuous = YES;
    }
    return _progressSlider;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"kr-video-player-close"] forState:UIControlStateNormal];
        _closeButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _closeButton;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont systemFontOfSize:kVideoControlTimeLabelFontSize];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.bounds = CGRectMake(0, 0, kVideoControlTimeLabelFontSize, kVideoControlTimeLabelFontSize);
    }
    return _timeLabel;
}

- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [_indicatorView stopAnimating];
    }
    return _indicatorView;
}

#pragma mark -topBar上的控件的懒加载

- (UIButton *)returnBtn
{
    if (!_returnBtn) {
        _returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *returnImage = [UIImage imageNamed:@"return-white"];
        returnImage = [returnImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_returnBtn setBackgroundImage:returnImage forState:UIControlStateNormal];
        _returnBtn.bounds = CGRectMake(0, 0, 10, 17.5);
    }
    return _returnBtn;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.bounds = CGRectMake(0, 0, 370, 17.5);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.backgroundColor = [UIColor redColor];
    }
    return _titleLabel;
}

- (UIButton *)loveBtn
{
    if (!_loveBtn) {
        _loveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loveBtn setBackgroundImage:[UIImage imageNamed:@"zan-video"] forState:UIControlStateNormal];
        _loveBtn.bounds = CGRectMake(0, 0, 20, 18.5);
    }
    return _loveBtn;
}

- (UILabel *)loveCountLable
{
    if (!_loveCountLable) {
        _loveCountLable = [[UILabel alloc] init];
        _loveCountLable.font = [UIFont systemFontOfSize:9];
        _loveCountLable.backgroundColor = [UIColor yellowColor];
        _loveCountLable.bounds = CGRectMake(0, 0, 60, 17.5);
    }
    return _loveCountLable;
}


- (UIButton *)viewsBtn
{
    if (!_viewsBtn) {
        _viewsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_viewsBtn setBackgroundImage:[UIImage imageNamed:@"zan-video"] forState:UIControlStateNormal];
        _viewsBtn.bounds = CGRectMake(0, 0, 20, 18.5);
    }
    return _viewsBtn;
}

- (UILabel *)viewsCountLabel
{
    if (!_viewsCountLabel) {
        _viewsCountLabel = [[UILabel alloc] init];
        _viewsCountLabel.font = [UIFont systemFontOfSize:9];
        _viewsCountLabel.backgroundColor = [UIColor cyanColor];
        _viewsCountLabel.bounds = CGRectMake(0, 0, 60, 17.5);
    }
    return _viewsCountLabel;
}

- (UIButton *)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setBackgroundImage:[UIImage imageNamed:@"genduo-white"] forState:UIControlStateNormal];
        _moreBtn.bounds = CGRectMake(0, 0, 20, 5);
    }
    return _moreBtn;
}

@end
