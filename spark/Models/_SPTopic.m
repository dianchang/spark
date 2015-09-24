// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPTopic.m instead.

#import "_SPTopic.h"

const struct SPTopicAttributes SPTopicAttributes = {
	.entriesCount = @"entriesCount",
	.name = @"name",
};

const struct SPTopicRelationships SPTopicRelationships = {
	.entries = @"entries",
};

@implementation SPTopicID
@end

@implementation _SPTopic

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SPTopic" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SPTopic";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SPTopic" inManagedObjectContext:moc_];
}

- (SPTopicID*)objectID {
	return (SPTopicID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"entriesCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"entriesCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic entriesCount;

- (int32_t)entriesCountValue {
	NSNumber *result = [self entriesCount];
	return [result intValue];
}

- (void)setEntriesCountValue:(int32_t)value_ {
	[self setEntriesCount:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveEntriesCountValue {
	NSNumber *result = [self primitiveEntriesCount];
	return [result intValue];
}

- (void)setPrimitiveEntriesCountValue:(int32_t)value_ {
	[self setPrimitiveEntriesCount:[NSNumber numberWithInt:value_]];
}

@dynamic name;

@dynamic entries;

- (NSMutableSet*)entriesSet {
	[self willAccessValueForKey:@"entries"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"entries"];

	[self didAccessValueForKey:@"entries"];
	return result;
}

@end

