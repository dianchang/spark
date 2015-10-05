// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPNotification.m instead.

#import "_SPNotification.h"

const struct SPNotificationAttributes SPNotificationAttributes = {
	.content = @"content",
	.createdAt = @"createdAt",
	.createdAtString = @"createdAtString",
	.unreadNotificationsCount = @"unreadNotificationsCount",
};

const struct SPNotificationRelationships SPNotificationRelationships = {
	.sender = @"sender",
};

@implementation SPNotificationID
@end

@implementation _SPNotification

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SPNotification" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SPNotification";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SPNotification" inManagedObjectContext:moc_];
}

- (SPNotificationID*)objectID {
	return (SPNotificationID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"unreadNotificationsCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"unreadNotificationsCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic content;

@dynamic createdAt;

@dynamic createdAtString;

@dynamic unreadNotificationsCount;

- (int32_t)unreadNotificationsCountValue {
	NSNumber *result = [self unreadNotificationsCount];
	return [result intValue];
}

- (void)setUnreadNotificationsCountValue:(int32_t)value_ {
	[self setUnreadNotificationsCount:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveUnreadNotificationsCountValue {
	NSNumber *result = [self primitiveUnreadNotificationsCount];
	return [result intValue];
}

- (void)setPrimitiveUnreadNotificationsCountValue:(int32_t)value_ {
	[self setPrimitiveUnreadNotificationsCount:[NSNumber numberWithInt:value_]];
}

@dynamic sender;

@end

