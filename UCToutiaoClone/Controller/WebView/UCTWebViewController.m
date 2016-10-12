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

const CGFloat SCROLLVIEW_REACTION_OFFSET_Y  = 80;

@interface UCTWebViewController () <UIWebViewDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) UIWebView *mainWebView;
@property (strong, nonatomic) UIButton *moreButton;
@property (strong, nonatomic) UIButton *backButton;
@property (copy, nonatomic) NSString *requestUrlString;
@property (assign, nonatomic) BOOL isStatusBarNeed2Hide;
@property (assign, nonatomic) CGFloat scrollViewBeginDraggingOffsetY;
@end

@implementation UCTWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNavigationBar];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:.8 animations:^{
        [self setNeedsStatusBarAppearanceUpdate];
    }];
}

- (void)configureNavigationBar {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"icon_alpha"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    
    self.moreButton = [[UIButton alloc] init];
    [_moreButton setFrame:CGRectMake(0, 0, 32, 32)];
    [_moreButton.layer setCornerRadius:16];
    [_moreButton addTarget:self action:@selector(clickMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    [_moreButton setBackgroundImage:[UIImage imageNamed:@"icon_nav_more"] forState:UIControlStateNormal];
    UIBarButtonItem *moreButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_moreButton];
//    UIBarButtonItem *moreButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_nav_more"] style:UIBarButtonItemStylePlain target:self action:@selector(clickMoreButton:)];
//    [moreButtonItem setTintColor:[UIColor hexColor:@"3B424C"]];
    self.navigationItem.rightBarButtonItem = moreButtonItem;
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
            [self toOperatingStatus];
        }
    }
}

- (void)toReadingStatus {
    self.isStatusBarNeed2Hide = YES;
    [UIView animateWithDuration:.3 animations:^{
        [self setNeedsStatusBarAppearanceUpdate];
        [_moreButton setBackgroundColor:[UIColor lightGrayColor]];
        
    }];
}

- (void)toOperatingStatus {
    self.isStatusBarNeed2Hide = NO;
    [UIView animateWithDuration:.3 animations:^{
        [self setNeedsStatusBarAppearanceUpdate];
        [_moreButton setBackgroundColor:[UIColor whiteColor]];
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
