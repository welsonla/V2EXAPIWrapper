//
//  V2EXAPIObjectMappings.m
//  V2EX
//
//  Created by Lex on 4/9/12.
//  Copyright (c) 2012 LexTang.com. All rights reserved.
//

#import "V2EXAPIObjectMappings.h"
#import <RestKit/RestKit.h>
#import "RKJSONParserJSONKit.h"

@implementation V2EXTopic
@dynamic topicID, title, topicURLString, content, contentRendered, repliesCount, member, node, created, lastModified, lastTouched, replies;
@end

@implementation V2EXSiteStats
@dynamic siteAPI, topicMax, memberMax;
@end

@implementation V2EXSiteInfo
@dynamic title, slogan, siteDescription, domain;
@end

@implementation V2EXNode
@dynamic nodeID, name, nodeURLString, title, titleAlternative, topicsCount, header, footer, created, topics;
@end

@implementation V2EXMember
@dynamic memberID, username, memberURLString, website, twitter, location, tagline, bio, avatarMini, avatarNormal, avatarLarge, created, replies, topics;
@end

@implementation V2EXReply
@dynamic replyID, content, member, topic, created, lastModified;
@end

@implementation V2EXAPIObjectMappings

+(id)shared
{
  __strong static id _sharedObject = nil;
  static dispatch_once_t sharedToken;
  dispatch_once(&sharedToken, ^{
    _sharedObject = [[self alloc] init];
    [[RKParserRegistry sharedRegistry] setParserClass:[RKJSONParserJSONKit class] forMIMEType:RKMIMETypeJSON];
    NSDateFormatter *defaultFormatter = [[NSDateFormatter alloc] init];
    defaultFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    defaultFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSSSSS";
    [RKManagedObjectMapping setDefaultDateFormatters:[NSArray arrayWithObject:defaultFormatter]];
  });
  return _sharedObject;
}

+(RKManagedObjectStore*)objectStore
{
  __strong static RKManagedObjectStore* _objectStore;
  static dispatch_once_t objectStoreToken;
  dispatch_once(&objectStoreToken, ^{
    _objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:V2EX_DB_FILE];
  });
  return _objectStore;
}

- (RKManagedObjectMapping*)siteStatsMapping
{
  if (_siteStatsMapping == nil)
  {
    _siteStatsMapping = [RKManagedObjectMapping mappingForClass:[V2EXSiteStats class]
                                           inManagedObjectStore:[V2EXAPIObjectMappings objectStore]];
    [_siteStatsMapping mapKeyPath:@"topic_max" toAttribute:@"topicMax"];
    [_siteStatsMapping mapKeyPath:@"member_max" toAttribute:@"memberMax"];
    
    _siteStatsMapping.primaryKeyAttribute = @"siteAPI";
  }
  return _siteStatsMapping;
}

- (RKManagedObjectMapping*)siteInfoMapping
{
  if (_siteInfoMapping == nil)
  {
    _siteInfoMapping = [RKManagedObjectMapping mappingForClass:[V2EXSiteInfo class]
                                          inManagedObjectStore:[V2EXAPIObjectMappings objectStore]];
    [_siteInfoMapping mapKeyPath:@"title" toAttribute:@"title"];
    [_siteInfoMapping mapKeyPath:@"slogan" toAttribute:@"slogan"];
    [_siteInfoMapping mapKeyPath:@"description" toAttribute:@"siteDescription"];
    [_siteInfoMapping mapKeyPath:@"domain" toAttribute:@"domain"];
    
    _siteInfoMapping.primaryKeyAttribute = @"domain";
  }
  return _siteInfoMapping;
}

