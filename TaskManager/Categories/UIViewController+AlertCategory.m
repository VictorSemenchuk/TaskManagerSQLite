//
//  ViewController+AlertCategory.m
//  TaskManager
//
//  Created by Viktar Semianchuk on 7/17/18.
//  Copyright © 2018 Victor Semenchuk. All rights reserved.
//

#import "UIViewController+AlertCategory.h"

@implementation UIViewController (Alert)

- (void)showErrorAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //hide alert controller
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
