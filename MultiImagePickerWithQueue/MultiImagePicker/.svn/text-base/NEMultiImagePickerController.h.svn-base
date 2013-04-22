//
//  NEMultiImagePickerController.h
//  CityDate
//
//  Created by Dafeng Jin on 13-3-18.
//  Copyright (c) 2013年 NetEase Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NEMultiImagePickerController : UINavigationController {

	id delegate;
}

@property (nonatomic, assign) id delegate;

-(void)selectedAssets:(NSArray*)_assets;
-(void)cancelImagePicker;

@end

@protocol NEMultiImagePickerControllerDelegate

- (void)multiImagePickerController:(NEMultiImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info;
- (void)multiImagePickerControllerDidCancel:(NEMultiImagePickerController *)picker;

@end

