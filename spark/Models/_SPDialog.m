// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SPDialog.m instead.

#import "_SPDialog.h"

const struct SPDialogRelationships SPDialogRelationships = {
	.dialogist = @"dialogist",
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

	return keyPaths;
}

@dynamic dialogist;

@end

