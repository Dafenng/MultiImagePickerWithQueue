//
//  ALAsset+Equal.m
//  MultiImagePickerWithQueue
//
//  Created by Dafeng Jin on 13-10-28.
//  Copyright (c) 2013年 NetEase. All rights reserved.
//

#import "ALAsset+Equal.h"


@implementation ALAsset (Equal)

- (NSURL*)defaultURL {
//    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
//    {
//        return [self valueForKey: ALAssetPropertyAssetURL];
//    }
//    else
//    {
        return self.defaultRepresentation.url;
//    }
}

- (BOOL)isEqual:(id)obj {
    if(![obj isKindOfClass:[ALAsset class]])
        return NO;
    
    NSURL *u1 = [self defaultURL];
    NSURL *u2 = [obj defaultURL];
    
    return ([u1 isEqual:u2]);
}

@end
