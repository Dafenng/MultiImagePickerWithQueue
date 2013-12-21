//
//  NEAssetCell.m
//  CityDate
//
//  Created by Dafeng Jin on 13-3-18.
//  Copyright (c) 2013年 NetEase Corp. All rights reserved.
//

#import "NEAssetCell.h"
#import "NEAsset.h"

@implementation NEAssetCell

-(void)setAssets:(NSArray*)assets {
	
	for(UIView *view in [self.contentView subviews])
    {		
		[view removeFromSuperview];
	}
	
	self.rowAssets = assets;
    
    CGRect frame = CGRectMake(4, 2, 75, 75);
	
	for(NEAsset *asset in self.rowAssets) {
		
		[asset setFrame:frame];
		[asset addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:asset action:@selector(toggleSelection)] autorelease]];
		[self.contentView addSubview:asset];
		
		frame.origin.x = frame.origin.x + frame.size.width + 4;
	}
}

//-(void)layoutSubviews {
//    
//	CGRect frame = CGRectMake(4, 2, 75, 75);
//	
//	for(NEAsset *asset in self.rowAssets) {
//		
//		[asset setFrame:frame];
//		[asset addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:asset action:@selector(toggleSelection)] autorelease]];
//		[self.contentView addSubview:asset];
//		
//		frame.origin.x = frame.origin.x + frame.size.width + 4;
//	}
//}

-(void)dealloc 
{
	[_rowAssets release];
    
	[super dealloc];
}

@end
