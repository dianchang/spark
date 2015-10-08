// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPBaseDialog.m instead.

#import "_SPBaseDialog.h"

const struct SPBaseDialogAttributes SPBaseDialogAttributes = {
	.createdAt = @"createdAt",
	.createdAtString = @"createdAtString",
	.hasNewMessage = @"hasNewMessage",
	.unreadMessagesCount = @"unreadMessagesCount",
};

const struct SPBaseDialogRelationships SPBaseDialogRelationships = {
	.messages = @"messages",
};

@implementation SPBaseDialogID
@end

@implementation _SPBaseDialog

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SPBaseDialog" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SPBaseDialog";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SPBaseDialog" inManagedObjectContext:moc_];
}

- (SPBaseDialogID*)objectID {
	return (SPBaseDialogID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"hasNewMessageValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hasNewMessage"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"unreadMessagesCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"unreadMessagesCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic createdAt;

@dynamic createdAtString;

@dynamic hasNewMessage;

- (BOOL)hasNewMessageValue {
	NSNumber *result = [self hasNewMessage];
	return [result boolValue];
}

- (void)setHasNewMessageValue:(BOOL)value_ {
	[self setHasNewMessage:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveHasNewMessageValue {
	NSNumber *result = [self primitiveHasNewMessage];
	return [result boolValue];
}

- (void)setPrimitiveHasNewMessageValue:(BOOL)value_ {
	[self setPrimitiveHasNewMessage:[NSNumber numberWithBool:value_]];
}

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

@end

