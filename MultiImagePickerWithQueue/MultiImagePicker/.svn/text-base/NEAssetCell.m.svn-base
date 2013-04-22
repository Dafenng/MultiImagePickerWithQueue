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

@synthesize rowAssets;

-(id)initWithAssets:(NSArray*)_assets reuseIdentifier:(NSString*)_identifier {
    
	if(self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_identifier]) {
        
		self.rowAssets = _assets;
	}
	
	return self;
}

-(void)setAssets:(NSArray*)_assets {
	
	for(UIView *view in [self subviews]) 
    {		
		[view removeFromSuperview];
	}
	
	self.rowAssets = _assets;
}

-(void)layoutSubviews {
    
	CGRect frame = CGRectMake(4, 2, 75, 75);
	
	for(NEAsset *asset in self.rowAssets) {
		
		[asset setFrame:frame];
		[asset addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:asset action:@selector(toggleSelection)] autorelease]];
		[self addSubview:asset];
		
		frame.origin.x = frame.origin.x + frame.size.width + 4;
	}
}

-(void)dealloc 
{
	[rowAssets release];
    
	[super dealloc];
}

@end
