// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPTopic.m instead.

#import "_SPTopic.h"

const struct SPTopicAttributes SPTopicAttributes = {
	.entriesCount = @"entriesCount",
	.followersCount = @"followersCount",
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
	if ([key isEqualToString:@"followersCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"followersCount"];
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

@dynamic followersCount;

- (int32_t)followersCountValue {
	NSNumber *result = [self followersCount];
	return [result intValue];
}

- (void)setFollowersCountValue:(int32_t)value_ {
	[self setFollowersCount:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveFollowersCountValue {
	NSNumber *result = [self primitiveFollowersCount];
	return [result intValue];
}

- (void)setPrimitiveFollowersCountValue:(int32_t)value_ {
	[self setPrimitiveFollowersCount:[NSNumber numberWithInt:value_]];
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

