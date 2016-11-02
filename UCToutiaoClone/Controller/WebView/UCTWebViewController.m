//
//  UCTWebViewController.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/10/12.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTWebViewController.h"
#import "Masonry.h"
#import "UIColor+hexColor.h"

#define CUSTOM_NAV_BAR_HEIGHT 44
#define BAR_BUTTON_ITEM_COLOR_READING [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4f]

const CGFloat SCROLLVIEW_REACTION_OFFSET_Y = 40;

@interface UCTWebViewController () <UIWebViewDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) UIWebView *mainWebView;
@property (strong, nonatomic) UIView *customNavTitleView;
@property (strong, nonatomic) UIButton *moreButton;
@property (strong, nonatomic) UIButton *backButton;
@property (copy, nonatomic) NSString *requestUrlString;
@property (assign, nonatomic) BOOL isStatusBarNeed2Hide;
@property (assign, nonatomic) CGFloat scrollViewBeginDraggingOffsetY;
@end

@implementation UCTWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadRequest];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return _isStatusBarNeed2Hide;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

- (void)configureNavigationBar {
    [super configureNavigationBar];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"icon_alpha"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"icon_alpha"] forBarMetrics:UIBarMetricsDefault];
    
    self.moreButton = [[UIButton alloc] init];
    [_moreButton setFrame:CGRectMake(0, 0, 32, 32)];
    [_moreButton.layer setCornerRadius:16];
    [_moreButton addTarget:self action:@selector(clickMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    [_moreButton setBackgroundImage:[UIImage imageNamed:@"icon_nav_more"] forState:UIControlStateNormal];
    UIBarButtonItem *moreButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_moreButton];
    self.navigationItem.rightBarButtonItem = moreButtonItem;
    
    self.backButton = [[UIButton alloc] init];
    [_backButton setFrame:CGRectMake(0, 0, 32, 32)];
    [_backButton.layer setCornerRadius:16];
    [_backButton addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [_backButton setBackgroundImage:[UIImage imageNamed:@"icon_nav_back"] forState:UIControlStateNormal];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)clickMoreButton:(id)sender {
    
}

- (void)loadRequest {
    if (_requestUrlString.length > 0) {
        NSURL *requestUrl = [NSURL URLWithString:_requestUrlString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:requestUrl];
        [self.mainWebView loadRequest:request];
    }
}

- (instancetype)initWithRequestUrlString:(NSString *)requestUrlString title:(NSString *)title {
    self = [self init];
    if (self) {
        self.title = title;
        _requestUrlString = requestUrlString;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY - _scrollViewBeginDraggingOffsetY > SCROLLVIEW_REACTION_OFFSET_Y) {
        if (NO == _isStatusBarNeed2Hide) {
            [self toReadingStatus];
        }
    } else if (offsetY - _scrollViewBeginDraggingOffsetY < -SCROLLVIEW_REACTION_OFFSET_Y) {
        if (YES == _isStatusBarNeed2Hide) {
            self.isStatusBarNeed2Hide = NO;
            [UIView animateWithDuration:.3 animations:^{
                [self setNeedsStatusBarAppearanceUpdate];
            }];
        }
        if (0 >= offsetY) {
            [self toOperatingStatus];
        }
    }
}

- (void)toReadingStatus {
    self.isStatusBarNeed2Hide = YES;
    [UIView animateWithDuration:.3 animations:^{
        [self setNeedsStatusBarAppearanceUpdate];
        [_moreButton setBackgroundColor:BAR_BUTTON_ITEM_COLOR_READING];
        [_backButton setBackgroundColor:BAR_BUTTON_ITEM_COLOR_READING];
    }];
}

- (void)toOperatingStatus {
    self.isStatusBarNeed2Hide = NO;
    [UIView animateWithDuration:.3 animations:^{
        [self setNeedsStatusBarAppearanceUpdate];
        [_moreButton setBackgroundColor:[UIColor whiteColor]];
        [_backButton setBackgroundColor:[UIColor whiteColor]];
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.scrollViewBeginDraggingOffsetY = scrollView.contentOffset.y;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIWebView *)mainWebView {
    if (!_mainWebView) {
        _mainWebView = [[UIWebView alloc] init];
        [_mainWebView setBackgroundColor:[UIColor whiteColor]];
        _mainWebView.delegate = self;
        _mainWebView.scrollView.delegate = self;
        [self.view addSubview:_mainWebView];
        [_mainWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _mainWebView;
}
@end
