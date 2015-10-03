//
//  EntryTableViewCell.m
//  spark
//
//  Created by hustlzp on 15/9/25.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "EntryTableViewCell.h"
#import <Masonry/Masonry.h>

@interface EntryTableViewCell ()

@property (strong, nonatomic) SPEntry *entry;
@property (strong, nonatomic) EntryView *entryView;

@end

@implementation EntryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    EntryView *entryView = [[EntryView alloc] initWithPadding:UIEdgeInsetsMake(20, 20, 20, 20)];
    [self.contentView addSubview:entryView];
    self.entryView = entryView;
    
    [entryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    return self;
}

- (void)updateWithEntry:(SPEntry *)entry
{
    self.entry = entry;
    [self.entryView updateWithEntry:entry];
}

#pragma mark - Getters & Setters

- (void)setDelegate:(id <EntryViewDelegate>)delegate
{
    _delegate = delegate;
    self.entryView.delegate = delegate;
}

@end
