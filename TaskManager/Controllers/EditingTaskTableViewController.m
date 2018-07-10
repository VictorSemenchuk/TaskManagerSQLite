//
//  EditingTaskTableViewController.m
//  TaskManager
//
//  Created by Victor Macintosh on 10/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "EditingTaskTableViewController.h"

@interface EditingTaskTableViewController ()

@end

@implementation EditingTaskTableViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:EditableTableViewCell.class forCellReuseIdentifier:kTextCellIdentifier];
    [self.tableView registerClass:SegmentControlTableViewCell.class forCellReuseIdentifier:kPriorityCellIdentifier];
    self.priorities = @[@"None", @"!", @"!!", @"!!!"];
    
    [self setupViews];
}

#pragma mark - Methods

- (void)setupViews {
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

#pragma mark - Target methods

- (void)done {
    return;
}

#pragma mark - EditableTableViewCellDelegate

- (void)textChanged:(NSString *)text {
    self.text = text;
}

#pragma mark - SegmentControlTableViewCellDelegate

- (void)segmentedControlWasChanged:(NSUInteger)value {
    self.priority = value;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        EditableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTextCellIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    } else {
        SegmentControlTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPriorityCellIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        [cell setTitle:@"Priority" items:self.priorities selectedIndex:0];
        return cell;
    }
}


@end
