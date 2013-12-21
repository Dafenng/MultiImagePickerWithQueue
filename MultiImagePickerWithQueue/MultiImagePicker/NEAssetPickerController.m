//
//  NEAssetPickerController.m
//  CityDate
//
//  Created by Dafeng Jin on 13-3-18.
//  Copyright (c) 2013年 NetEase Corp. All rights reserved.
//

#import "NEAssetPickerController.h"
#import "NEAssetCell.h"
#import "NEAsset.h"
#import "NEAlbumPickerController.h"

#define PhotoTableViewTag 1001
#define ChosenPhotoTableViewTag 1002

@implementation NEAssetPickerController

@synthesize parent;
@synthesize assetGroup, assets;

-(void)viewDidLoad {
    
    self.chosenPhotoTableView.frame = CGRectMake(118, -118, 84, 320);
    self.chosenPhotoTableView.transform	= CGAffineTransformMakeRotation(-M_PI/2);
    self.chosenPhotoTableView.backgroundColor = [UIColor grayColor];

	[self.photosTableView setSeparatorColor:[UIColor clearColor]];
	[self.photosTableView setAllowsSelection:NO];
    
    NSMutableArray *tmpAssets = [[NSMutableArray alloc] init];
    self.assets = tmpAssets;
    [tmpAssets release];
    
	UIBarButtonItem *doneButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)] autorelease];
	[self.navigationItem setRightBarButtonItem:doneButtonItem];
	[self.navigationItem setTitle:@"加载中..."];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self preparePhotos];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.photosTableView reloadData];
            [self.chosenPhotoTableView reloadData];
            [self.navigationItem setTitle:@"选取照片"];
        });
    });

}

-(void)preparePhotos {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    [self.assetGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) 
     {         
         if(result == nil) 
         {
             return;
         }
         
         NEAsset *asset = [[[NEAsset alloc] initWithAsset:result] autorelease];
         [asset setParent:self];
         [self.assets addObject:asset];
     }];
	
    NSMutableArray *tmpChosenAssets = [[NSMutableArray alloc] initWithArray:self.chosenAssets];
    [tmpChosenAssets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NEAsset *chosenAsset = (NEAsset *)obj;
        NSUInteger assetIndex = idx;
        [self.assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([chosenAsset isEqual:(NEAsset *)obj]) {
                [self.chosenAssets replaceObjectAtIndex:assetIndex withObject:obj];
                *stop = YES;
            }
        }];
    }];
    
    [self.chosenAssets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(NEAsset *)obj setParent:self];
    }];
    
    [pool release];
}

- (BOOL)isAssetContained:(NEAsset *)asset
{
    __block BOOL contained = NO;
    [self.chosenAssets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([(NEAsset *)obj isEqual:asset]) {
            contained = YES;
            *stop = YES;
        }
    }];
    
    return contained;
}

- (void)addAsset:(NEAsset *)asset
{
    if (![self isAssetContained:asset]) {
        [self.chosenAssets addObject:asset];
//        [(NEAlbumPickerController *)self.parent addAsset:asset];
        [self.chosenPhotoTableView reloadData];
        NSIndexPath *ipath = [NSIndexPath indexPathForRow:[self.chosenAssets count] - 1 inSection:0];
        [self.chosenPhotoTableView scrollToRowAtIndexPath:ipath atScrollPosition: UITableViewScrollPositionTop animated:YES];
    }
}

- (void)removeAsset:(NEAsset *)asset
{
    if ([self isAssetContained:asset]) {
        [self.chosenAssets removeObject:asset];
//        [(NEAlbumPickerController *)self.parent removeAsset:asset];
        [self.chosenPhotoTableView reloadData];
    }
}

- (void)doneAction:(id)sender {
	
    [(NEAlbumPickerController*)self.parent selectedAssets];
}

#pragma mark UITableViewDataSource Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (tableView.tag) {
        case PhotoTableViewTag:
            return ceil([self.assetGroup numberOfAssets] / 4.0);
            break;
        case ChosenPhotoTableViewTag:
            return [self.chosenAssets count];
            break;
        default:
            break;
    }
    return 0;
}

- (NSArray*)assetsForIndexPath:(NSIndexPath*)indexPath {
    
	int index = (indexPath.row*4);
	int maxIndex = (indexPath.row*4+3);
    
	if(maxIndex < [self.assets count]) {
        
		return [NSArray arrayWithObjects:[self.assets objectAtIndex:index],
				[self.assets objectAtIndex:index+1],
				[self.assets objectAtIndex:index+2],
				[self.assets objectAtIndex:index+3],
				nil];
	}
    
	else if(maxIndex-1 < [self.assets count]) {
        
		return [NSArray arrayWithObjects:[self.assets objectAtIndex:index],
				[self.assets objectAtIndex:index+1],
				[self.assets objectAtIndex:index+2],
				nil];
	}
    
	else if(maxIndex-2 < [self.assets count]) {
        
		return [NSArray arrayWithObjects:[self.assets objectAtIndex:index],
				[self.assets objectAtIndex:index+1],
				nil];
	}
    
	else if(maxIndex-3 < [self.assets count]) {
        
		return [NSArray arrayWithObject:[self.assets objectAtIndex:index]];
	}
    
	return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (tableView.tag) {
        case PhotoTableViewTag:
        {
            static NSString *CellIdentifier = @"PhotoCell";
            
            NEAssetCell *cell = (NEAssetCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil)
            {
                cell = [[[NEAssetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            }
            [cell setAssets:[self assetsForIndexPath:indexPath]];
            
            return cell;
        }
            break;
        case ChosenPhotoTableViewTag:
        {
            static NSString *CellIdentifier = @"ChosenCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            }
            NEAsset *selectedAsset = (NEAsset *)[self.chosenAssets objectAtIndex:indexPath.row];
            selectedAsset.selected = YES;
            
            NEAsset *asset = [[NEAsset alloc] initWithAsset:[selectedAsset asset]];
            asset.frame = CGRectMake(6, 6, 72, 72);
            asset.transform = CGAffineTransformMakeRotation(M_PI/2);
            [cell.contentView addSubview:asset];
            [asset release];
            
            UIImageView *overlayView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 60, 24, 24)];
            [overlayView setImage:[UIImage imageNamed:@"multiimage_delete.png"]];
            overlayView.transform = CGAffineTransformMakeRotation(M_PI/2);
            [cell.contentView addSubview:overlayView];
            [overlayView release];
            
            [cell addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:selectedAsset action:@selector(toggleDeselection)] autorelease]];
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	switch (tableView.tag) {
        case PhotoTableViewTag:
            return 79;
            break;
        case ChosenPhotoTableViewTag:
            return 84;
            break;
        default:
            break;
    }
    return 0;
}

- (int)totalSelectedAssets {
    
    int count = 0;
    
    for(NEAsset *asset in self.assets) 
    {
		if([asset selected]) 
        {            
            count++;	
		}
	}
    
    return count;
}

- (void)dealloc 
{
    [assets release];
    [_photosTableView release];
    [_chosenPhotoContainerView release];
    [super dealloc];    
}

- (void)viewDidUnload {
    [self setPhotosTableView:nil];
    [self setChosenPhotoContainerView:nil];
    [super viewDidUnload];
}
@end
