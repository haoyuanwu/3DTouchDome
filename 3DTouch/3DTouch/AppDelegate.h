//
//  AppDelegate.h
//  3DTouch
//
//  Created by wuhaoyuan on 2016/10/1.
//  Copyright © 2016年 3DTouch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

