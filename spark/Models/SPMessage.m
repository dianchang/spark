#import "SPMessage.h"

@interface SPMessage ()

// Private interface goes here.

@end

@implementation SPMessage

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    [self setPrimitiveCreatedAt:[NSDate date]];
}

@end
