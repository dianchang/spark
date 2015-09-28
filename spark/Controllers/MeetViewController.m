//
//  MeetViewController.m
//  spark
//
//  Created by hustlzp on 15/9/24.
//  Copyright © 2015年 hustlzp. All rights reserved.
//

#import "SPEntry.h"
#import "SPUser.h"
#import "EntryDraggableView.h"
#import "MeetViewController.h"
#import "AddEntryViewController.h"
#import "DialogViewController.h"
#import "UIColor+Helper.h"
#import "TopicViewController.h"
#import <ionicons/IonIcons.h>
#import <MagicalRecord/MagicalRecord.h>
#import <Masonry/Masonry.h>

@interface MeetViewController () <DraggableViewDelegate, TopicsListViewDelegate>

@property (strong, nonatomic) UIView *cardWapView;
@property (strong, nonatomic) NSMutableArray *draggableViews;

@end

@implementation MeetViewController

#pragma mark - LifeCycle

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view.backgroundColor = [UIColor SPBackgroundColor];
    
    [self createViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"Spark";
    UIImage *plusIcon = [IonIcons imageWithIcon:ion_android_add size:28 color:[UIColor lightGrayColor]];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:plusIcon style:UIBarButtonItemStylePlain target:self action:@selector(addEntry)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//}
//
//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//}

#pragma mark - Layout

- (void)createViews
{
    UIView *secondBottomView = [UIView new];
    secondBottomView.backgroundColor = [UIColor whiteColor];
    secondBottomView.layer.borderWidth = 1;
    secondBottomView.layer.borderColor = [UIColor colorWithRGBA:0xE2E2E2FF].CGColor;
    secondBottomView.layer.cornerRadius = 3;
    secondBottomView.layer.masksToBounds = YES;
    [self.view addSubview:secondBottomView];
    
    UIView *firstBottomView = [UIView new];
    firstBottomView.backgroundColor = [UIColor whiteColor];
    firstBottomView.layer.borderWidth = 1;
    firstBottomView.layer.borderColor = [UIColor colorWithRGBA:0xE2E2E2FF].CGColor;
    firstBottomView.layer.cornerRadius = 3;
    firstBottomView.layer.masksToBounds = YES;
    [self.view addSubview:firstBottomView];

    UIView *cardWapView = [UIView new];
    self.cardWapView = cardWapView;
    [self.view addSubview:cardWapView];
    
    [cardWapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(12);
        make.right.equalTo(self.view).offset(-12);
        make.bottom.equalTo(firstBottomView).offset(-3);
    }];
    
    [firstBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.bottom.equalTo(secondBottomView).offset(-3);
        make.left.equalTo(self.view).offset(14);
        make.right.equalTo(self.view).offset(-14);
    }];
    
    [secondBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.bottom.equalTo(self.view).offset(-16);
    }];
    
    [self loadDraggableView];
    [self loadDraggableView];
}

#pragma mark - Public Interface

#pragma mark - User Interface

- (void)addEntry
{
    AddEntryViewController *addEntryViewController = [AddEntryViewController new];
    addEntryViewController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addEntryViewController];
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - DraggableViewDelegate

- (void)cardSwipedLeft:(UIView *)card
{
    [self.draggableViews removeObjectAtIndex:0];
    [self loadDraggableView];
}

- (void)cardSwipedRight:(UIView *)card
{
    [self.draggableViews removeObjectAtIndex:0];
    [self loadDraggableView];
}

- (void)commentButtonPressed:(SPUser *)user
{
    UIViewController *controller = [[DialogViewController alloc] initWithUser:user];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - SPPresentedViewControllerProtocol

- (void)didDismissPresentedViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TopicsListViewDelegate

- (void)topicPressed:(SPTopic *)topic
{
    UIViewController *controller = [[TopicViewController alloc] initWithTopic:topic];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Internal Helpers

- (SPEntry *)loadEntry
{
    NSInteger total = [SPEntry MR_countOfEntities];
    NSFetchRequest *myRequest = [SPEntry MR_requestAll];
    myRequest.fetchLimit = 1;
    myRequest.fetchOffset = arc4random() % total;
    return [[SPEntry MR_executeFetchRequest:myRequest] firstObject];
}

- (void)loadDraggableView
{
    EntryDraggableView *entryView = [[EntryDraggableView alloc] initWithEntry:[self loadEntry]];
    entryView.delegate = self;
    
    if (self.draggableViews.count == 0) {
        [self.cardWapView addSubview:entryView];
    } else {
        [self.cardWapView insertSubview:entryView belowSubview:[self.draggableViews lastObject]];
    }
    
    [entryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.cardWapView);
    }];
    
    [self.draggableViews addObject:entryView];
}

#pragma mark - Getters & Setters

- (NSMutableArray *)draggableViews
{
    if (!_draggableViews) {
        _draggableViews = [NSMutableArray new];
    }
    
    return _draggableViews;
}

@end
