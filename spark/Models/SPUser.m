#import "SPUser.h"
#import <MagicalRecord/MagicalRecord.h>

@interface SPUser ()

// Private interface goes here.

@end

@implementation SPUser

+ (SPUser *)findCurrentUser
{
    return [SPUser MR_findFirstByAttribute:@"name" withValue:@"哈丁"];
}

- (BOOL)isEqualToManagedObject:(NSManagedObject *)object
{
    return [[self.objectID description] isEqualToString:[object.objectID description]];
}

@end
