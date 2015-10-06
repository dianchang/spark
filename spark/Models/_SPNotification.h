// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPNotification.h instead.

#import <CoreData/CoreData.h>
#import "SPBaseDialog.h"

extern const struct SPNotificationRelationships {
	__unsafe_unretained NSString *sender;
} SPNotificationRelationships;

@class SPUser;

@interface SPNotificationID : SPBaseDialogID {}
@end

@interface _SPNotification : SPBaseDialog {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SPNotificationID* objectID;

@property (nonatomic, strong) SPUser *sender;

//- (BOOL)validateSender:(id*)value_ error:(NSError**)error_;

@end

@interface _SPNotification (CoreDataGeneratedPrimitiveAccessors)

- (SPUser*)primitiveSender;
- (void)setPrimitiveSender:(SPUser*)value;

@end
