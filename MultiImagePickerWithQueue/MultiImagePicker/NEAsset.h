//
//  NEAsset.h
//  CityDate
//
//  Created by Dafeng Jin on 13-3-18.
//  Copyright (c) 2013年 NetEase Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALAsset+Equal.h"


@interface NEAsset : UIView

@property (nonatomic, retain) ALAsset *asset;
@property (nonatomic, assign) id parent;
@property (nonatomic, assign) BOOL selected;

-(id)initWithAsset:(ALAsset*)asset;
-(BOOL)isEqual:(id)obj;

@end