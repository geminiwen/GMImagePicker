//
//  GMImagePickerViewController.m
//  GMImagePicker
//
//  Created by 温盛章 on 16/3/23.
//  Copyright © 2016年 Gemini. All rights reserved.
//

#import "GMImagePickerController.h"
#import "GMAlbumsViewController.h"

@interface GMImagePickerController ()

@property (nonatomic, strong) UINavigationController *albumsNavigationController;

@property (nonatomic, strong) NSBundle *assetBundle;

@end



@implementation GMImagePickerController

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        // Set default values
        self.assetCollectionSubtypes = @[
                                         @(PHAssetCollectionSubtypeSmartAlbumUserLibrary),
                                         @(PHAssetCollectionSubtypeAlbumMyPhotoStream),
                                         @(PHAssetCollectionSubtypeSmartAlbumPanoramas),
                                         @(PHAssetCollectionSubtypeSmartAlbumVideos),
                                         @(PHAssetCollectionSubtypeSmartAlbumBursts)
                                         ];
        self.minimumNumberOfSelection = 1;
        self.numberOfColumnsInPortrait = 4;
        self.numberOfColumnsInLandscape = 7;
        
        _selectedAssets = [NSMutableOrderedSet orderedSet];
        
        // Get asset bundle
        self.assetBundle = [NSBundle bundleForClass:[self class]];
        NSString *bundlePath = [self.assetBundle pathForResource:@"GMImagePicker" ofType:@"bundle"];
        if (bundlePath) {
            self.assetBundle = [NSBundle bundleWithPath:bundlePath];
        }
        
        [self setUpAlbumsViewController];
        
        // Set instance
        GMAlbumsViewController *albumsViewController = (GMAlbumsViewController *)self.albumsNavigationController.topViewController;
        albumsViewController.imagePickerController = self;
    }
    
    return self;
}

- (void)setUpAlbumsViewController
{
    // Add QBAlbumsViewController as a child
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"GMImagePicker" bundle:self.assetBundle];
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"GMAlbumsNavigationController"];
    
    [self addChildViewController:navigationController];
    
    navigationController.view.frame = self.view.bounds;
    [self.view addSubview:navigationController.view];
    
    [navigationController didMoveToParentViewController:self];
    
    self.albumsNavigationController = navigationController;
}


@end
