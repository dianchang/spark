// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPUser.h instead.

#import <CoreData/CoreData.h>

extern const struct SPUserAttributes {
	__unsafe_unretained NSString *avatarUrl;
	__unsafe_unretained NSString *desc;
	__unsafe_unretained NSString *entriesCount;
	__unsafe_unretained NSString *followedTopicsCount;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *upvotesCount;
} SPUserAttributes;

extern const struct SPUserRelationships {
	__unsafe_unretained NSString *dialogs;
	__unsafe_unretained NSString *entries;
	__unsafe_unretained NSString *sendedMessages;
	__unsafe_unretained NSString *sendedNotifications;
} SPUserRelationships;

@class SPDialog;
@class SPEntry;
@class SPMessage;
@class SPNotification;

@interface SPUserID : NSManagedObjectID {}
@end

@interface _SPUser : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SPUserID* objectID;

@property (nonatomic, strong) NSString* avatarUrl;

//- (BOOL)validateAvatarUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* desc;

//- (BOOL)validateDesc:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* entriesCount;

@property (atomic) int32_t entriesCountValue;
- (int32_t)entriesCountValue;
- (void)setEntriesCountValue:(int32_t)value_;

//- (BOOL)validateEntriesCount:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* followedTopicsCount;

@property (atomic) int32_t followedTopicsCountValue;
- (int32_t)followedTopicsCountValue;
- (void)setFollowedTopicsCountValue:(int32_t)value_;

//- (BOOL)validateFollowedTopicsCount:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* upvotesCount;

@property (atomic) int32_t upvotesCountValue;
- (int32_t)upvotesCountValue;
- (void)setUpvotesCountValue:(int32_t)value_;

//- (BOOL)validateUpvotesCount:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *dialogs;

- (NSMutableSet*)dialogsSet;

@property (nonatomic, strong) NSSet *entries;

- (NSMutableSet*)entriesSet;

@property (nonatomic, strong) NSSet *sendedMessages;

- (NSMutableSet*)sendedMessagesSet;

@property (nonatomic, strong) NSSet *sendedNotifications;

- (NSMutableSet*)sendedNotificationsSet;

@end

@interface _SPUser (DialogsCoreDataGeneratedAccessors)
- (void)addDialogs:(NSSet*)value_;
- (void)removeDialogs:(NSSet*)value_;
- (void)addDialogsObject:(SPDialog*)value_;
- (void)removeDialogsObject:(SPDialog*)value_;

@end

@interface _SPUser (EntriesCoreDataGeneratedAccessors)
- (void)addEntries:(NSSet*)value_;
- (void)removeEntries:(NSSet*)value_;
- (void)addEntriesObject:(SPEntry*)value_;
- (void)removeEntriesObject:(SPEntry*)value_;

@end

@interface _SPUser (SendedMessagesCoreDataGeneratedAccessors)
- (void)addSendedMessages:(NSSet*)value_;
- (void)removeSendedMessages:(NSSet*)value_;
- (void)addSendedMessagesObject:(SPMessage*)value_;
- (void)removeSendedMessagesObject:(SPMessage*)value_;

@end

@interface _SPUser (SendedNotificationsCoreDataGeneratedAccessors)
- (void)addSendedNotifications:(NSSet*)value_;
- (void)removeSendedNotifications:(NSSet*)value_;
- (void)addSendedNotificationsObject:(SPNotification*)value_;
- (void)removeSendedNotificationsObject:(SPNotification*)value_;

@end

@interface _SPUser (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAvatarUrl;
- (void)setPrimitiveAvatarUrl:(NSString*)value;

- (NSString*)primitiveDesc;
- (void)setPrimitiveDesc:(NSString*)value;

- (NSNumber*)primitiveEntriesCount;
- (void)setPrimitiveEntriesCount:(NSNumber*)value;

- (int32_t)primitiveEntriesCountValue;
- (void)setPrimitiveEntriesCountValue:(int32_t)value_;

- (NSNumber*)primitiveFollowedTopicsCount;
- (void)setPrimitiveFollowedTopicsCount:(NSNumber*)value;

- (int32_t)primitiveFollowedTopicsCountValue;
- (void)setPrimitiveFollowedTopicsCountValue:(int32_t)value_;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSNumber*)primitiveUpvotesCount;
- (void)setPrimitiveUpvotesCount:(NSNumber*)value;

- (int32_t)primitiveUpvotesCountValue;
- (void)setPrimitiveUpvotesCountValue:(int32_t)value_;

- (NSMutableSet*)primitiveDialogs;
- (void)setPrimitiveDialogs:(NSMutableSet*)value;

- (NSMutableSet*)primitiveEntries;
- (void)setPrimitiveEntries:(NSMutableSet*)value;

- (NSMutableSet*)primitiveSendedMessages;
- (void)setPrimitiveSendedMessages:(NSMutableSet*)value;

- (NSMutableSet*)primitiveSendedNotifications;
- (void)setPrimitiveSendedNotifications:(NSMutableSet*)value;

@end
