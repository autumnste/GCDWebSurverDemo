//
//  AppDelegate.h
//  GCDWebServerDemo
//
//  Created by sytz on 2018/12/10.
//  Copyright © 2018年 sytz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

