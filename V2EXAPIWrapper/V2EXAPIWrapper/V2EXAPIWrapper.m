//
//  V2EXAPIWrapper.m
//  V2EX
//
//  Created by Lex on 4/9/12.
//  Copyright (c) 2012 LexTang.com. All rights reserved.
//

#import "V2EXAPIWrapper.h"
#import <RestKit/RestKit.h>

@interface V2EXAPIWrapper(Private)<RKRequestDelegate>

@end

@implementation V2EXAPIWrapper

static NSString *API_BASE_URL_STRING = @"http://www.v2ex.com/api";
static RKObjectManager *_manager;

+(id)shared
{
  __strong static id _sharedObject = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedObject = [[self alloc] init];
    _manager = [RKObjectManager managerWithBaseURLString:API_BASE_URL_STRING];
    _manager.client.cachePolicy = RKRequestCachePolicyLoadIfOffline | RKRequestCachePolicyLoadOnError |
                                  RKRequestCachePolicyTimeout | RKRequestCachePolicyEtag |
                                  RKRequestCachePolicyEnabled;
    _manager.client.requestCache.storagePolicy = RKRequestCacheStoragePolicyPermanently;
    _manager.objectStore = [V2EXAPIObjectMappings objectStore];
  });
  return _sharedObject;
}

- (void)loadSiteStats:(V2EXSiteStatsHandler)statsHandler
{
  [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/site/stats.json" usingBlock:^(RKObjectLoader* loader) {
    loader.objectMapping = [[V2EXAPIObjectMappings shared] siteStatsMapping];
    loader.onDidLoadObject = ^(V2EXSiteStats *result){
      result.siteAPI = API_BASE_URL_STRING;
      statsHandler(nil, result);
    };
    loader.onDidFailLoadWithError = ^(NSError *error){
      statsHandler(error, nil);
    };
  }];
}

- (void)loadSiteInfo:(V2EXSiteInfoHandler)infoHandler
{
  [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/site/info.json" usingBlock:^(RKObjectLoader* loader) {
    loader.objectMapping = [[V2EXAPIObjectMappings shared] siteInfoMapping];
    loader.onDidLoadObject = ^(id result){
      infoHandler(nil, result);
    };
    loader.onDidFailLoadWithError = ^(NSError *error){
      infoHandler(error, nil);
    };
  }];
}

- (void)loadNodes:(V2EXNodesHander)nodesHandler
{
  [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/nodes/all.json" usingBlock:^(RKObjectLoader* loader) {
    loader.objectMapping = [[V2EXAPIObjectMappings shared] nodeMapping];
    loader.onDidLoadObjects = ^(NSArray *results){
      nodesHandler(nil, results);
    };
    loader.onDidFailLoadWithError = ^(NSError *error){
      nodesHandler(error, nil);
    };
  }];
}

- (void)loadNodeByID:(uint)ID handler:(V2EXNodeHander)nodeHandler
{
  NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:ID], @"id", nil];
  NSString *path = [@"/nodes/show.json" stringByAppendingQueryParameters:params];
  [[RKObjectManager sharedManager] loadObjectsAtResourcePath:path usingBlock:^(RKObjectLoader* loader) {
    loader.objectMapping = [[V2EXAPIObjectMappings shared] nodeMapping];
    loader.onDidLoadObject = ^(id result){
      nodeHandler(nil, result);
    };
    loader.onDidFailLoadWithError = ^(NSError *error){
      nodeHandler(error, nil);
    };
  }];
}

- (void)loadNodeByName:(NSString*)nodeName handler:(V2EXNodeHander)nodeHandler
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:nodeName, @"name", nil];
    NSString *path = [@"/nodes/show.json" stringByAppendingQueryParameters:params];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:path usingBlock:^(RKObjectLoader* loader) {
        loader.objectMapping = [[V2EXAPIObjectMappings shared] nodeMapping];
        loader.onDidLoadObject = ^(id result){
            nodeHandler(nil, result);
        };
        loader.onDidFailLoadWithError = ^(NSError *error){
            nodeHandler(error, nil);
        };
    }];
}

