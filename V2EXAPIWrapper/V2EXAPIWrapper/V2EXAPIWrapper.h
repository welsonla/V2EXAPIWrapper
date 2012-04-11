//
//  V2EXAPIWrapper.h
//  V2EX
//
//  Created by Lex on 4/9/12.
//  Copyright (c) 2012 LexTang.com. All rights reserved.
//

#import "V2EXAPIObjectMappings.h"

#if NS_BLOCKS_AVAILABLE
#ifndef V2EX_API_BLOCK
#define V2EX_API_BLOCK
typedef void (^V2EXSiteStatsHandler)(NSError *error, V2EXSiteStats *stats);
typedef void (^V2EXSiteInfoHandler)(NSError *error, V2EXSiteInfo *info);
typedef void (^V2EXNodesHander)(NSError *error, NSArray *nodes);
typedef void (^V2EXNodeHander)(NSError *error, V2EXNode *node);
typedef void (^V2EXTopicsHandler)(NSError *error, NSArray *topics);
typedef void (^V2EXTopicHandler)(NSError *error, V2EXTopic *topic);
typedef void (^V2EXRepliesHandler)(NSError *error, NSArray *replies);
typedef void (^V2EXMemberHandler)(NSError *error, V2EXMember *member);
#endif
#endif

@interface V2EXAPIWrapper : NSObject

#if NS_BLOCKS_AVAILABLE
+ (id)shared;

- (void)loadSiteStats:(V2EXSiteStatsHandler)statsHandler; 
- (void)loadSiteInfo:(V2EXSiteInfoHandler)infoHandler;
- (void)loadNodes:(V2EXNodesHander)nodesHandler;
- (void)loadNodeByID:(uint)ID handler:(V2EXNodeHander)nodeHandler;
- (void)loadLatestTopics:(V2EXTopicsHandler)topicsHandler;
- (void)loadTopicByID:(uint)ID handler:(V2EXTopicHandler)topicHandler;
- (void)loadTopicsByUsername:(NSString*)username handler:(V2EXTopicsHandler)topicsHandler;
- (void)loadTopicsByNodeID:(uint)ID handler:(V2EXTopicsHandler)topicsHandler;
- (void)loadRepliesByTopicID:(uint)ID handler:(V2EXRepliesHandler)repliesHandler;
- (void)loadMemberByUsername:(NSString*)username handler:(V2EXMemberHandler)memberHandler;
#endif

@end
