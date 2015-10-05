// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPMessage.m instead.

#import "_SPMessage.h"

const struct SPMessageAttributes SPMessageAttributes = {
	.content = @"content",
	.createdAt = @"createdAt",
	.createdAtString = @"createdAtString",
	.unreadMessagesCount = @"unreadMessagesCount",
};

const struct SPMessageRelationships SPMessageRelationships = {
	.sender = @"sender",
};

@implementation SPMessageID
@end

@implementation _SPMessage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SPMessage" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SPMessage";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SPMessage" inManagedObjectContext:moc_];
}

- (SPMessageID*)objectID {
	return (SPMessageID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"unreadMessagesCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"unreadMessagesCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic content;

@dynamic createdAt;

@dynamic createdAtString;

@dynamic unreadMessagesCount;

- (int32_t)unreadMessagesCountValue {
	NSNumber *result = [self unreadMessagesCount];
	return [result intValue];
}

- (void)setUnreadMessagesCountValue:(int32_t)value_ {
	[self setUnreadMessagesCount:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveUnreadMessagesCountValue {
	NSNumber *result = [self primitiveUnreadMessagesCount];
	return [result intValue];
}

- (void)setPrimitiveUnreadMessagesCountValue:(int32_t)value_ {
	[self setPrimitiveUnreadMessagesCount:[NSNumber numberWithInt:value_]];
}

@dynamic sender;

@end

