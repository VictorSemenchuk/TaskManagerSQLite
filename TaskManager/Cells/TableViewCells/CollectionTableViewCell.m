//
//  CollectionTableViewCell.m
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "CollectionTableViewCell.h"

static CGFloat const verticalInsetConstant = 20.0;

@interface CollectionTableViewCell ()

- (void)setupViews;

@end

@implementation CollectionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        self.selectedIndex = 0;
    }
    return self;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.contentInset = UIEdgeInsetsMake(verticalInsetConstant, 10.0, verticalInsetConstant, 10.0);
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row;
}

- (void)setupViews {
    //collectionView
    [self addSubview:self.collectionView];
    [NSLayoutConstraint activateConstraints:@[[self.collectionView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                              [self.collectionView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
                                              [self.collectionView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                              [self.collectionView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]]];
    [self layoutIfNeeded];
}

- (void)registerCells {
    [self.collectionView registerClass:UITableViewCell.class forCellWithReuseIdentifier:@"cell"];
}

#pragma mark - UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat sideSize = self.collectionView.frame.size.height - 2 * verticalInsetConstant;
    return CGSizeMake(sideSize, sideSize);
}

@end
