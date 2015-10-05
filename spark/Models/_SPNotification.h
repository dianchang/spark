// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPNotification.h instead.

#import <CoreData/CoreData.h>

extern const struct SPNotificationAttributes {
	__unsafe_unretained NSString *content;
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *createdAtString;
	__unsafe_unretained NSString *unreadNotificationsCount;
} SPNotificationAttributes;

extern const struct SPNotificationRelationships {
	__unsafe_unretained NSString *sender;
} SPNotificationRelationships;

@class SPUser;

@interface SPNotificationID : NSManagedObjectID {}
@end

@interface _SPNotification : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SPNotificationID* objectID;

@property (nonatomic, strong) NSString* content;

//- (BOOL)validateContent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* createdAt;

//- (BOOL)validateCreatedAt:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* createdAtString;

//- (BOOL)validateCreatedAtString:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* unreadNotificationsCount;

@property (atomic) int32_t unreadNotificationsCountValue;
- (int32_t)unreadNotificationsCountValue;
- (void)setUnreadNotificationsCountValue:(int32_t)value_;

//- (BOOL)validateUnreadNotificationsCount:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) SPUser *sender;

//- (BOOL)validateSender:(id*)value_ error:(NSError**)error_;

@end

@interface _SPNotification (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveContent;
- (void)setPrimitiveContent:(NSString*)value;

- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;

- (NSString*)primitiveCreatedAtString;
- (void)setPrimitiveCreatedAtString:(NSString*)value;

- (NSNumber*)primitiveUnreadNotificationsCount;
- (void)setPrimitiveUnreadNotificationsCount:(NSNumber*)value;

- (int32_t)primitiveUnreadNotificationsCountValue;
- (void)setPrimitiveUnreadNotificationsCountValue:(int32_t)value_;

- (SPUser*)primitiveSender;
- (void)setPrimitiveSender:(SPUser*)value;

@end
