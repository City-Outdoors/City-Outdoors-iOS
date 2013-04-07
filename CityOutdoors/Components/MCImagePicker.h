//
//  MCImagePicker.h
//  CityOutdoors
//
//  Created by Marius Ciocanel on 14/01/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MCImagePicker : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

- (void)presentFromController:(UIViewController *)aController;
- (void)setImagePickerCompletionBlock:(void (^)(UIImage *chosenImage))block;
- (void)setImagePickerCancelBlock:(void (^)(void))block;

@end
