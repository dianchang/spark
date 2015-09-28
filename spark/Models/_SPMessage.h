// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPMessage.h instead.

#import <CoreData/CoreData.h>

extern const struct SPMessageAttributes {
	__unsafe_unretained NSString *content;
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *createdAtString;
} SPMessageAttributes;

extern const struct SPMessageRelationships {
	__unsafe_unretained NSString *sender;
} SPMessageRelationships;

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

@property (nonatomic, strong) NSString* createdAtString;

//- (BOOL)validateCreatedAtString:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) SPUser *sender;

//- (BOOL)validateSender:(id*)value_ error:(NSError**)error_;

@end

@interface _SPMessage (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveContent;
- (void)setPrimitiveContent:(NSString*)value;

- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;

- (NSString*)primitiveCreatedAtString;
- (void)setPrimitiveCreatedAtString:(NSString*)value;

- (SPUser*)primitiveSender;
- (void)setPrimitiveSender:(SPUser*)value;

@end
