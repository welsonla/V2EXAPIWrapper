//
//  V2EXAPIObjectMappings.h
//  V2EX
//
//  Created by Lex on 4/9/12.
//  Copyright (c) 2012 LexTang.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define V2EX_DB_FILE @"V2EX.sqlite"

@class RKManagedObjectMapping;
@class RKManagedObjectStore;

@interface V2EXSiteStats : NSManagedObject
@property (nonatomic, strong) NSString *siteAPI;
@property (nonatomic, strong) NSNumber *topicMax;
@property (nonatomic, strong) NSNumber *memberMax;
@end

@interface V2EXSiteInfo : NSManagedObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *slogan;
@property (nonatomic, strong) NSString *siteDescription;
@property (nonatomic, strong) NSString *domain;
@end

@interface V2EXNode : NSManagedObject
@property (nonatomic, strong) NSNumber *nodeID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nodeURLString;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *titleAlternative;
@property (nonatomic, strong) NSNumber *topicsCount;
@property (nonatomic, strong) NSString *header;
@property (nonatomic, strong) NSString *footer;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) NSArray *topics;
@end

@interface V2EXMember : NSManagedObject
@property (nonatomic, strong) NSNumber *memberID;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *memberURLString;
@property (nonatomic, strong) NSString *website;
@property (nonatomic, strong) NSString *twitter;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *tagline;
@property (nonatomic, strong) NSString *bio;
@property (nonatomic, strong) NSString *avatarMini;
@property (nonatomic, strong) NSString *avatarNormal;
@property (nonatomic, strong) NSString *avatarLarge;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) NSArray *topics;
@property (nonatomic, strong) NSArray *replies;
@end

@interface V2EXTopic : NSManagedObject
@property (nonatomic, strong) NSNumber *topicID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *topicURLString;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *contentRendered;
@property (nonatomic, strong) NSNumber *repliesCount;
@property (nonatomic, assign) V2EXMember *member;
@property (nonatomic, assign) V2EXNode *node;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) NSDate *lastModified;
@property (nonatomic, strong) NSDate *lastTouched;
@property (nonatomic, strong) NSArray *replies;
@end

@interface V2EXReply : NSManagedObject
@property (nonatomic, strong) NSNumber *replyID;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) V2EXMember *member;
@property (nonatomic, strong) NSDate *created;
@property (nonatomic, strong) NSDate *lastModified;
@property (nonatomic, assign) V2EXTopic *topic;
@end

@interface V2EXAPIObjectMappings : NSObject
{
  __strong RKManagedObjectMapping *_siteStatsMapping;
  __strong RKManagedObjectMapping *_siteInfoMapping;
  __strong RKManagedObjectMapping *_topicMapping;
  __strong RKManagedObjectMapping *_nodeMapping;
  __strong RKManagedObjectMapping *_memberMapping;
  __strong RKManagedObjectMapping *_replyMapping;
}

+ (id)shared;
+ (RKManagedObjectStore*)objectStore;

- (RKManagedObjectMapping*)siteStatsMapping;
- (RKManagedObjectMapping*)siteInfoMapping;
- (RKManagedObjectMapping*)topicMapping;
- (RKManagedObjectMapping*)nodeMapping;
- (RKManagedObjectMapping*)memberMapping;
- (RKManagedObjectMapping*)replyMapping;

@end
