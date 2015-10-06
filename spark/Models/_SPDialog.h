// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPDialog.h instead.

#import <CoreData/CoreData.h>

extern const struct SPDialogAttributes {
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *unreadMessagesCount;
} SPDialogAttributes;

extern const struct SPDialogRelationships {
	__unsafe_unretained NSString *messages;
	__unsafe_unretained NSString *sender;
} SPDialogRelationships;

@class SPMessage;
@class SPUser;

@interface SPDialogID : NSManagedObjectID {}
@end

@interface _SPDialog : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SPDialogID* objectID;

@property (nonatomic, strong) NSDate* createdAt;

//- (BOOL)validateCreatedAt:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* unreadMessagesCount;

@property (atomic) int32_t unreadMessagesCountValue;
- (int32_t)unreadMessagesCountValue;
- (void)setUnreadMessagesCountValue:(int32_t)value_;

//- (BOOL)validateUnreadMessagesCount:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *messages;

- (NSMutableSet*)messagesSet;

@property (nonatomic, strong) SPUser *sender;

//- (BOOL)validateSender:(id*)value_ error:(NSError**)error_;

@end

@interface _SPDialog (MessagesCoreDataGeneratedAccessors)
- (void)addMessages:(NSSet*)value_;
- (void)removeMessages:(NSSet*)value_;
- (void)addMessagesObject:(SPMessage*)value_;
- (void)removeMessagesObject:(SPMessage*)value_;

@end

@interface _SPDialog (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;

- (NSNumber*)primitiveUnreadMessagesCount;
- (void)setPrimitiveUnreadMessagesCount:(NSNumber*)value;

- (int32_t)primitiveUnreadMessagesCountValue;
- (void)setPrimitiveUnreadMessagesCountValue:(int32_t)value_;

- (NSMutableSet*)primitiveMessages;
- (void)setPrimitiveMessages:(NSMutableSet*)value;

- (SPUser*)primitiveSender;
- (void)setPrimitiveSender:(SPUser*)value;

@end
