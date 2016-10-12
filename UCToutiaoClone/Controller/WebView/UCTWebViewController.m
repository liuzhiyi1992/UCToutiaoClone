//
//  UCTWebViewController.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/10/12.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTWebViewController.h"
#import "Masonry.h"

@interface UCTWebViewController () <UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *mainWebView;
@property (copy, nonatomic) NSString *requestUrlString;
@end

@implementation UCTWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadRequest];
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

- (void)configureWebView {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIWebView *)mainWebView {
    if (!_mainWebView) {
        _mainWebView = [[UIWebView alloc] init];
        _mainWebView.delegate = self;
        [self.view addSubview:_mainWebView];
        [_mainWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _mainWebView;
}
@end
