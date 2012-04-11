//
//  AppDelegate.m
//  V2EXAPIWrapper
//
//  Created by Tang Lex on 4/11/12.
//  Copyright (c) 2012 LexTang.com. All rights reserved.
//

#import "AppDelegate.h"
#import "V2EXAPIWrapper.h"
#import "RKLog.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    RKLogConfigureByName("RestKit/*", RKLogLevelOff);
    
    [[V2EXAPIWrapper shared] loadSiteInfo:^(NSError *error, V2EXSiteInfo *info) {
        NSLog(@"Site: %@, slogan: %@", info.title, info.slogan);
    }];
    
    [[V2EXAPIWrapper shared] loadSiteStats:^(NSError *error, V2EXSiteStats *stats) {
        NSLog(@"Members: %i, Topics: %i", stats.memberMax.intValue, stats.topicMax.intValue);
    }];
    
    [[V2EXAPIWrapper shared] loadNodes:^(NSError *error, NSArray *nodes) {
        NSMutableArray *nodesArray = [NSMutableArray array];
        for (V2EXNode *node in nodes) {
            [nodesArray addObject:node.title];
        }
        NSLog(@"Nodes: %@", [nodesArray componentsJoinedByString:@","]);
    }];
    
    [[V2EXAPIWrapper shared] loadNodeByID:1 handler:^(NSError *error, V2EXNode *node) {
        NSLog(@"Node: %@", node.title);
        [[V2EXAPIWrapper shared] loadTopicsByNodeID:node.nodeID.intValue handler:^(NSError *error2, NSArray *topics) {
            NSMutableArray *topicsArray = [NSMutableArray array];
            for (V2EXTopic *topic in topics) {
                [topicsArray addObject:topic.title];
            }
            NSLog(@"Topics in %@: %@", node.title, [topicsArray componentsJoinedByString:@","]);
        }];
    }];
    
    [[V2EXAPIWrapper shared] loadTopicByID:1 handler:^(NSError *error, V2EXTopic *topic) {
        NSLog(@"Topic: %@ by @%@ on %@", topic.title, topic.member.username, topic.created);
        
    }];
    
    [[V2EXAPIWrapper shared] loadMemberByUsername:@"Lex" handler:^(NSError *error, V2EXMember *member) {
        NSLog(@"Member: %@(%@)", member.username, member.memberURLString);
    }];
    
    //  [[V2EXAPIWrapper shared] loadRepliesByTopicID:1 handler:^(NSError *error, NSArray *replies) {
    //    NSMutableArray *repliesArray = [NSMutableArray array];
    //    for (V2EXNode *reply in replies) {
    //      [repliesArray addObject:reply.title];
    //    }
    //    NSLog(@"Replies: %@", [repliesArray componentsJoinedByString:@","]);
    //  }];
    
    self.window.rootViewController = [[UITableViewController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
