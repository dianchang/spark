#import "_SPUser.h"

@interface SPUser : _SPUser {}
// Custom logic goes here.

+ (SPUser *)findCurrentUser;
- (BOOL)isEqualToManagedObject:(NSManagedObject *)object;

@end
