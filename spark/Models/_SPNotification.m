// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPNotification.m instead.

#import "_SPNotification.h"

const struct SPNotificationAttributes SPNotificationAttributes = {
	.content = @"content",
	.createdAt = @"createdAt",
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

	return keyPaths;
}

@dynamic content;

@dynamic createdAt;

@dynamic sender;

@end

