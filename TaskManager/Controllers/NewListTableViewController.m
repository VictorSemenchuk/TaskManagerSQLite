//
//  NewListTableViewController.m
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "NewListTableViewController.h"
#import "EditableTableViewCell.h"
#import "IconsCollectionTableViewCell.h"
#import "ColorsCollectionTableViewCell.h"

static NSString * const kNameCellIdentifier = @"NameCellIdentifier";
static NSString * const kIconsCollectionCellIdentifier = @"IconsCollectionCellIdentifier";
static NSString * const kColorsCollectionCellIdentifier = @"ColorsCollectionCellIdentifier";

@interface NewListTableViewController ()

- (void)setupViews;
- (void)done;

@end

@implementation NewListTableViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"New list";
    [self.tableView registerClass:EditableTableViewCell.class forCellReuseIdentifier:kNameCellIdentifier];
    [self.tableView registerClass:IconsCollectionTableViewCell.class forCellReuseIdentifier:kIconsCollectionCellIdentifier];
    [self.tableView registerClass:ColorsCollectionTableViewCell.class forCellReuseIdentifier:kColorsCollectionCellIdentifier];
    
    [self setupViews];
}

#pragma mark - Methods

- (void)setupViews {
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

#pragma mark - Target methods

- (void)done {
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        EditableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNameCellIdentifier forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 1) {
        IconsCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIconsCollectionCellIdentifier forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 2) {
        ColorsCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kColorsCollectionCellIdentifier forIndexPath:indexPath];
        return cell;
    }
 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 || indexPath.section == 2) {
        return 90.0;
    }
    return 44.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Title";
    } else if (section == 1) {
        return @"Icon";
    } else if (section == 2) {
        return @"Color";
    } else {
        return @"";
    }
}

@end
