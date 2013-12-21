//
//  NEAsset.m
//  CityDate
//
//  Created by Dafeng Jin on 13-3-18.
//  Copyright (c) 2013年 NetEase Corp. All rights reserved.
//

#import "NEAsset.h"
#import "NEAssetPickerController.h"
#import <QuartzCore/QuartzCore.h>

@interface NEAsset ()

@property (nonatomic, retain) UIImageView *overlayView;

@end

@implementation NEAsset

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

-(id)initWithAsset:(ALAsset*)asset {
	
	if (self = [super initWithFrame:CGRectMake(0, 0, 0, 0)]) {
		
		self.asset = asset;
		
		CGRect viewFrames = CGRectMake(0, 0, 75, 75);
		
		UIImageView *assetImageView = [[UIImageView alloc] initWithFrame:viewFrames];
		[assetImageView setContentMode:UIViewContentModeScaleToFill];
		[assetImageView setImage:[UIImage imageWithCGImage:[self.asset thumbnail]]];
		[self addSubview:assetImageView];
		[assetImageView release];
		
		UIImageView *overlay = [[UIImageView alloc] initWithFrame:viewFrames];
//		[overlayView setImage:[UIImage imageNamed:@"Overlay.png"]];
        overlay.layer.borderColor = [UIColor blueColor].CGColor;
        overlay.layer.borderWidth = 5.0f;
        [overlay setHidden:!self.selected];
        self.overlayView = overlay;
        [overlay release];
        
		[self addSubview:self.overlayView];
    }
    
	return self;	
}

-(void)toggleSelection {
    
	//overlayView.hidden = !overlayView.hidden;
    [(NEAssetPickerController *)self.parent addAsset:self];
    self.selected = YES;
}

-(void)toggleDeselection {
    
	//overlayView.hidden = !overlayView.hidden;
    [(NEAssetPickerController *)self.parent removeAsset:self];
    self.selected = NO;
}

-(void)setSelected:(BOOL)selected
{
    _selected = selected;
    [self.overlayView setHidden:!_selected];
}

- (BOOL)isEqual:(id)obj
{
    if(![obj isKindOfClass:[NEAsset class]])
        return NO;
    
    return [self.asset isEqual:((NEAsset *)obj).asset];
}

- (void)dealloc 
{    
    [_asset release];
    [_overlayView release];
    [super dealloc];
}

@end

