//
//  NEMultiImagePickerController.m
//  CityDate
//
//  Created by Dafeng Jin on 13-3-18.
//  Copyright (c) 2013年 NetEase Corp. All rights reserved.
//

#import "NEMultiImagePickerController.h"
#import "NEAsset.h"
#import "NEAssetCell.h"
#import "NEAssetPickerController.h"
#import "NEAlbumPickerController.h"

@implementation NEMultiImagePickerController

@synthesize delegate;

-(void)cancelImagePicker {
	if([delegate respondsToSelector:@selector(multiImagePickerControllerDidCancel:)]) {
		[delegate performSelector:@selector(multiImagePickerControllerDidCancel:) withObject:self];
	}
}

-(void)selectedAssets:(NSArray*)_assets {

	NSMutableArray *returnArray = [[[NSMutableArray alloc] init] autorelease];
	
	for(ALAsset *asset in _assets) {

		NSMutableDictionary *workingDictionary = [[NSMutableDictionary alloc] init];
		[workingDictionary setObject:[asset valueForProperty:ALAssetPropertyType] forKey:@"UIImagePickerControllerMediaType"];
        [workingDictionary setObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]] forKey:@"UIImagePickerControllerOriginalImage"];
		[workingDictionary setObject:[[asset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[asset valueForProperty:ALAssetPropertyURLs] allKeys] objectAtIndex:0]] forKey:@"UIImagePickerControllerReferenceURL"];
		
		[returnArray addObject:workingDictionary];
		
		[workingDictionary release];	
	}
	
    [self popToRootViewControllerAnimated:NO];
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
    
	if([delegate respondsToSelector:@selector(multiImagePickerController:didFinishPickingMediaWithInfo:)]) {
		[delegate performSelector:@selector(multiImagePickerController:didFinishPickingMediaWithInfo:) withObject:self withObject:[NSArray arrayWithArray:returnArray]];
	}
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];
}

@end
