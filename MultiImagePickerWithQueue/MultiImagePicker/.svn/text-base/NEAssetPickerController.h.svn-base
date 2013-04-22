//
//  NEAssetPickerController.h
//  CityDate
//
//  Created by Dafeng Jin on 13-3-18.
//  Copyright (c) 2013年 NetEase Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class NEAsset;

@interface NEAssetPickerController : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
	ALAssetsGroup *assetGroup;
	
	NSMutableArray *assets;
	int selectedAssets;
	
	id parent;
	
	NSOperationQueue *queue;
}

@property (retain, nonatomic) IBOutlet UITableView *photosTableView;
@property (retain, nonatomic) IBOutlet UIView *chosenPhotoContainerView;
@property (retain, nonatomic) IBOutlet UITableView *chosenPhotoTableView;
@property (nonatomic, assign) id parent;
@property (nonatomic, assign) ALAssetsGroup *assetGroup;
@property (nonatomic, retain) NSMutableArray *assets;
@property (nonatomic, retain) NSMutableArray *chosenAssets;

-(int)totalSelectedAssets;
-(void)preparePhotos;

-(void)doneAction:(id)sender;
- (void)addAsset:(NEAsset *)asset;
- (void)removeAsset:(NEAsset *)asset;

@end