//
//  IconsCollectionTableViewCell.m
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "IconsCollectionTableViewCell.h"
#import "IconCollectionViewCell.h"
#import "Icon.h"

static NSString * const kIconCollectionViewCell = @"IconCollectionViewCell";

@implementation IconsCollectionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self registerCells];
//        self.objects = [NSMutableArray arrayWithArray:@[@"icon1",
//                                                        @"icon2",
//                                                        @"icon3",
//                                                        @"icon4",
//                                                        @"icon5",
//                                                        @"icon6",
//                                                        @"icon7",
//                                                        @"icon8",
//                                                        @"icon9",
//                                                        @"icon10",
//                                                        @"icon11",
//                                                        @"icon12"]];
    }
    return self;
}

- (void)registerCells {
    [self.collectionView registerClass:IconCollectionViewCell.class forCellWithReuseIdentifier:kIconCollectionViewCell];
}

#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IconCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIconCollectionViewCell forIndexPath:indexPath];
    Icon *icon = self.objects[indexPath.row];
    [cell installImageWithName:icon.path];
    [cell indicateAsSelected:(self.selectedIndex == indexPath.row)];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    
    Icon *icon = self.objects[indexPath.row];
    [self.delegate iconWasSelectedWithId:icon.iconId];
}

@end
