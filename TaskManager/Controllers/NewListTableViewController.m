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
#import "ListService.h"
#import "ColorService.h"
#import "IconService.h"
#import "Constants.h"
#import "UIViewController+AlertCategory.h"

static NSString * const kNameCellIdentifier = @"NameCellIdentifier";
static NSString * const kIconsCollectionCellIdentifier = @"IconsCollectionCellIdentifier";
static NSString * const kColorsCollectionCellIdentifier = @"ColorsCollectionCellIdentifier";

@interface NewListTableViewController () <IconsCollectionTableViewCellDelegate, ColorsCollectionTableViewCellDelegate, EditableTableViewCellDelegate>

@property (nonatomic) NSMutableArray *icons;
@property (nonatomic) NSMutableArray *colors;
@property (assign, nonatomic) NSUInteger selectedIconId;
@property (assign, nonatomic) NSUInteger selectedColorId;
@property (nonatomic) NSString *listTitle;

- (void)loadData;
- (void)setupViews;
- (void)done;

@end

@implementation NewListTableViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"New list";
    [self loadData];
    
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

- (void)loadData {
    IconService *iconService = [[IconService alloc] init];
    ColorService *colorService = [[ColorService alloc] init];
    
    self.icons = [[NSMutableArray alloc] initWithArray:[iconService loadAllIcons]];
    self.colors = [[NSMutableArray alloc] initWithArray:[colorService loadAllColors]];
    
    Icon *initialIcon = [self.icons firstObject];
    self.selectedIconId = initialIcon.iconId;
    
    Color *initialColor = [self.colors firstObject];
    self.selectedColorId = initialColor.colorId;
    
    [self.tableView reloadData];
}

#pragma mark - Target methods

- (void)done {
    if ([self.listTitle isEqualToString: @""] || self.listTitle == nil) {
        [self showErrorAlertWithTitle:@"Oops" andMessage:@"Please, enter title for list"];
    } else {
        ListService *listService = [[ListService alloc] init];
        NSUInteger newListId = [listService addNewListWithTitle:self.listTitle iconId:self.selectedIconId colorId:self.selectedColorId];
        [self.delegate newListAddedWithId:newListId title:self.listTitle colorId:self.selectedColorId iconId:self.selectedIconId];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            EditableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNameCellIdentifier forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
        }
        case 1: {
            IconsCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIconsCollectionCellIdentifier forIndexPath:indexPath];
            [cell installObjects:self.icons];
            cell.delegate = self;
            return cell;
        }
        case 2: {
            ColorsCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kColorsCollectionCellIdentifier forIndexPath:indexPath];
            [cell installObjects:self.colors];
            cell.delegate = self;
            return cell;
        }
        default: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            return cell;
        }
    }
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

#pragma mark - EditableTableViewCellDelegate

- (void)textChanged:(NSString *)text {
    self.listTitle = text;
    NSLog(@"%@", self.listTitle);
}


#pragma mark - IconsCollectionTableViewCellDelegate

- (void)iconWasSelectedWithId:(NSUInteger)iconId {
    self.selectedIconId = iconId;
}

#pragma mark - ColorsCollectionTableViewCellDelegate

- (void)colorWasSelectedWithId:(NSUInteger)colorId {
    self.selectedColorId = colorId;
}

@end