- (RKManagedObjectMapping*)topicMapping
{
  if (_topicMapping == nil)
  {
    _topicMapping = [RKManagedObjectMapping mappingForClass:[V2EXTopic class]
                                       inManagedObjectStore:[V2EXAPIObjectMappings objectStore]];
    [_topicMapping mapKeyPath:@"id" toAttribute:@"topicID"];
    [_topicMapping mapKeyPath:@"title" toAttribute:@"title"];
    [_topicMapping mapKeyPath:@"url" toAttribute:@"topicURLString"];
    [_topicMapping mapKeyPath:@"content" toAttribute:@"content"];
    [_topicMapping mapKeyPath:@"content_rendered" toAttribute:@"contentRendered"];
    [_topicMapping mapKeyPath:@"replies" toAttribute:@"repliesCount"];
    [_topicMapping mapKeyPath:@"created" toAttribute:@"created"];
    [_topicMapping mapKeyPath:@"last_modified" toAttribute:@"lastModified"];
    [_topicMapping mapKeyPath:@"last_touched" toAttribute:@"lastTouched"];
    
    [_topicMapping mapKeyPath:@"member" toRelationship:@"member" withMapping:[self memberMapping]];
    [_topicMapping mapKeyPath:@"node" toRelationship:@"node" withMapping:[self nodeMapping]];
    
    _topicMapping.primaryKeyAttribute = @"topicID";
  }
  return _topicMapping;
}

- (RKManagedObjectMapping*)nodeMapping
{
  if (_nodeMapping == nil)
  {
    _nodeMapping = [RKManagedObjectMapping mappingForClass:[V2EXNode class]
                                      inManagedObjectStore:[V2EXAPIObjectMappings objectStore]];
    [_nodeMapping mapKeyPath:@"id" toAttribute:@"nodeID"];
    [_nodeMapping mapKeyPath:@"name" toAttribute:@"name"];
    [_nodeMapping mapKeyPath:@"url" toAttribute:@"nodeURLString"];
    [_nodeMapping mapKeyPath:@"title" toAttribute:@"title"];
    [_nodeMapping mapKeyPath:@"title_alternative" toAttribute:@"titleAlternative"];
    [_nodeMapping mapKeyPath:@"topics" toAttribute:@"topicsCount"];
    [_nodeMapping mapKeyPath:@"header" toAttribute:@"header"];
    [_nodeMapping mapKeyPath:@"footer" toAttribute:@"footer"];
    [_nodeMapping mapKeyPath:@"created" toAttribute:@"created"];
    _nodeMapping.primaryKeyAttribute = @"nodeID";
  }
  return _nodeMapping;
}

- (RKManagedObjectMapping*)memberMapping
{
  if (_memberMapping == nil)
  {
    _memberMapping = [RKManagedObjectMapping mappingForClass:[V2EXMember class]
                                        inManagedObjectStore:[V2EXAPIObjectMappings objectStore]];
    [_memberMapping mapKeyPath:@"id" toAttribute:@"memberID"];
    [_memberMapping mapKeyPath:@"username" toAttribute:@"username"];
    [_memberMapping mapKeyPath:@"url" toAttribute:@"memberURLString"];
    [_memberMapping mapKeyPath:@"website" toAttribute:@"website"];
    [_memberMapping mapKeyPath:@"twitter" toAttribute:@"twitter"];
    [_memberMapping mapKeyPath:@"location" toAttribute:@"location"];
    [_memberMapping mapKeyPath:@"tagline" toAttribute:@"tagline"];
    [_memberMapping mapKeyPath:@"avatar_mini" toAttribute:@"avatarMini"];
    [_memberMapping mapKeyPath:@"avatar_normal" toAttribute:@"avatarNormal"];
    [_memberMapping mapKeyPath:@"avatar_large" toAttribute:@"avatarLarge"];
    [_memberMapping mapKeyPath:@"created" toAttribute:@"created"];
    _memberMapping.primaryKeyAttribute = @"memberID";
  }
  return _memberMapping;
}

- (RKManagedObjectMapping*)replyMapping
{
  if (_replyMapping == nil)
  {
    _replyMapping = [RKManagedObjectMapping mappingForClass:[V2EXReply class]
                                       inManagedObjectStore:[V2EXAPIObjectMappings objectStore]];
    [_replyMapping mapKeyPath:@"id" toAttribute:@"replyID"];
    [_replyMapping mapKeyPath:@"content" toAttribute:@"content"];
//    [_replyMapping mapKeyPath:@"created" toAttribute:@"created"];
//    [_replyMapping mapKeyPath:@"last_modified" toAttribute:@"lastModified"];
//    
//    [_replyMapping mapKeyPath:@"member" toRelationship:@"member" withMapping:[self memberMapping]];
//    [_replyMapping mapKeyPath:@"topic" toRelationship:@"topic" withMapping:[self topicMapping]];
    _replyMapping.primaryKeyAttribute = @"replyID";
  }
  return _replyMapping;
}

@end