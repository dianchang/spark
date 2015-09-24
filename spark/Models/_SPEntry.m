// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPEntry.m instead.

#import "_SPEntry.h"

const struct SPEntryAttributes SPEntryAttributes = {
	.content = @"content",
	.createdAt = @"createdAt",
	.downvotesCount = @"downvotesCount",
	.upvotesCount = @"upvotesCount",
};

const struct SPEntryRelationships SPEntryRelationships = {
	.topics = @"topics",
	.user = @"user",
};

@implementation SPEntryID
@end

@implementation _SPEntry

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SPEntry" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SPEntry";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SPEntry" inManagedObjectContext:moc_];
}

- (SPEntryID*)objectID {
	return (SPEntryID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"downvotesCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"downvotesCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"upvotesCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"upvotesCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic content;

@dynamic createdAt;

@dynamic downvotesCount;

- (int32_t)downvotesCountValue {
	NSNumber *result = [self downvotesCount];
	return [result intValue];
}

- (void)setDownvotesCountValue:(int32_t)value_ {
	[self setDownvotesCount:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveDownvotesCountValue {
	NSNumber *result = [self primitiveDownvotesCount];
	return [result intValue];
}

- (void)setPrimitiveDownvotesCountValue:(int32_t)value_ {
	[self setPrimitiveDownvotesCount:[NSNumber numberWithInt:value_]];
}

@dynamic upvotesCount;

- (int32_t)upvotesCountValue {
	NSNumber *result = [self upvotesCount];
	return [result intValue];
}

- (void)setUpvotesCountValue:(int32_t)value_ {
	[self setUpvotesCount:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveUpvotesCountValue {
	NSNumber *result = [self primitiveUpvotesCount];
	return [result intValue];
}

- (void)setPrimitiveUpvotesCountValue:(int32_t)value_ {
	[self setPrimitiveUpvotesCount:[NSNumber numberWithInt:value_]];
}

@dynamic topics;

- (NSMutableSet*)topicsSet {
	[self willAccessValueForKey:@"topics"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"topics"];

	[self didAccessValueForKey:@"topics"];
	return result;
}

@dynamic user;

@end

