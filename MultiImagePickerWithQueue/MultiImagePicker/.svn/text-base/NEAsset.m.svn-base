//
//  NEAsset.m
//  CityDate
//
//  Created by Dafeng Jin on 13-3-18.
//  Copyright (c) 2013年 NetEase Corp. All rights reserved.
//

#import "NEAsset.h"
#import "NEAssetPickerController.h"

@implementation NEAsset

@synthesize asset;
@synthesize parent;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

-(id)initWithAsset:(ALAsset*)_asset {
	
	if (self = [super initWithFrame:CGRectMake(0, 0, 0, 0)]) {
		
		self.asset = _asset;
		
		CGRect viewFrames = CGRectMake(0, 0, 75, 75);
		
		UIImageView *assetImageView = [[UIImageView alloc] initWithFrame:viewFrames];
		[assetImageView setContentMode:UIViewContentModeScaleToFill];
		[assetImageView setImage:[UIImage imageWithCGImage:[self.asset thumbnail]]];
		[self addSubview:assetImageView];
		[assetImageView release];
		
//		overlayView = [[UIImageView alloc] initWithFrame:viewFrames];
//		[overlayView setImage:[UIImage imageNamed:@"Overlay.png"]];
//		[overlayView setHidden:YES];
//		[self addSubview:overlayView];
    }
    
	return self;	
}

-(void)toggleSelection {
    
	//overlayView.hidden = !overlayView.hidden;
    [(NEAssetPickerController *)self.parent addAsset:self];
    selected = YES;
}

-(void)toggleDeselection {
    
	//overlayView.hidden = !overlayView.hidden;
    [(NEAssetPickerController *)self.parent removeAsset:self];
    selected = NO;
}

-(BOOL)selected {
	
	return selected;
}

//-(void)setSelected:(BOOL)_selected {
//    
//	//[overlayView setHidden:!_selected];
//    selected = _selected;
//}

- (void)dealloc 
{    
    self.asset = nil;
	//[overlayView release];
    [super dealloc];
}

@end

