//
//  AboutViewController.m
//  Fashionistas
//
//  Created by YangYusheng on 12/10/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (strong,nonatomic)UIView *contentView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"About";
    self.scrollView.contentSize = CGSizeMake(320, 1650);
    
    NSArray *tmpViewArray = [[NSBundle mainBundle] loadNibNamed:@"AboutView" owner:self options:nil];
    self.contentView = (UIView *)[tmpViewArray firstObject];
    self.contentView.frame = CGRectMake(0, -70, 240, 1650);
    [self.scrollView addSubview:self.contentView];
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
