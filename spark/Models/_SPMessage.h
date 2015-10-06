// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPMessage.h instead.

#import <CoreData/CoreData.h>

extern const struct SPMessageAttributes {
	__unsafe_unretained NSString *content;
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *fromEntry;
} SPMessageAttributes;

extern const struct SPMessageRelationships {
	__unsafe_unretained NSString *dialog;
	__unsafe_unretained NSString *sender;
} SPMessageRelationships;

@class SPDialog;
@class SPUser;

@interface SPMessageID : NSManagedObjectID {}
@end

@interface _SPMessage : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SPMessageID* objectID;

@property (nonatomic, strong) NSString* content;

//- (BOOL)validateContent:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* createdAt;

//- (BOOL)validateCreatedAt:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* fromEntry;

@property (atomic) BOOL fromEntryValue;
- (BOOL)fromEntryValue;
- (void)setFromEntryValue:(BOOL)value_;

//- (BOOL)validateFromEntry:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) SPDialog *dialog;

//- (BOOL)validateDialog:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) SPUser *sender;

//- (BOOL)validateSender:(id*)value_ error:(NSError**)error_;

@end

@interface _SPMessage (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveContent;
- (void)setPrimitiveContent:(NSString*)value;

- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;

- (NSNumber*)primitiveFromEntry;
- (void)setPrimitiveFromEntry:(NSNumber*)value;

- (BOOL)primitiveFromEntryValue;
- (void)setPrimitiveFromEntryValue:(BOOL)value_;

- (SPDialog*)primitiveDialog;
- (void)setPrimitiveDialog:(SPDialog*)value;

- (SPUser*)primitiveSender;
- (void)setPrimitiveSender:(SPUser*)value;

@end
