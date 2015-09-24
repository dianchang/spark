// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPEntry.h instead.

#import <CoreData/CoreData.h>

extern const struct SPEntryAttributes {
	__unsafe_unretained NSString *content;
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *downvotesCount;
	__unsafe_unretained NSString *upvotesCount;
} SPEntryAttributes;

extern const struct SPEntryRelationships {
	__unsafe_unretained NSString *topics;
	__unsafe_unretained NSString *user;
} SPEntryRelationships;

@class SPTopic;
@class SPUser;

@interface SPEntryID : NSManagedObjectID {}
@end

@interface _SPEntry : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SPEntryID* objectID;

@property (nonatomic, strong) NSString* content;

//- (BOOL)validateContent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* createdAt;

//- (BOOL)validateCreatedAt:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* downvotesCount;

@property (atomic) int32_t downvotesCountValue;
- (int32_t)downvotesCountValue;
- (void)setDownvotesCountValue:(int32_t)value_;

//- (BOOL)validateDownvotesCount:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* upvotesCount;

@property (atomic) int32_t upvotesCountValue;
- (int32_t)upvotesCountValue;
- (void)setUpvotesCountValue:(int32_t)value_;

//- (BOOL)validateUpvotesCount:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *topics;

- (NSMutableSet*)topicsSet;

@property (nonatomic, strong) SPUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;

@end

@interface _SPEntry (TopicsCoreDataGeneratedAccessors)
- (void)addTopics:(NSSet*)value_;
- (void)removeTopics:(NSSet*)value_;
- (void)addTopicsObject:(SPTopic*)value_;
- (void)removeTopicsObject:(SPTopic*)value_;

@end

@interface _SPEntry (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveContent;
- (void)setPrimitiveContent:(NSString*)value;

- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;

- (NSNumber*)primitiveDownvotesCount;
- (void)setPrimitiveDownvotesCount:(NSNumber*)value;

- (int32_t)primitiveDownvotesCountValue;
- (void)setPrimitiveDownvotesCountValue:(int32_t)value_;

- (NSNumber*)primitiveUpvotesCount;
- (void)setPrimitiveUpvotesCount:(NSNumber*)value;

- (int32_t)primitiveUpvotesCountValue;
- (void)setPrimitiveUpvotesCountValue:(int32_t)value_;

- (NSMutableSet*)primitiveTopics;
- (void)setPrimitiveTopics:(NSMutableSet*)value;

- (SPUser*)primitiveUser;
- (void)setPrimitiveUser:(SPUser*)value;

@end
