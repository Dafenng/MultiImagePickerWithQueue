//
//  ViewController.m
//  MultiImagePickerWithQueue
//
//  Created by Dafeng Jin on 13-4-22.
//  Copyright (c) 2013年 NetEase. All rights reserved.
//

#import "ViewController.h"
#import "NEAlbumPickerController.h"
#import "NEMultiImagePickerController.h"

@interface ViewController ()

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_scrollView release];
    [super dealloc];
}

- (IBAction)togglePicker:(id)sender {
    NEAlbumPickerController *albumController = [[NEAlbumPickerController alloc] initWithNibName:@"NEAlbumPickerController" bundle:[NSBundle mainBundle]];
	NEMultiImagePickerController *multiPicker = [[NEMultiImagePickerController alloc] initWithRootViewController:albumController];
    [albumController setParent:multiPicker];
	[multiPicker setDelegate:self];
    
    [self presentViewController:multiPicker animated:YES completion:nil];
    [multiPicker release];
    [albumController release];
}

#pragma mark NEMultiImagePickerControllerDelegate Methods

- (void)multiImagePickerController:(NEMultiImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
	
	if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]){
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissModalViewControllerAnimated:YES];
    }
	
    for (UIView *v in [_scrollView subviews]) {
        [v removeFromSuperview];
    }
    
	CGRect workingFrame = _scrollView.frame;
	workingFrame.origin.x = 0;
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
	
	for(NSDictionary *dict in info) {
        
        UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
        [images addObject:image];
        
		UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
		[imageview setContentMode:UIViewContentModeScaleAspectFit];
		imageview.frame = workingFrame;
		
		[_scrollView addSubview:imageview];
		[imageview release];
		
		workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width;
	}
	
	[_scrollView setPagingEnabled:YES];
	[_scrollView setContentSize:CGSizeMake(workingFrame.origin.x, workingFrame.size.height)];
}

- (void)multiImagePickerControllerDidCancel:(NEMultiImagePickerController *)picker {
    
	if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]){
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissModalViewControllerAnimated:YES];
    }
}

@end
