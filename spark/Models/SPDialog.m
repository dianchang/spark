#import "SPDialog.h"
#import <MagicalRecord/MagicalRecord.h>

@interface SPDialog ()

// Private interface goes here.

@end

@implementation SPDialog

@synthesize latestMessage = _latestMessage;

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    [self setPrimitiveCreatedAt:[NSDate date]];
}

#pragma mark - Getters & Setters

- (SPMessage *)latestMessage
{
    if (!_latestMessage) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF IN %@", self.messages];
        _latestMessage = [SPMessage MR_findFirstWithPredicate:predicate sortedBy:@"createdAt" ascending:NO];
    }
    
    return _latestMessage;
}

@end
