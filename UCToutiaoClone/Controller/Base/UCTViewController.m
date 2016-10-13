//
//  UCTViewController.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/10/12.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTViewController.h"
#import "UIColor+hexColor.h"

@interface UCTViewController ()
@end

@implementation UCTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self configureNavigationBar];
}

- (void)configureNavigationBar {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackButton:)];
    [backButton setTintColor:[UIColor hexColor:@"3B424C"]];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)clickBackButton:(id)sender {
    if ([self.navigationController.childViewControllers count] <= 1) {
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
