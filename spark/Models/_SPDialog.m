// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPDialog.m instead.

#import "_SPDialog.h"

const struct SPDialogAttributes SPDialogAttributes = {
	.createdAt = @"createdAt",
	.unreadMessagesCount = @"unreadMessagesCount",
};

const struct SPDialogRelationships SPDialogRelationships = {
	.messages = @"messages",
	.sender = @"sender",
};

@implementation SPDialogID
@end

@implementation _SPDialog

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SPDialog" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SPDialog";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SPDialog" inManagedObjectContext:moc_];
}

- (SPDialogID*)objectID {
	return (SPDialogID*)[super objectID];
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

@dynamic createdAt;

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

@dynamic messages;

- (NSMutableSet*)messagesSet {
	[self willAccessValueForKey:@"messages"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"messages"];

	[self didAccessValueForKey:@"messages"];
	return result;
}

@dynamic sender;

@end

