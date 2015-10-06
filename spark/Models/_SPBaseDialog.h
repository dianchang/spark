// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPBaseDialog.h instead.

#import <CoreData/CoreData.h>

extern const struct SPBaseDialogAttributes {
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *createdAtString;
	__unsafe_unretained NSString *unreadMessagesCount;
} SPBaseDialogAttributes;

extern const struct SPBaseDialogRelationships {
	__unsafe_unretained NSString *messages;
} SPBaseDialogRelationships;

@class SPMessage;

@interface SPBaseDialogID : NSManagedObjectID {}
@end

@interface _SPBaseDialog : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SPBaseDialogID* objectID;

@property (nonatomic, strong) NSDate* createdAt;

//- (BOOL)validateCreatedAt:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* createdAtString;

//- (BOOL)validateCreatedAtString:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* unreadMessagesCount;

@property (atomic) int32_t unreadMessagesCountValue;
- (int32_t)unreadMessagesCountValue;
- (void)setUnreadMessagesCountValue:(int32_t)value_;

//- (BOOL)validateUnreadMessagesCount:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *messages;

- (NSMutableSet*)messagesSet;

@end

@interface _SPBaseDialog (MessagesCoreDataGeneratedAccessors)
- (void)addMessages:(NSSet*)value_;
- (void)removeMessages:(NSSet*)value_;
- (void)addMessagesObject:(SPMessage*)value_;
- (void)removeMessagesObject:(SPMessage*)value_;

@end

@interface _SPBaseDialog (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;

- (NSString*)primitiveCreatedAtString;
- (void)setPrimitiveCreatedAtString:(NSString*)value;

- (NSNumber*)primitiveUnreadMessagesCount;
- (void)setPrimitiveUnreadMessagesCount:(NSNumber*)value;

- (int32_t)primitiveUnreadMessagesCountValue;
- (void)setPrimitiveUnreadMessagesCountValue:(int32_t)value_;

- (NSMutableSet*)primitiveMessages;
- (void)setPrimitiveMessages:(NSMutableSet*)value;

@end
