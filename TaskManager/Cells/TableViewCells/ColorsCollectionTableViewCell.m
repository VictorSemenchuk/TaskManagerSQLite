//
//  ColorsCollectionTableViewCell.m
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "ColorsCollectionTableViewCell.h"
#import "ColorCollectionViewCell.h"

static NSString * const kColorCollectionViewCell = @"ColorCollectionViewCell";

@implementation ColorsCollectionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self registerCells];
        self.objects = [NSMutableArray arrayWithArray:@[UIColor.redColor,
                                                        UIColor.greenColor,
                                                        UIColor.blueColor,
                                                        UIColor.purpleColor,
                                                        UIColor.yellowColor,
                                                        UIColor.orangeColor]];
        [self.collectionView reloadData];
    }
    return self;
}

- (void)registerCells {
    [self.collectionView registerClass:ColorCollectionViewCell.class forCellWithReuseIdentifier:kColorCollectionViewCell];
}

#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ColorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kColorCollectionViewCell forIndexPath:indexPath];
    [cell installColor:self.objects[indexPath.row]];
    [cell indicateAsSelected:(self.selectedIndex == indexPath.row)];
    return cell;
}


@end
