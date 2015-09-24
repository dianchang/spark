// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPTopic.h instead.

#import <CoreData/CoreData.h>

extern const struct SPTopicAttributes {
	__unsafe_unretained NSString *entriesCount;
	__unsafe_unretained NSString *name;
} SPTopicAttributes;

extern const struct SPTopicRelationships {
	__unsafe_unretained NSString *entries;
} SPTopicRelationships;

@class SPEntry;

@interface SPTopicID : NSManagedObjectID {}
@end

@interface _SPTopic : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SPTopicID* objectID;

@property (nonatomic, strong) NSNumber* entriesCount;

@property (atomic) int32_t entriesCountValue;
- (int32_t)entriesCountValue;
- (void)setEntriesCountValue:(int32_t)value_;

//- (BOOL)validateEntriesCount:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *entries;

- (NSMutableSet*)entriesSet;

@end

@interface _SPTopic (EntriesCoreDataGeneratedAccessors)
- (void)addEntries:(NSSet*)value_;
- (void)removeEntries:(NSSet*)value_;
- (void)addEntriesObject:(SPEntry*)value_;
- (void)removeEntriesObject:(SPEntry*)value_;

@end

@interface _SPTopic (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveEntriesCount;
- (void)setPrimitiveEntriesCount:(NSNumber*)value;

- (int32_t)primitiveEntriesCountValue;
- (void)setPrimitiveEntriesCountValue:(int32_t)value_;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveEntries;
- (void)setPrimitiveEntries:(NSMutableSet*)value;

@end