- (void)loadLatestTopics:(V2EXTopicsHandler)topicsHandler
{
  [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/topics/latest.json" usingBlock:^(RKObjectLoader* loader) {
    loader.objectMapping = [[V2EXAPIObjectMappings shared] topicMapping];
    loader.onDidLoadObjects = ^(NSArray *results){
      topicsHandler(nil, results);
    };
    loader.onDidFailLoadWithError = ^(NSError *error){
      topicsHandler(error, nil);
    };
  }];
}

- (void)loadTopicByID:(uint)ID handler:(V2EXTopicHandler)topicHandler
{
  NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:ID], @"id", nil];
  NSString *path = [@"/topics/show.json" stringByAppendingQueryParameters:params];
  [[RKObjectManager sharedManager] loadObjectsAtResourcePath:path usingBlock:^(RKObjectLoader* loader) {
    loader.objectMapping = [[V2EXAPIObjectMappings shared] topicMapping];
    loader.onDidLoadObject = ^(id result){
      topicHandler(nil, result);
    };
    loader.onDidFailLoadWithError = ^(NSError *error){
      topicHandler(error, nil);
    };
  }];
}

- (void)loadTopicsByUsername:(NSString*)username handler:(V2EXTopicsHandler)topicsHandler
{
  NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:username, @"username", nil];
  NSString *path = [@"/topics/show.json" stringByAppendingQueryParameters:params];
  [[RKObjectManager sharedManager] loadObjectsAtResourcePath:path usingBlock:^(RKObjectLoader* loader) {
    loader.objectMapping = [[V2EXAPIObjectMappings shared] topicMapping];
    loader.onDidLoadObjects = ^(NSArray *results){
      topicsHandler(nil, results);
    };
    loader.onDidFailLoadWithError = ^(NSError *error){
      topicsHandler(error, nil);
    };
  }];
}

- (void)loadTopicsByNodeID:(uint)ID handler:(V2EXTopicsHandler)topicsHandler
{
  NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:ID], @"node_id", nil];
  NSString *path = [@"/topics/show.json" stringByAppendingQueryParameters:params];
  [[RKObjectManager sharedManager] loadObjectsAtResourcePath:path usingBlock:^(RKObjectLoader* loader) {
    loader.objectMapping = [[V2EXAPIObjectMappings shared] topicMapping];
    loader.onDidLoadObjects = ^(NSArray *results){
      topicsHandler(nil, results);
    };
    loader.onDidFailLoadWithError = ^(NSError *error){
      topicsHandler(error, nil);
    };
  }];
}

- (void)loadRepliesByTopicID:(uint)ID handler:(V2EXRepliesHandler)repliesHandler
{
  NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:ID], @"topic_id", nil];
  NSString *path = [@"/replies/show.json" stringByAppendingQueryParameters:params];
  [[RKObjectManager sharedManager] loadObjectsAtResourcePath:path usingBlock:^(RKObjectLoader* loader) {
    loader.objectMapping = [[V2EXAPIObjectMappings shared] replyMapping];
    loader.onDidLoadObjects = ^(NSArray *results){
      repliesHandler(nil, results);
    };
    loader.onDidFailLoadWithError = ^(NSError *error){
      repliesHandler(error, nil);
    };
  }];
}

- (void)loadMemberByUsername:(NSString*)username handler:(V2EXMemberHandler)memberHandler
{
  NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:username, @"username", nil];
  NSString *path = [@"/members/show.json" stringByAppendingQueryParameters:params];
  [[RKObjectManager sharedManager] loadObjectsAtResourcePath:path usingBlock:^(RKObjectLoader* loader) {
    loader.objectMapping = [[V2EXAPIObjectMappings shared] memberMapping];
    loader.onDidLoadObject = ^(id result){
      memberHandler(nil, result);
    };
    loader.onDidFailLoadWithError = ^(NSError *error){
      memberHandler(error, nil);
    };
  }];
}

@end
