//
//  ViewController+AlertCategory.h
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/17/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewController (Alert)

- (void)showErrorAlertWithTitle:(NSString *)title andMessage:(NSString *)message;

@end
