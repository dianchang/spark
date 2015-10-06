// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPMessage.m instead.

#import "_SPMessage.h"

const struct SPMessageAttributes SPMessageAttributes = {
	.content = @"content",
	.createdAt = @"createdAt",
	.fromEntry = @"fromEntry",
};

const struct SPMessageRelationships SPMessageRelationships = {
	.dialog = @"dialog",
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

	if ([key isEqualToString:@"fromEntryValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"fromEntry"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic content;

@dynamic createdAt;

@dynamic fromEntry;

- (BOOL)fromEntryValue {
	NSNumber *result = [self fromEntry];
	return [result boolValue];
}

- (void)setFromEntryValue:(BOOL)value_ {
	[self setFromEntry:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveFromEntryValue {
	NSNumber *result = [self primitiveFromEntry];
	return [result boolValue];
}

- (void)setPrimitiveFromEntryValue:(BOOL)value_ {
	[self setPrimitiveFromEntry:[NSNumber numberWithBool:value_]];
}

@dynamic dialog;

@dynamic sender;

@end

