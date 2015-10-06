// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPDialog.h instead.

#import <CoreData/CoreData.h>
#import "SPBaseDialog.h"

extern const struct SPDialogRelationships {
	__unsafe_unretained NSString *dialogist;
} SPDialogRelationships;

@class SPUser;

@interface SPDialogID : SPBaseDialogID {}
@end

@interface _SPDialog : SPBaseDialog {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SPDialogID* objectID;

@property (nonatomic, strong) SPUser *dialogist;

//- (BOOL)validateDialogist:(id*)value_ error:(NSError**)error_;

@end

@interface _SPDialog (CoreDataGeneratedPrimitiveAccessors)

- (SPUser*)primitiveDialogist;
- (void)setPrimitiveDialogist:(SPUser*)value;

@end
