// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPUser.m instead.

#import "_SPUser.h"

const struct SPUserAttributes SPUserAttributes = {
	.avatarUrl = @"avatarUrl",
	.desc = @"desc",
	.entriesCount = @"entriesCount",
	.followedTopicsCount = @"followedTopicsCount",
	.name = @"name",
	.upvotesCount = @"upvotesCount",
};

const struct SPUserRelationships SPUserRelationships = {
	.dialogs = @"dialogs",
	.entries = @"entries",
	.messages = @"messages",
	.sendedNotifications = @"sendedNotifications",
};

@implementation SPUserID
@end

@implementation _SPUser

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SPUser" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SPUser";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SPUser" inManagedObjectContext:moc_];
}

- (SPUserID*)objectID {
	return (SPUserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"entriesCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"entriesCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"followedTopicsCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"followedTopicsCount"];
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

@dynamic avatarUrl;

@dynamic desc;

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

@dynamic followedTopicsCount;

- (int32_t)followedTopicsCountValue {
	NSNumber *result = [self followedTopicsCount];
	return [result intValue];
}

- (void)setFollowedTopicsCountValue:(int32_t)value_ {
	[self setFollowedTopicsCount:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveFollowedTopicsCountValue {
	NSNumber *result = [self primitiveFollowedTopicsCount];
	return [result intValue];
}

- (void)setPrimitiveFollowedTopicsCountValue:(int32_t)value_ {
	[self setPrimitiveFollowedTopicsCount:[NSNumber numberWithInt:value_]];
}

@dynamic name;

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

@dynamic dialogs;

- (NSMutableSet*)dialogsSet {
	[self willAccessValueForKey:@"dialogs"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"dialogs"];

	[self didAccessValueForKey:@"dialogs"];
	return result;
}

@dynamic entries;

- (NSMutableSet*)entriesSet {
	[self willAccessValueForKey:@"entries"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"entries"];

	[self didAccessValueForKey:@"entries"];
	return result;
}

@dynamic messages;

- (NSMutableSet*)messagesSet {
	[self willAccessValueForKey:@"messages"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"messages"];

	[self didAccessValueForKey:@"messages"];
	return result;
}

@dynamic sendedNotifications;

- (NSMutableSet*)sendedNotificationsSet {
	[self willAccessValueForKey:@"sendedNotifications"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"sendedNotifications"];

	[self didAccessValueForKey:@"sendedNotifications"];
	return result;
}

@end

