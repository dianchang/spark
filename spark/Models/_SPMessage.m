// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPMessage.m instead.

#import "_SPMessage.h"

const struct SPMessageAttributes SPMessageAttributes = {
	.content = @"content",
	.createAtString = @"createAtString",
	.createdAt = @"createdAt",
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

	return keyPaths;
}

@dynamic content;

@dynamic createAtString;

@dynamic createdAt;

@dynamic sender;

@end

