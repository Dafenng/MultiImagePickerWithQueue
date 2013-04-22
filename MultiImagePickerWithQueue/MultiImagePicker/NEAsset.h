//
//  NEAsset.h
//  CityDate
//
//  Created by Dafeng Jin on 13-3-18.
//  Copyright (c) 2013年 NetEase Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface NEAsset : UIView {
	ALAsset *asset;
	//UIImageView *overlayView;
	BOOL selected;
	id parent;
}

@property (nonatomic, retain) ALAsset *asset;
@property (nonatomic, assign) id parent;

-(id)initWithAsset:(ALAsset*)_asset;
-(BOOL)selected;

@end