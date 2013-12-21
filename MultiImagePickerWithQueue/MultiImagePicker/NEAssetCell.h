//
//  NEAssetCell.h
//  CityDate
//
//  Created by Dafeng Jin on 13-3-18.
//  Copyright (c) 2013年 NetEase Corp. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NEAssetCell : UITableViewCell

-(void)setAssets:(NSArray*)assets;

@property (nonatomic,retain) NSArray *rowAssets;

@end
