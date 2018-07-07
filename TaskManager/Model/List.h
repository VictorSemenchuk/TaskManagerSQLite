//
//  List.h
//  TaskManager
//
//  Created by Victor Macintosh on 07/07/2018.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface List : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *iconTitle;
@property (nonatomic) UIColor *color;

- (id)initWithTitle:(NSString *)title iconTitle:(NSString *)iconTitle andColor:(UIColor *)color;

@end
