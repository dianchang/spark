// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPNotification.h instead.

#import <CoreData/CoreData.h>

extern const struct SPNotificationAttributes {
	__unsafe_unretained NSString *content;
	__unsafe_unretained NSString *createdAt;
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

@property (nonatomic, strong) SPUser *sender;

//- (BOOL)validateSender:(id*)value_ error:(NSError**)error_;

@end

@interface _SPNotification (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveContent;
- (void)setPrimitiveContent:(NSString*)value;

- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;

- (SPUser*)primitiveSender;
- (void)setPrimitiveSender:(SPUser*)value;

@end