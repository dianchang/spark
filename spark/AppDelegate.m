//
//  AppDelegate.m
//  spark
//
//  Created by hustlzp on 15/9/24.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "AppDelegate.h"
#import "MeetViewController.h"
#import "BestViewController.h"
#import "MessageViewController.h"
#import "MyProfileViewController.h"
#import "UIColor+Helper.h"
#import "Seed.h"
#import "Constants.h"
#import <Fabric/Fabric.h>
#import <MagicalRecord/MagicalRecord.h>
#import <Crashlytics/Crashlytics.h>
#import <ionicons/IonIcons.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"Application Support Directory:\n\n%@\n\n", [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) firstObject]);
    
    [Fabric with:@[[Crashlytics class]]];
    
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"spark"];

    // 填充数据
    [Seed truncateAllData];
    [Seed seedData];
    
    // 首页
    UIViewController *meetViewController = [MeetViewController new];
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:meetViewController];
    UIImage *meetImage = [IonIcons imageWithIcon:ion_android_home size:30 color:[UIColor SPColorLightMain]];
    UIImage *meetSelecedImage = [IonIcons imageWithIcon:ion_android_home size:30 color:[UIColor SPColorMain]];
    firstNav.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    firstNav.tabBarItem.image = meetImage;
    firstNav.tabBarItem.selectedImage = meetSelecedImage;

    // 今日最佳
    UIViewController *bestViewController = [BestViewController new];
    UINavigationController *secondNav = [[UINavigationController alloc] initWithRootViewController:bestViewController];
    UIImage *bestImage = [IonIcons imageWithIcon:ion_android_compass size:26 color:[UIColor SPColorLightMain]];
    UIImage *bestSelecedImage = [IonIcons imageWithIcon:ion_android_compass size:26 color:[UIColor SPColorMain]];
    secondNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    secondNav.tabBarItem.image = bestImage;
    secondNav.tabBarItem.selectedImage = bestSelecedImage;
    
    // 消息 & 通知
    UIViewController *messageViewController = [MessageViewController new];
    UINavigationController *thirdNav = [[UINavigationController alloc] initWithRootViewController:messageViewController];
    UIImage *messageImage = [IonIcons imageWithIcon:ion_chatbubble_working size:28 color:[UIColor SPColorLightMain]];
    UIImage *messageSelecedImage = [IonIcons imageWithIcon:ion_chatbubble_working size:28 color:[UIColor SPColorMain]];
    thirdNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    thirdNav.tabBarItem.image = messageImage;
    thirdNav.tabBarItem.selectedImage = messageSelecedImage;
    
    // 个人设置
    UIViewController *myProfileViewController = [MyProfileViewController new];
    UINavigationController *forthNav = [[UINavigationController alloc] initWithRootViewController:myProfileViewController];
    UIImage *profileImage = [IonIcons imageWithIcon:ion_person size:30 color:[UIColor SPColorLightMain]];
    UIImage *profileSelecedImage = [IonIcons imageWithIcon:ion_person size:30 color:[UIColor SPColorMain]];
    forthNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    forthNav.tabBarItem.image = profileImage;
    forthNav.tabBarItem.selectedImage = profileSelecedImage;
    
    // TabBar Controller
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    self.tabBarController = tabBarController;
    tabBarController.viewControllers = @[firstNav, secondNav, thirdNav, forthNav];
    
    // Root Controller
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];    
    [self.window setRootViewController:tabBarController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [[UINavigationBar appearance] setTitleTextAttributes: @{NSFontAttributeName: [UIFont fontWithName:SPLanTingFontName size:17.0f]}];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.hustlzp.spark" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"spark" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"spark.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
