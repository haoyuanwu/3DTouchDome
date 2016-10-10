//
//  TouchViewController.m
//  HYViewController
//
//  Created by wuhaoyuan on 2016/10/1.
//  Copyright © 2016年 HYViewController. All rights reserved.
//

#import "TouchViewController.h"

@interface TouchViewController ()

@end

@implementation TouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    //动态添加touch按钮
    UIApplicationShortcutItem * item = [[UIApplicationShortcutItem alloc]initWithType:@"two" localizedTitle:@"第二个标签" localizedSubtitle:@"选我" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypePlay] userInfo:@{@"Touch":@"3D"}];
    //添加
    [UIApplication sharedApplication].shortcutItems = @[item];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:image];
    
}

//获取3DTouch按压力度
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSArray *arr = touches.allObjects;
    UITouch *touch = arr.lastObject;
    NSLog(@"%f",touch.force);
}

//上拉的二级菜单
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    
    UIPreviewAction *actionOne = [UIPreviewAction actionWithTitle:@"第一个" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"选择了第一个");
    }];
    
    UIPreviewAction *actionTwo = [UIPreviewAction actionWithTitle:@"第二个" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"选择了第二个");
    }];
    
    UIPreviewAction *actionThree = [UIPreviewAction actionWithTitle:@"第三个" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"选择了第三个");
    }];
    
    return @[actionOne,actionTwo,actionThree];
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
