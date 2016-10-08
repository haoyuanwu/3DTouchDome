//
//  ViewController.m
//  3DTouch
//
//  Created by wuhaoyuan on 2016/10/1.
//  Copyright © 2016年 3DTouch. All rights reserved.
//

#import "ViewController.h"
#import "TouchViewController.h"

@interface HeaderView : UIView

@end

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

@end

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate>
{
    NSIndexPath *_indexPath;
}
@property (nonatomic,strong) UITableView *tabelView;
@property (nonatomic,strong) HeaderView *headerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchPush) name:@"push" object:nil];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"push"]) {
        [self touchPush];
    }
    
    [self.view addSubview:self.tabelView];
}

- (void)touchPush{
    TouchViewController *touchView = [[TouchViewController alloc] init];
    [self.navigationController pushViewController:touchView animated:YES];
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
        _headerView.backgroundColor = [UIColor grayColor];
    }
    return _headerView;
}

- (UITableView *)tabelView{
    if (!_tabelView) {
        _tabelView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tabelView.backgroundColor = [UIColor whiteColor];
        _tabelView.tableHeaderView = self.headerView;
        _tabelView.delegate = self;
        _tabelView.dataSource = self;
        [_tabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    }
    return _tabelView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    
    cell.textLabel.text = @"按我";
    
    if ([self respondsToSelector:@selector(traitCollection)]) {
        if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
            if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
                [self registerForPreviewingWithDelegate:self sourceView:cell];
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TouchViewController *touchView = [[TouchViewController alloc] init];
    [self.navigationController pushViewController:touchView animated:YES];
}

//在刚刚触摸到cell时就调用
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _indexPath = indexPath;
    return YES;
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    UIView *view = previewingContext.sourceView;
    
    TouchViewController *touchView = [[TouchViewController alloc] init];
    touchView.preferredContentSize = CGSizeMake(0, 500);
    
    //获取cell在页面的位置
//    CGRect rectInTableView = [self.tabelView rectForRowAtIndexPath:_indexPath];
//    CGRect rect = [self.tabelView convertRect:rectInTableView toView:[self.tabelView superview]];
    //按压中的视图位置
    previewingContext.sourceRect = CGRectMake(0, 0, self.view.frame.size.width, view.frame.size.height);
    
    return touchView;
}

//处于touch状态时再次按压调用
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    TouchViewController *touchView = [[TouchViewController alloc] init];
    [self.navigationController pushViewController:touchView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
